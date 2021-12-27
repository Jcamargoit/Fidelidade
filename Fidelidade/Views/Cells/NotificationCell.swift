import UIKit

class NotificationCell: UITableViewCell {
    

    @IBOutlet weak var keyType: UILabel!
    @IBOutlet weak var ivKey: UIImageView!
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var ivClose: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
