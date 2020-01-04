

import UIKit

class PurchasesTableViewCell: UITableViewCell {

    let cellID = "PurchasesCell"
    var settingLabel = UILabel()
    var settingSwitch = UISwitch()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: .subtitle, reuseIdentifier: cellID)
        
        addSubview(settingLabel)
        addSubview(settingSwitch)
        
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        settingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        settingLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        settingLabel.textAlignment = .left
        
        settingSwitch.translatesAutoresizingMaskIntoConstraints = false
        settingSwitch.leftAnchor.constraint(equalTo: settingLabel.rightAnchor).isActive = true
        settingSwitch.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
//        settingSwitch.heightAnchor.constraint(equalToConstant: 10).isActive = true
        settingSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
