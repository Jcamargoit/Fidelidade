//
//  WithdrawPixViewController.swift
//  Fidelidade
//
//  Created by Juninho on 23/12/21.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    //   var listAll = TodosViewModel()
    
    private lazy var myAccountViewModel = MyAccountViewModel()
    
    
    
    var lbTitle = [String]()
    var lbDescription = [String]()
    var ivKey = [String]()
    var ivClose = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lbTitle.append("")
        lbTitle.append("")
        lbTitle.append("")
        lbTitle.append("")
        lbTitle.append("")
        
    }
    
    
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

    
    
    //remove navegation controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
}



extension NotificationViewController {
    
    
    /// Tamanhop table vcelula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
        
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //POSIÇÃO DA CELULA
        if indexPath.row == 0 {
          
        }
        
        if indexPath.row == 1 {
        }
        
        if indexPath.row == 2 {
        }
        
        if indexPath.row == 3 {
        }
        
        if indexPath.row == 4 {
        }
        
        self.myTableView.reloadData()
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    //Quantidade de celulas por categoria
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lbTitle.count
        
    }

    //Alimentar id
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:
                                                    indexPath) as! NotificationCell
        
        //        cell.keyType.text = keyType[indexPath.row]
        //        cell.key.text = key[indexPath.row]
        //        cell.ivKey.image = UIImage (named: ivKey[indexPath.row])
        //        cell.ivClose.image = UIImage (named: ivKey[indexPath.row])
        
        return cell
    }
}





