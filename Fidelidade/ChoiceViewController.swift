//
//  ViewController.swift
//  Fidelidade
//
//  Created by Juninho on 14/12/21.
//

import UIKit

class ChoiceViewController: UIViewController {

    
    @IBOutlet weak var btnEntrar: UIButton!
    @IBOutlet weak var btnNovoUsuario: UIButton!{
        didSet{
              self.btnNovoUsuario.layer.borderColor = UIColor(red: (38/255), green: (47/255), blue: (143/255), alpha: 1.0).cgColor
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

