

import UIKit

class ResultsTableViewCell: UITableViewCell {

    let cellID = "ResultCell"
    
    var eyeLabel = UILabel()
    var testResultLabel = UILabel()
    var distanceTestLabel = UILabel()
    var dateTestLabel = UILabel()
    
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
        
        self.backgroundColor = .systemGray6
        
        addSubview(eyeLabel)
        addSubview(testResultLabel)
        addSubview(distanceTestLabel)
        addSubview(dateTestLabel)
        
        eyeLabel.translatesAutoresizingMaskIntoConstraints = false
        eyeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        eyeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        eyeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        eyeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        eyeLabel.layer.cornerRadius = 10
        eyeLabel.backgroundColor = .white
        eyeLabel.clipsToBounds = true
        
        dateTestLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTestLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dateTestLabel.topAnchor.constraint(equalTo: eyeLabel.bottomAnchor, constant: 4).isActive = true
        dateTestLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        dateTestLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dateTestLabel.layer.cornerRadius = 10
        dateTestLabel.backgroundColor = .white
        dateTestLabel.clipsToBounds = true
        
        testResultLabel.translatesAutoresizingMaskIntoConstraints = false
        testResultLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        testResultLabel.topAnchor.constraint(equalTo: dateTestLabel.bottomAnchor, constant: 4).isActive = true
        testResultLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        testResultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        testResultLabel.layer.cornerRadius = 10
        testResultLabel.backgroundColor = .white
        testResultLabel.clipsToBounds = true
        
        distanceTestLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceTestLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        distanceTestLabel.topAnchor.constraint(equalTo: testResultLabel.bottomAnchor, constant: 4).isActive = true
        distanceTestLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        distanceTestLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        distanceTestLabel.layer.cornerRadius = 10
        distanceTestLabel.backgroundColor = .white
        distanceTestLabel.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
