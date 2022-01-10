//
//  ExchangeValuesViewController.swift
//  Fidelidade
//
//  Created by Juninho on 27/12/21.
//

import UIKit
import Observable

class ExchangeValuesViewController: UIViewController {
    
    @IBOutlet weak var btnExchange: UIButton!
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor : UIColor(red: (189/255), green: (255/255), blue: (0/255), alpha: 1.0),
        NSAttributedString.Key.strokeWidth : -5.0]
    as [NSAttributedString.Key : Any]
    
    lazy var walletViewModel = WalletViewModel()
    lazy var walletTransferViewModel = WalletTransferViewModel()
    
    
    @IBOutlet weak var btnCancelExchange: UIButton!{
        didSet{
            self.btnCancelExchange.layer.borderColor = UIColor(red: (38/255), green: (47/255), blue: (143/255), alpha: 1.0).cgColor
        }
    }
    @IBOutlet weak var lbBalanceInCoins: UILabel!
    
    @IBOutlet weak var tfNumberOfCoins: UITextField!
    @IBOutlet weak var lbBalanceInReal: UILabel!
    
    private var disposal = Disposal()
    
    
    var test = 100000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observerse()
        walletViewModel.fetchWalletsById(walletType: WalletType.Points)
        
    }
    
    
    func observerse(){
        
        
        walletViewModel.pointsWallet.observe(DispatchQueue.main) { [weak self] result, oldValue in
            
            guard let result = result else{
                return
            }
            
            if !result.isError {
                self?.lbBalanceInCoins.attributedText = NSMutableAttributedString(string: String(describing: result.data?.amount ?? 0), attributes: self?.strokeTextAttributes)
            }else{
                self?.simplePopUp(title: "Erro", mensage: result.error)
            }
        }.add(to: &disposal)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func tappedToConverter(_ sender: UIButton) {
        converterPointsToReal()
    }
    
    
    func converterPointsToReal(){
        
        let numberOfCoins = Int(tfNumberOfCoins.text ?? "") ?? 0
        
        if numberOfCoins > Int(lbBalanceInCoins.text ?? "") ?? 0 {
            simplePopUp(title: "Atenção", mensage: "Você não pode converter um saldo maior do que está disponível em sua conta")
        }else{
         //   var resultConverter: Int
            let resultConverter = numberOfCoins/100
            let  balanceInReal = String(resultConverter)
            lbBalanceInReal.text = "R$\(balanceInReal),00"

        }
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func toExchange(_ sender: UIButton) {
         print("Modelo")
    }
    
    
    
    func exchangePoints(){
        
        
    }
    
    
    @IBAction func cancelExchange(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
