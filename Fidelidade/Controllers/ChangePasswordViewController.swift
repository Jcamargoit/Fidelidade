//
//  ChangePasswordViewController.swift
//  Fidelidade
//
//  Created by Juninho on 24/12/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!{
        didSet{
            self.tfNewPassword.delegate = self
            self.tfNewPassword.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        }
    }
    @IBOutlet weak var tfConfirmPasswor: UITextField!{
        didSet{
            self.tfConfirmPasswor.delegate = self
            self.tfConfirmPasswor.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        }
    }
    
    var verificacao = String ()
    var numeros = Int ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Função pra subir a tela com o teclado
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //Função pra subir a tela com o teclado
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        if self.verificacao == "sim" {
            self.view.frame.origin.y += 100
            self.numeros = 0
            self.verificacao = ""
        }
        //ID QUE QUER SUBIR A TELA
        self.tfNewPassword.resignFirstResponder()
        self.tfConfirmPasswor.resignFirstResponder()
    }
    
    //Função pra descer a tela com o teclado
    @objc func myTargetFunction(textField: UITextField) {
        self.numeros =  self.numeros + 1
        if self.numeros == 1 {
            self.verificacao = "sim"
            self.view.frame.origin.y -= 100
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toUpdate(_ sender: UIButton) {
    }
    
    func verificationTextField(){
        if tfPassword.text!.isEmpty{
            // simplePopUp(title: "", mensage: "É necessário digitar a senha")
        }else  if tfNewPassword.text!.isEmpty{
            // simplePopUp(title: "", mensage: "É necessário digitar o e-mail")
        }else  if tfConfirmPasswor.text!.isEmpty{
            //  simplePopUp(title: "", mensage: "Necessário digitar o cpf")
        }else{
            
            if self.tfNewPassword.text == self.tfConfirmPasswor.text {
                simplePopUp(title: "", mensage: "Senha alterada com sucesso")
            }else{
                simplePopUp(title: "Atenção", mensage: "Senhas não conferem")
            }
        }
    }
    
    
}

extension ChangePasswordViewController: UITextFieldDelegate {
    // Clicar em qualquer lugar da tela e excultar a ação
    func textFieldDidEndEditing(_ textField: UITextField) {
        verificationTextField()
    }
    
    
}
