

import UIKit
import CoreData

class UserTableViewCell: UITableViewCell {
    
    var userPhotoImageView = UIImageView()
    var userNameLabel = UILabel()
    var accessoryBtn = UIButton()

    var userInfoLabel = UILabel()
    var smallView = UIView()
    let cellID = "UserCell"
    
//    let gesture = UITapGestureRecognizer(target: self, action: #selector(imageAction))

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: cellID)
        
        addSubview(accessoryBtn)
        
        addSubview(userPhotoImageView)
        addSubview(userNameLabel)
        addSubview(userInfoLabel)
        addSubview(smallView)
        
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        userPhotoImageView.layer.cornerRadius = 75
        userPhotoImageView.clipsToBounds = true
                        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.leftAnchor.constraint(equalTo: userPhotoImageView.rightAnchor).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -50).isActive = true
        userNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        userNameLabel.textAlignment = .center
        userNameLabel.backgroundColor = .white
        
        
        userInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        userInfoLabel.leftAnchor.constraint(equalTo: userPhotoImageView.rightAnchor).isActive = true
        userInfoLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -50).isActive = true
        userInfoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        userInfoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        userInfoLabel.textAlignment = .center
        userInfoLabel.numberOfLines = 0
        userInfoLabel.backgroundColor = .white
        
        smallView.translatesAutoresizingMaskIntoConstraints = false
        smallView.topAnchor.constraint(equalTo: userInfoLabel.topAnchor).isActive = true
        smallView.widthAnchor.constraint(equalTo: userInfoLabel.widthAnchor, multiplier: 1/2).isActive = true
        smallView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        smallView.centerXAnchor.constraint(equalTo: userInfoLabel.centerXAnchor).isActive = true
        smallView.backgroundColor = .lightGray
        
        accessoryBtn.translatesAutoresizingMaskIntoConstraints = false
        accessoryBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        accessoryBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        accessoryBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        accessoryBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        accessoryBtn.setTitle("❯", for: .normal)
        accessoryBtn.setTitleColor(.systemBlue, for: .normal)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameLabel{
            userNameLabel.resignFirstResponder()
            saveName(name: userNameLabel.text ?? " ")
        }
        return true
    }
    
    func saveName(name: String){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User(context: context)
        user.setValue(name, forKey: "name")
        
        
        do {
            try context.save()
            print(user)
        }catch let error as NSError{
            print(error)
        }
    }
}
