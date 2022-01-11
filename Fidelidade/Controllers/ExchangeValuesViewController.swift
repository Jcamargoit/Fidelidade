//
//  ExchangeValuesViewController.swift
//  Fidelidade
//
//  Created by Juninho on 27/12/21.
//

import UIKit
import Observable


protocol UpdateValuesDelegate{
    func updateValue()
}


class ExchangeValuesViewController: UIViewController {
    
    var delegate: UpdateValuesDelegate?
    
    @IBOutlet weak var btnExchange: UIButton!
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor : UIColor(red: (189/255), green: (255/255), blue: (0/255), alpha: 1.0),
        NSAttributedString.Key.strokeWidth : -5.0]
    as [NSAttributedString.Key : Any]
    
    lazy var walletViewModel = WalletViewModel()
    private var walletTransferViewModel = WalletTransferViewModel()
    
    
    @IBOutlet weak var btnCancelExchange: UIButton!{
        didSet{
            self.btnCancelExchange.layer.borderColor = UIColor(red: (38/255), green: (47/255), blue: (143/255), alpha: 1.0).cgColor
        }
    }
    @IBOutlet weak var lbBalanceInCoins: UILabel!{
        didSet{
            lbBalanceInCoins.attributedText = NSMutableAttributedString(string: " ", attributes: strokeTextAttributes)
        }
    }
    
    @IBOutlet weak var tfNumberOfCoins: UITextField!{
        didSet{
            self.tfNumberOfCoins.delegate = self
        }
    }
    @IBOutlet weak var lbBalanceInReal: UILabel!
    
    private var disposal = Disposal()
    
    var converterValueToCurrency = ConvertValuesToCurrency()
    
    private var walletTotalPoints = 0

    var verificationExchange = Bool()
    
    
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
            self?.walletTotalPoints = result.data?.amount ?? 0
            
            if !result.isError {
                self?.lbBalanceInCoins.text = self?.converterValueToCurrency.convertValuesToCurrency(value: Double(result.data?.amount ?? 0))
                
                //
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
        //iniciar alguma ação com um pouco de atraso
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let numberOfCoins = Int(self.tfNumberOfCoins.text ?? "") ?? 0
            
            print("meu texto ", self.tfNumberOfCoins.text ?? "")
            
            if numberOfCoins > Int(self.walletTotalPoints){
                self.simplePopUp(title: "Atenção", mensage: "Você não pode converter um saldo maior do que está disponível em sua conta")
            }else{
                let resultConverter = numberOfCoins/100
                let  balanceInReal = String(resultConverter)
                self.lbBalanceInReal.text = "R$\(balanceInReal),00"
                self.btnExchange.backgroundColor = UIColor(red: (25/255), green: (25/255), blue: (112/255), alpha: 1.0)
                self.btnExchange.isUserInteractionEnabled = true
            }
        }
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func toExchange(_ sender: UIButton) {
         print("Modelo")
        
        let walletTransferModel = WalletTransferModel(walletOriginId: WalletType.Points.rawValue, walletTargetId: WalletType.Money.rawValue, quantity: Int(tfNumberOfCoins.text ?? "") ?? 0)
        walletTransferViewModel.transferWallets(walletTransfer: walletTransferModel)
        
        walletTransferViewModel.transferWallet.observe(DispatchQueue.main) { [weak self] result, oldValue in
         
            guard let result = result else{
                return
            }
      
            if !result.isError {
                if let delegate = self?.delegate {
                    delegate.updateValue()
                    self?.dismiss(animated: true, completion: nil)
                }
                
            }else{
                self?.simplePopUp(title: "Atenção", mensage: "Não foi possível fazer sua conversão, tente novamente")
            }
        }.add(to: &disposal)
    
    }
    
    
    @IBAction func cancelExchange(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}


extension ExchangeValuesViewController: UITextFieldDelegate {
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text ?? "").count + string.count - range.length
        if newLength <= 0 {
            btnExchange.isUserInteractionEnabled = false
        btnExchange.backgroundColor = UIColor(red: (231/255), green: (232/255), blue: (243/255), alpha: 1.0)
        }else{
            converterPointsToReal()
        }
      
        return true
    }
}
