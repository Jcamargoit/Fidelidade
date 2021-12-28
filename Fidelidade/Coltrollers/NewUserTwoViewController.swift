//
//  NewUserViewController.swift
//  Fidelidade
//
//  Created by Juninho on 15/12/21.
//

import UIKit

class NewUserTwoViewController: UIViewController, UITextFieldDelegate {
    
    var nomeCompleto = String()
    var email = String()
    var cpf = String()

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfAdress: UITextField!{
        didSet{
            self.tfAdress.delegate = self
            self.tfAdress.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        }
    }
    
    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    
    
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
            self.view.frame.origin.y += 150
            self.numeros = 0
            self.verificacao = ""
        }
        //ID QUE QUER SUBIR A TELA
        self.tfAdress.resignFirstResponder()
    }

    //Função pra descer a tela com o teclado
    @objc func myTargetFunction(textField: UITextField) {
        self.numeros =  self.numeros + 1
        if self.numeros == 1 {
            self.verificacao = "sim"
            self.view.frame.origin.y -= 150
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func register(_ sender: UIButton) {
        
        
        if tfPassword.text!.isEmpty{
            simplePopUp(title: "", mensage: "É necessário digitar a senha")
        }else  if tfConfirmPassword.text!.isEmpty{
            simplePopUp(title: "", mensage: "É necessário confirmar a senha")
        }else  if tfAdress.text!.isEmpty{
            simplePopUp(title: "", mensage: "Necessário digitar o cpf")
        }else{
            if self.tfPassword.text == self.tfConfirmPassword.text {
                simplePopUp(title: "", mensage: "Cadastro efetuado com sucesso")
                self.performSegue(withIdentifier: "openHomeFromNewUser", sender: self)
            }else{
                simplePopUp(title: "Atenção", mensage: "Senhas não conferem")
            }
        }
        
        
        
    }
    
    
    @IBAction func state(_ sender: UIButton) {
        
    }
    
    
    @IBAction func city(_ sender: UIButton) {
        
    }
    
    
}
