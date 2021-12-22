//
//  LauncheScreenViewController.swift
//  Fidelidade
//
//  Created by Juninho on 14/12/21.
//

import UIKit
import Observable

class LauncheScreenViewController: UIViewController {
    
    private var disposal = Disposal()
    private lazy var viewModel = LauncheScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.observerse()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.viewModel.validateUserIsLogged()
        }
    }
    
    
    func observerse() {
        
        viewModel.isLogged.observe(DispatchQueue.main) { [weak self] result, oldValue in
            guard let result = result else{
                return
            }
            
            
            if result {
                self?.performSegue(withIdentifier: "openHomeFromLaouncheScreen", sender: self)
                
            }else {
                
                self?.performSegue(withIdentifier: "login", sender: self)
                
                
            }
        }.add(to: &disposal)
    }
}

