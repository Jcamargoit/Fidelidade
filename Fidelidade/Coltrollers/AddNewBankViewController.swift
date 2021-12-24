//
//  AddNewBankViewController.swift
//  Fidelidade
//
//  Created by Juninho on 24/12/21.
//

import UIKit

class AddNewBankViewController: UIViewController {
    
    @IBOutlet weak var ivPix: UIImageView!
    @IBOutlet weak var ivTed: UIImageView!
    
    @IBOutlet weak var tfAgency: UITextField!
    @IBOutlet weak var tfAccount: UITextField!
    @IBOutlet weak var tfCpf: UITextField!
    @IBOutlet weak var tfFullName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func back(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func pix(_ sender: UIButton) {
        self.ivPix.image = UIImage(named: "iconPix")
        self.ivTed.image = UIImage(named: "iconTedX")
    }
    
    @IBAction func ted(_ sender: UIButton) {
        self.ivTed.image = UIImage(named: "iconTed")
        self.ivPix.image = UIImage(named: "iconPixX")
    }
    
    
    @IBAction func addNewBanck(_ sender: UIButton) {
    }
    
}
