//  Created by Juninho on 26/11/21.

import UIKit
import Charts

class HomeViewController: UIViewController, UIScrollViewDelegate {
    let dataPoints = ["1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez", "1 Dez"]
    let values = [15.0, 25.0, 12.0, 12.0, 25.0, 25.0, 5.0, 27.0, 4.0, 12.0]
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor : UIColor(named: "Main Blue") ?? .blue,
        NSAttributedString.Key.strokeWidth : -5.0]
    as [NSAttributedString.Key : Any]
    
    @IBOutlet weak var mySv: UIScrollView!
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbExchange: UILabel!{
        didSet{
            lbExchange.attributedText = NSMutableAttributedString(string: "500", attributes: strokeTextAttributes)
        }
    }
    @IBOutlet weak var btnExchange: UIButton!
    @IBOutlet weak var lbConverter: UILabel!
    @IBOutlet weak var btnConverter: UIButton!
    @IBOutlet weak var sc: UISegmentedControl!
    @IBOutlet weak var mainChart: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sc.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        //Instanciar meu Delegate Scroll
        mySv.isDirectionalLockEnabled = true
        mySv.delegate = self
        styleElements()
        customizeChart(dataPoints: dataPoints, values: values)
    }
    
    //remove navegation controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
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
            print("Select 0")
        } else if sender.selectedSegmentIndex == 1 {
            print("Select 1")
        } else if sender.selectedSegmentIndex == 2 {
            print("Select 2")
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
        
        for i in 0..<dataPoints.count {
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
    
}

