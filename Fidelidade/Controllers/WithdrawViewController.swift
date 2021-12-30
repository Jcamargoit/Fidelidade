//
//  WithdrawViewController.swift
//  Fidelidade
//
//  Created by Juninho on 23/12/21.
//

import UIKit

class WithdrawViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //  RETIRAR MENU INFERIOR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }

    
    
}
