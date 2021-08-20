import UIKit

class DLTableViewCell: UITableViewCell {

    var imageV: UIImageView = UIImageView.init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageV)
        imageV.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: cellHeight)
        imageV.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
