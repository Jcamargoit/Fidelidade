//
//  ExchangeValuesViewController.swift
//  Fidelidade
//
//  Created by Juninho on 27/12/21.
//

import UIKit

class ExchangeValuesViewController: UIViewController {
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor : UIColor(red: (189/255), green: (255/255), blue: (0/255), alpha: 1.0),
        NSAttributedString.Key.strokeWidth : -5.0]
    as [NSAttributedString.Key : Any]
    
    @IBOutlet weak var btnCancelExchange: UIButton!{
        didSet{
            self.btnCancelExchange.layer.borderColor = UIColor(red: (38/255), green: (47/255), blue: (143/255), alpha: 1.0).cgColor
        }
    }
    @IBOutlet weak var lbBalanceInCoins: UILabel!{
        didSet{
            lbBalanceInCoins.attributedText = NSMutableAttributedString(string: "500", attributes: strokeTextAttributes)
        }
    }
    
    @IBOutlet weak var tfNumberOfCoins: UITextField!
    @IBOutlet weak var lbBalanceInReais: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func toExchange(_ sender: UIButton) {
    }
    
    
    @IBAction func cancelExchange(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
