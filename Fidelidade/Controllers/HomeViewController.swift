//  Created by Juninho on 26/11/21.

import UIKit
import Charts

class HomeViewController: UIViewController, UIScrollViewDelegate {
    let dataPoints = ["1 Dez", "2 Dez", "3 Dez", "4 Dez", "5 Dez"]
    let values = [15.0, 25.0, 12.0, 12.0, 25.0]
    
    
    let dataPoints1 = ["1 Dez", "2 Dez", "3 Dez", "4 Dez", "5 Dez", "6 Dez", "7 Dez", "8 Dez", "9 Dez", "10 Dez"]
    let values1 = [10.0, 15.0, 22.0, 2.0, 20.0, 18.0, 9.0, 19.0, 10.0, 20.0]
    
    let dataPoints2 = ["1 Dez", "2 Dez", "3 Dez", "4 Dez", "5 Dez", "6 Dez", "7 Dez", "8 Dez", "9 Dez", "10 Dez", "11 Dez", "12 Dez", "13 Dez", "14 Dez", "15 Dez", "16 Dez", "17 Dez", "18 Dez", "19 Dez", "20 Dez", "21 Dez", "22 Dez", "23 Dez", "24 Dez", "25 Dez", "26 Dez", "27 Dez", "28 Dez", "29 Dez", "30 Dez"]
    let values2 = [15.0, 25.0, 12.0, 12.0, 25.0, 25.0, 5.0, 27.0, 4.0, 12.0, 15.0, 25.0, 12.0, 12.0, 25.0, 25.0, 5.0, 27.0, 4.0, 12.0, 15.0, 25.0, 12.0, 12.0, 25.0, 25.0, 5.0, 27.0, 4.0, 12.0]
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor : UIColor(red: (189/255), green: (255/255), blue: (0/255), alpha: 1.0),
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
            customizeChart(dataPoints: dataPoints, values: values)
        } else if sender.selectedSegmentIndex == 1 {
            print("Select 1")
            customizeChart(dataPoints: dataPoints1, values: values1)
        } else if sender.selectedSegmentIndex == 2 {
            print("Select 2")
            customizeChart(dataPoints: dataPoints2, values: values2)
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

