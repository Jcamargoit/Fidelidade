//
//  NewUserViewController.swift
//  Fidelidade
//
//  Created by Juninho on 15/12/21.
//

import UIKit

class NewUserViewController: UIViewController {
    
    @IBOutlet weak var tfNomeCompleto: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfCpf: UITextField!
    
    
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
    
    
    @IBAction func next(_ sender: UIButton) {
        self.performSegue(withIdentifier: "abrir", sender: self)
    }
    
}

