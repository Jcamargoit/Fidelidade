//
//  LoginViewController.swift
//  Fidelidade
//
//  Created by Juninho on 15/12/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfCPF: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    
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
    

}
