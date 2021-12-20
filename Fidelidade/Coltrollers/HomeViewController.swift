//  Created by Juninho on 26/11/21.

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbExchange: UILabel!
    @IBOutlet weak var btnExchange: UIButton!
    @IBOutlet weak var lbGet: UILabel!
    @IBOutlet weak var btnGet: UIButton!{
        didSet{
            self.btnGet.layer.borderColor = UIColor(red: (38/255), green: (47/255), blue: (143/255), alpha: 1.0).cgColor
        }
    }
    @IBOutlet weak var sc: UISegmentedControl!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

