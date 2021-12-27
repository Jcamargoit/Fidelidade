//
//  ChangePasswordViewController.swift
//  Fidelidade
//
//  Created by Juninho on 24/12/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var confirmPasswor: UITextField!
    
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
    
    @IBAction func toUpdate(_ sender: UIButton) {
    }
    
}
