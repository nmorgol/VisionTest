

import UIKit

class InfoViewController: UIViewController {

    let startLabel = UILabel()
    let text = InfoVCText()
    
    var locale = "en_US"
    
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
        startLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 95/100).isActive = true
        startLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //startLabel.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        startLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        if self.title == "Автоопределение расстояния" || self.title == "Auto-detect distance"{
//            startLabel.text = "ВНИМАНИЕ - ДАННАЯ ОПЦИЯ ДОСТУПНА ТОЛЬКО ПРИ ВКЛЮЧЕНИИ 'РАСПОЗНАВАНИЯ РЕЧИ!!!'\n\n   При включении автоопределения расстояния дистанция теста будет измерена фронтальной камерой телефона (возможна небольшая погрешность при измерении).\n \n -В настройках приложения необходимо включить соответствующий переключатель.\n  -Установить время, которое потребуется чтобы отойти на планируемое расстояние.\n -Установить телефон в вертикальное положение, экраном в сторону пользователя.\n -Отойти на планируемое расстояние и повернуться лицом к телефону (фронтальной камере).\n -По истечении установленного времени произведется замер расстояния от телефона до пользователя.\n  ВАЖНО - перед камерой телефона должен находиться только 1 человек!!!"
            startLabel.text = text.startLabelText1[locale]
        }else if self.title == "Распознавание речи" || self.title == "Speech recognition"{
//            startLabel.text = "При включении распознавания речи тест зрения вдаль можно проводить самостоятельно.\n Необходимо использовать беспроводную гарнитуру.\n\n -Для распознавания речи включите соответствующий переключатель в настройках приложения.\n -Также установите время, которое Вам потребуется чтобы отойти от телефона на установленное расстояние.\n -Если Вы можете различить в какую сторону направлен символ - произнесите в микрофон гарнитуры направление символа: 'вправо', 'влево', 'вверх' или 'вниз'.\n -Когда Вы правильно назовете 3 из 4-х направлений - на экране появится символ более мелкого размера.\n -Если невозможно определить направление символа - произнесите слово 'СТОП'. Тест завершится. Результат будет сохранен.  \n Распознавание речи проводится на серверах Apple - необходим доступ к интернету!"
            startLabel.text = text.startLabelText2[locale]
        }else if self.title == "Дистанция теста" || self.title == "Test distance"{
//            startLabel.text = "Установите дистанцию проведения теста. Рекомендуемое расстояние должно быть не менее 5 метров (Но при таком расстоянии размер символа, соответствующего остроте зрения 0.1, не помещается в большинстве экранов iphone.) "
            startLabel.text = text.startLabelText3[locale]
        }else if self.title == "Время до начала теста" || self.title == "Time to start test"{
//            startLabel.text = "Установите время, которое Вам понадобится чтобы отойти от телефона на установленную дистанцию проведения теста. "
            startLabel.text = text.startLabelText4[locale]
        }
        
        
        startLabel.textAlignment = .justified
        startLabel.numberOfLines = 0
        startLabel.textColor = .black
        startLabel.font = .systemFont(ofSize: 17)
        startLabel.backgroundColor = .white
        //startLabel.alpha = 0.8
        startLabel.isUserInteractionEnabled = true
    }
}
