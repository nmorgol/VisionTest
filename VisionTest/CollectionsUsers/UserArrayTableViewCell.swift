

import UIKit

class UserArrayTableViewCell: UITableViewCell {

    var userPhotoImageView = UIImageView()
    var userNameLabel = UILabel()
    let cellID = "UsersArrayCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: cellID)
        
        self.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(userPhotoImageView)
        addSubview(userNameLabel)
        
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userPhotoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.leftAnchor.constraint(equalTo: userPhotoImageView.rightAnchor, constant: 10).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        userNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
