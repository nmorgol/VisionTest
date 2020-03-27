

import UIKit

class InfoViewController: UIViewController {

    let startLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        addStartLabel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
    }
    
    func addStartLabel() {
        self.view.addSubview(startLabel)
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        startLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //startLabel.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        startLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        if self.title == "Автоопределение расстояния"{
            startLabel.text = "При включении автоопределения расстояния дистанция теста будет измерена фронтальной камерой телефона (возможна небольшая погрешность при измерении).\n  Более подробно об автоопределении расстояния можно ознакомиться в инструкции к приложению."
        }else if self.title == "Распознавание речи"{
            startLabel.text = "При включении распознавания речи тест на наличие миопии можно проводить самостоятельно. \n Необходимо использовать беспроводную гарнитуру. \n Распознавание речи проводится на серверах Apple - необходим доступ к интернету!"
        }else if self.title == "Дистанция теста"{
            startLabel.text = "Установите дистанцию проведения теста. Рекомендуемое расстояние должно быть не менее 5 метров (Но при таком расстоянии размер символа, соответствующего остроте зрения 0.1, не помещается в большинстве экранов iphone.) "
        }else if self.title == "Время до начала теста"{
            startLabel.text = "Установите время, которое Вам понадобится чтобы отойти от телефона на установленную дистанцию проведения теста. "
        }
        
        
        startLabel.textAlignment = .center
        startLabel.numberOfLines = 0
        startLabel.textColor = .black
        startLabel.font = .systemFont(ofSize: 17)
        startLabel.backgroundColor = .white
        //startLabel.alpha = 0.8
        startLabel.isUserInteractionEnabled = true
    }
}
