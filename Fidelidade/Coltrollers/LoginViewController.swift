//
//  LoginViewController.swift
//  Fidelidade
//
//  Created by Juninho on 15/12/21.
//

import UIKit
import Observable


class LoginViewController: UIViewController {

    @IBOutlet weak var tfCPF: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    private var disposal = Disposal()
    
    var loginViewModel = LoginViewModel()
    let loadingVC = LoadingViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observerse()
        

//        // Animate loadingVC over the existing views on screen
//        loadingVC.modalPresentationStyle = .overCurrentContext
//
//        // Animate loadingVC with a fade in animation
//        loadingVC.modalTransitionStyle = .crossDissolve
//
//        present(loadingVC, animated: true, completion: nil)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logIn(_ sender: UIButton) {

        guard let cpf = tfCPF.text else {
       simplePopUp(title: "Erro", mensage: "O campo CPF é obrigatório")
            return
        }
        guard let password = tfSenha.text else {
            simplePopUp(title: "Erro", mensage: "O campo Senha é obrigatório")
            return
        }

        let loginModel = LoginModel(cpf: cpf, password: password)
        loginViewModel.handleLogin(loginModel: loginModel)
    }
    
    
    
    
    
    
    
    
    func observerse (){
        
        loginViewModel.isLogged.observe(DispatchQueue.main) { [weak self] result, oldValue in
            guard let result = result else{
                return
            }
            if !result.isError {
        
                self?.performSegue(withIdentifier: "openHome", sender: self)
                
            }else{
                self?.simplePopUp(title: "Erro", mensage: result.error)
            }
        }.add(to: &disposal)
    }
}



extension UIViewController {
    func simplePopUp(title:String, mensage:String) {
        let alert = UIAlertController(title: "Erro", message: "Erro ao logar", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
