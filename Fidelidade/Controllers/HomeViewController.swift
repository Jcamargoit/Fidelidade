//  Created by Juninho on 26/11/21.

import UIKit
import Charts
import Observable


class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    let dataPoints = ["1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez"]
    let values = [15.0, 25.0, 12.0, 12.0, 25.0, 25.0, 5.0, 27.0, 4.0, 12.0]
    private var maxValueChart = 5
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor : UIColor(red: (189/255), green: (255/255), blue: (0/255), alpha: 1.0),
        NSAttributedString.Key.strokeWidth : -5.0]
    as [NSAttributedString.Key : Any]
    
    @IBOutlet weak var mySv: UIScrollView!
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBalancePoints: UILabel!{
        didSet{
            lbBalancePoints.attributedText = NSMutableAttributedString(string: " ", attributes: strokeTextAttributes)
        }
    }
    @IBOutlet weak var btnExchange: UIButton!
    @IBOutlet weak var lbBalanceMoney: UILabel!
    @IBOutlet weak var btnConverter: UIButton!
    @IBOutlet weak var sc: UISegmentedControl!
    @IBOutlet weak var mainChart: BarChartView!
    
    lazy var walletViewModel = WalletViewModel()
    private var disposal = Disposal()
    var refreshControl: UIRefreshControl!
    
    var converterValueToCurrency = ConvertValuesToCurrency()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observerse()
        sc.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        //Instanciar meu Delegate Scroll
        mySv.isDirectionalLockEnabled = true
        mySv.delegate = self
        styleElements()
        customizeChart(dataPoints: dataPoints, values: values)
        walletViewModel.fetchWallets()
        //refresh Scrool/ tableView
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red: 25/255, green: 25/255, blue: 112/255, alpha: 1.0)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        mySv.addSubview(refreshControl)
    }
    
    
    func observerse(){
        walletViewModel.moneyWallet.observe(DispatchQueue.main) { [weak self] result, oldValue in
            
            self!.refreshControl.endRefreshing()
            
            guard let result = result else{
                return
            }
            
            if !result.isError {
           
                self?.lbBalanceMoney.text = self?.converterValueToCurrency.convertValuesToCurrency(value: Double(result.data?.amount ?? 0))
                
            }else{
                self?.simplePopUp(title: "Erro", mensage: result.error)
                
            }
            
        }.add(to: &disposal)
        
        walletViewModel.pointsWallet.observe(DispatchQueue.main) { [weak self] result, oldValue in
            
            guard let result = result else{
                
                return
            }
            
            if !result.isError {
                
                self?.lbBalancePoints.text = self?.converterValueToCurrency.convertValuesToCurrency(value: Double(result.data?.amount ?? 0))
                
            }else{
                self?.simplePopUp(title: "Erro", mensage: result.error)
            }
        }.add(to: &disposal)
    }
    
    //remove navegation controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func tappedExchangeButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "openExchangeFromHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
              let addCoffeeOrderVC = navC.viewControllers.first as? ExchangeValuesViewController else{
                  fatalError("Error performing segue!")
              }
        
        addCoffeeOrderVC.delegate = self
    }
    
    //Função para o Scroll não ir pro lado
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    private func styleElements() {
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(named: "Main Blue") ?? .blue], for: .normal)
        sc.layer.borderWidth = 1
        sc.layer.borderColor = UIColor(named: "Main Blue")?.cgColor
        sc.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            maxValueChart = 5
            customizeChart(dataPoints: dataPoints, values: values)
        } else if sender.selectedSegmentIndex == 1 {
            maxValueChart = 10
            customizeChart(dataPoints: dataPoints, values: values)
        } else if sender.selectedSegmentIndex == 2 {
            maxValueChart = 30
            customizeChart(dataPoints: dataPoints, values: values)
        }
    }
    
    private func customizeChart(dataPoints: [String], values: [Double]) {
        mainChart.chartDescription?.enabled = false
        mainChart.pinchZoomEnabled = false
        mainChart.drawBarShadowEnabled = false
        mainChart.legend.enabled = false
        mainChart.chartDescription?.enabled = false
        mainChart.isUserInteractionEnabled = false
        let color = UIColor(named: "Blue charts lite")
        mainChart.backgroundColor = color
        let xAxis = mainChart.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        let rightAxis = mainChart.rightAxis
        rightAxis.enabled = false
        let leftAxis = mainChart.leftAxis
        leftAxis.axisMinimum = 0.0
        
        var dataEntries: [BarChartDataEntry] = []
        let comparator = maxValueChart < dataPoints.count ? maxValueChart : dataPoints.count
        for i in 0..<comparator{
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        var barColours = [UIColor]()
        barColours.append(UIColor(named: "Main Blue") ?? .blue)
        barColours.append(.white)
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: nil)
        chartDataSet.colors = barColours
        chartDataSet.barBorderColor = UIColor(named: "Main Blue") ?? .blue
        chartDataSet.barBorderWidth = 1
        let chartData = BarChartData(dataSet: chartDataSet)
        mainChart.data = chartData
        mainChart.animate(yAxisDuration: 1.5)
    }
    
    @objc func refresh(_ sender: Any) {
        //  your code to reload tableView
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.walletViewModel.fetchWallets()
        }
    }
}

extension HomeViewController: UpdateValuesDelegate {
    func updateValue() {
        walletViewModel.fetchWallets()
        self.simplePopUp(title: "", mensage: "Conversão efetuada com sucesso!")
    }
}
