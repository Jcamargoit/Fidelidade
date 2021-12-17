//
//  ProfileViewController.swift
//  Fidelidade
//
//  Created by Juninho on 17/12/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var btnNewBank: UIButton!{
        didSet{
            self.btnNewBank.layer.borderColor = UIColor(red: (38/255), green: (47/255), blue: (143/255), alpha: 1.0).cgColor
        }
    }
    
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
