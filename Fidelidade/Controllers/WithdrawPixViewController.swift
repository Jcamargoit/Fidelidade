//
//  WithdrawPixViewController.swift
//  Fidelidade
//
//  Created by Juninho on 23/12/21.
//

import UIKit

class WithdrawPixViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var minhatabview: UITableView!
    
    //   var listAll = TodosViewModel()
    
    private lazy var myAccountViewModel = MyAccountViewModel()
    
    
    
    var keyType = [String]()
    var ivKey = [String]()
    var key = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        keyType.append("")
        keyType.append("")
        keyType.append("")
        keyType.append("")
        keyType.append("")
        
        ivKey.append("key")
        ivKey.append("key")
        ivKey.append("key")
        ivKey.append("key")
        ivKey.append("key")
        
        key.append("")
        key.append("")
        key.append("")
        key.append("")
        key.append("")
    }
    
    
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /// Tamanhop table vcelula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //POSIÇÃO DA CELULA
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "openWithdrawResultFromWithdraw", sender: self)
        }
        
        if indexPath.row == 1 {
            self.performSegue(withIdentifier: "openWithdrawResultFromWithdraw", sender: self)
        }
        
        if indexPath.row == 2 {
            self.performSegue(withIdentifier: "openWithdrawResultFromWithdraw", sender: self)
        }
        
        if indexPath.row == 3 {
            self.performSegue(withIdentifier: "openWithdrawResultFromWithdraw", sender: self)
        }
        
        if indexPath.row == 4 {
            self.performSegue(withIdentifier: "openWithdrawResultFromWithdraw", sender: self)
        }
        
        
        self.minhatabview.reloadData()
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    //Quantidade de celulas por categoria
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return keyType.count
        
    }
    
    
    //Alimentar id
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:
                                                    indexPath) as! WithdrawPixCell
        
        //        cell.keyType.text = keyType[indexPath.row]
        //        cell.ivKey.image = UIImage (named: ivKey[indexPath.row])
        //        cell.key.text = key[indexPath.row]
        
        return cell
    }
    
    
    //remove navegation controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
}




