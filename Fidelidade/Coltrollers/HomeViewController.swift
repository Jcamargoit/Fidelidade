//  Created by Juninho on 26/11/21.

import UIKit
import Charts

class HomeViewController: UIViewController, UIScrollViewDelegate {
    let dataPoints = ["Dez", "Dez", "Dez", "Dez", "Dez", "Dez", "Dez", "Dez", "Dez", "Dez"]
    let values = [15.0, 25.0, 12.0, 12.0, 25.0, 25.0, 5.0, 27.0, 4.0, 12.0]
    
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
        
        //Instanciar meu Delegate Scroll
        mySv.isDirectionalLockEnabled = true
        mySv.delegate = self
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
    
    private func customizeChart(dataPoints: [String], values: [Double]) {
        mainChart.chartDescription?.enabled = false
        mainChart.pinchZoomEnabled = false
        mainChart.drawBarShadowEnabled = false
        mainChart.legend.enabled = false
        mainChart.backgroundColor = UIColor(displayP3Red: 61, green: 89, blue: 171, alpha: 0.25)
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: nil)
        let chartData = BarChartData(dataSet: chartDataSet)
        mainChart.data = chartData
    }
    
}

