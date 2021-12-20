import UIKit

class TodosCelula: UITableViewCell {
    
    @IBOutlet weak var titulo: UITextView!
    @IBOutlet weak var imageList: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
