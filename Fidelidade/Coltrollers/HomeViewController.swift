//  Created by Juninho on 26/11/21.

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    

    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Instanciar meu Delegate Scroll
        mySv.isDirectionalLockEnabled = true
        mySv.delegate = self
    }
    
    
    
    //Função para o Scroll não ir pro lado
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    
    //remove navegation controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

