//
//  LauncheScreenViewController.swift
//  Fidelidade
//
//  Created by Juninho on 14/12/21.
//

import UIKit

class LauncheScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            self.performSegue(withIdentifier: "login", sender: self)
        }
        
        
    }
    


}
