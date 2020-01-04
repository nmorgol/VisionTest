//
//  SettingsTableViewCell.swift
//  VisionTest
//
//  Created by kolya on 12/22/19.
//  Copyright © 2019 kolya. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell, UITextFieldDelegate {

    let cellID = "SettingsCell"
    var settingLabel = UILabel()
    var settingTextLabel = UILabel()
    var deteilLabel = UILabel()
    let smallView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: .subtitle, reuseIdentifier: cellID)
        
        addSubview(settingLabel)
        addSubview(settingTextLabel)
        addSubview(deteilLabel)
        addSubview(smallView)
        
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        settingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        settingLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        settingLabel.textAlignment = .left
        
        settingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        settingTextLabel.leftAnchor.constraint(equalTo: settingLabel.rightAnchor).isActive = true
        settingTextLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        settingTextLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/3).isActive = true
        settingTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        settingTextLabel.backgroundColor = .white
        settingTextLabel.textAlignment = .center
        
        deteilLabel.translatesAutoresizingMaskIntoConstraints = false
        deteilLabel.leftAnchor.constraint(equalTo: settingTextLabel.rightAnchor).isActive = true
        deteilLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        deteilLabel.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        deteilLabel.textAlignment = .center
        
        smallView.translatesAutoresizingMaskIntoConstraints = false
        smallView.leftAnchor.constraint(equalTo: settingTextLabel.leftAnchor).isActive = true
        smallView.rightAnchor.constraint(equalTo: settingTextLabel.rightAnchor).isActive = true
        smallView.topAnchor.constraint(equalTo: settingTextLabel.bottomAnchor).isActive = true
        smallView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        smallView.backgroundColor = .systemGray
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        if textField == settingTextField{
//            print(textField.tag)
//            settingTextField.resignFirstResponder()
//            
//        }
//            
//        
//        
//        return true
//    }

}
