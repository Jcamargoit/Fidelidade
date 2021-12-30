//  WithdrawPixViewController.swift
//  Fidelidade
//  Created by Juninho on 23/12/21.

import UIKit

class WithdrawPixResultViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lbAvailableValue: UILabel!
    @IBOutlet weak var tfvalue: UITextField!{
        didSet{
            self.tfvalue.delegate = self
            //UpScreen
            self.tfvalue.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        }
    }
    
         var verificacao = String ()
          var numeros = Int ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
  
        // UpScreen - GERAL, NÃO PRECISA Declarar cada id
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func withdraw(_ sender: UIButton) {
    }
    

    
    //UpScreen
    @objc func myTargetFunction(textField: UITextField) {
        
        self.numeros =  self.numeros + 1
        
        
        if self.numeros == 1 {
            
            print("entrei nesse ")
            
            self.verificacao = "sim"
            self.view.frame.origin.y -= 100
        }
        
    }
    
    //UpScreen
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
       
        if self.verificacao == "sim" {
            // if view.frame.origin.y != 0 {
            self.view.frame.origin.y += 100
            self.numeros = 0
            self.verificacao = ""
            //    }
        }
        //TODOS ID'S QUE QUER SUBIR A TELA
        self.tfvalue.resignFirstResponder()

    }
    
    
    
    
}
