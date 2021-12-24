//  Todos.swift
//  FrameworkTest
//  Created by Juninho on 26/11/21.


import UIKit
import Observable


class MyAccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var minhatabview: UITableView!
    
    var listAll = TodosViewModel()
    
   private lazy var myAccountViewModel = MyAccountViewModel()
    
    private var disposal = Disposal()
    
    var account = [String]()
    var image = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observerse()

        account.append("Perfil")
        account.append("Notificações")
        account.append("Sacar")
        account.append("Configurações")
        account.append("Sair")
        
        image.append("profile")
        image.append("notification")
        image.append("withdraw")
        image.append("settings")
        image.append("settings")
    }
    
    

    
    
    
    
    /// Tamanhop table vcelula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 84
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //POSIÇÃO DA CELULA
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "openProfile", sender: self)
        }
        
        if indexPath.row == 1 {
            self.performSegue(withIdentifier: "openNotification", sender: self)
        }
        
        if indexPath.row == 2 {
            
            self.performSegue(withIdentifier: "openWithdraw", sender: self)
            
        }
        
        if indexPath.row == 3 {
            
            self.performSegue(withIdentifier: "openSettings", sender: self)
            
        }
        
        if indexPath.row == 4 {
            myAccountViewModel.handleLogout()
        }
        
        
        self.minhatabview.reloadData()
    }
    
   
    
    
    func observerse() {
        myAccountViewModel.logoutIsFinished.observe(DispatchQueue.main) { [weak self] result, oldValue in
            guard let result = result else{
                return
            }
            
            if result {
                self?.performSegue(withIdentifier: "openChoiceFromMyAccount", sender: self)
                
            }
        }.add(to: &disposal)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    //Quantidade de celulas por categoria
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return account.count
        
    }
    
    
    //Alimentar id
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:
                                                    indexPath) as! MyAccountCell

        cell.titulo.text = account[indexPath.row]
        cell.imageList.image = UIImage (named: image[indexPath.row])
        
        return cell
    }
    

    //remove navegation controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    
}




