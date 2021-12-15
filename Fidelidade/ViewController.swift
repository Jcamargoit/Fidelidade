//
//  ViewController.swift
//  Fidelidade
//
//  Created by Juninho on 14/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnNovoUsuario: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Cor da borda
        self.btnNovoUsuario.layer.borderColor = UIColor(red: (38/255), green: (47/255), blue: (143/255), alpha: 1.0).cgColor
   

    }


    

}

