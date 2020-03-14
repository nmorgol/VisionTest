

import UIKit

class InfoHyperopiaViewController: UIViewController {
    
    let segmentedContr = UISegmentedControl(items: ["Информация","Инструкция"])
    var selectedSegmentIndex = 0
    //информация
    let scrolView = UIScrollView()
    
    let viewForDescrMyopia = UIView()
    let myopiaDescrLabel = UILabel()
    let eyeView = EyeView()
    let hyperopiaLight = HyperopiaLightView()
    
    let attantionView = UIView()
    let ahtungLabel = UILabel()
    let attantionLabel = UILabel()
    let eyeNormView = EyeView()
    let normLight = NormalLightView()
    let landoltAtentionView = LandoltLeftUIView()
    let phoneImageForTableView = UIImageView()
    
    let viewForTable = UIView()
    let tableDescrLabel = UILabel()
    let tableImageView = UIImageView()
    let tappedImageView = UIImageView()
    
//    let symbolDescribeView = UIView()
//    let firstLabel = UILabel()
//    let firstNumberLabel = UILabel()
//    let landoltLabel = UILabel()
//    let secondLandoltLabel = UILabel()
//    let snelenView = SnellenLeftView()
//    let snelenLabel = UILabel()
    
    
    //инструкция
    let scrollInfoView = UIScrollView()
    
    let firstInstrView = UIView()
    let howDoTestLabel = UILabel()
    let basicHyperScreenImageView = UIImageView()
    
    let closeEyeDiscrLBS = SpeakLeftBottomView()
    let stopBtnDiscrLBS = SpeakLeftBottomView()
    let timeProgressDiscrLTS = SpeakLeftTopView()
    let keyboardDiscrLTS = SpeakLeftTopView()
    let textFieldDiscrRTS = SpeakRightTopView()
    let numberDiscrRBS = SpeakRightBottomView()
    
    let numberDiscrLabel = UILabel()
    let textFieldLabel = UILabel()
    let timeProgressDiscrLabel = UILabel()
    let keyboardDiscrLabel = UILabel()
    let stopBtnDiscrLabel = UILabel()
    let closeEyeDiscrLabel = UILabel()
    
    let bigLabel = UILabel()
    
    
    let secondInstrView = UIView()
    let howDoRecognLabel = UILabel()
    let speechRecScreenImageView = UIImageView()
    let speechSymbolDiscrLBS = SpeakLeftBottomView()
    let lineDescrLTS = SpeakLeftTopView()
    let speechSymbolDiscrLabel = UILabel()
    let lineDescrLabel = UILabel()
    
//    let thirdInstrView = UIView()
//    let howDoAutoDetectLabel = UILabel()
    
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        addSegmContr()
        addScrollView()
        
        addHyperopiaViews()
        
        addAttentionView()
        addTableViews()
//        addSybolDiscrView()
        segmentedContr.selectedSegmentIndex = selectedSegmentIndex
        segmentContrAction()
    }
    
    func addSegmContr() {
        segmentedContr.selectedSegmentIndex = 0
        
        view.addSubview(segmentedContr)
        segmentedContr.translatesAutoresizingMaskIntoConstraints = false
        segmentedContr.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        segmentedContr.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedContr.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedContr.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedContr.addTarget(self, action: #selector(segmentContrAction), for: .valueChanged)
        
        
    }
    
    //MARK: segmentContrAction()
    @objc func segmentContrAction() {
        if segmentedContr.selectedSegmentIndex == 0{
            
            scrollInfoView.removeFromSuperview()
            
            addScrollView()
            addHyperopiaViews()
            addAttentionView()
            addTableViews()
            //addSybolDiscrView()
            
        }else if segmentedContr.selectedSegmentIndex == 1{
            scrolView.removeFromSuperview()
            
            addScrollInfoView()
            addFirstInstrView()
            addSecondInstrView()
            //addThirdInstrView()
        }
    }
    
    
    //MARK: описание
    func addScrollView() {
        
        view.addSubview(scrolView)
        scrolView.translatesAutoresizingMaskIntoConstraints = false
        scrolView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scrolView.topAnchor.constraint(equalTo: segmentedContr.bottomAnchor).isActive = true
        
        scrolView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrolView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrolView.contentSize = CGSize(width: view.frame.width, height: 1600)
        
    }
    //MARK: окно гиперопия
    func addHyperopiaViews() {
        
        scrolView.addSubview(viewForDescrMyopia)
        
        viewForDescrMyopia.translatesAutoresizingMaskIntoConstraints = false
        viewForDescrMyopia.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
        viewForDescrMyopia.topAnchor.constraint(equalTo: scrolView.topAnchor, constant: 10).isActive = true
        viewForDescrMyopia.heightAnchor.constraint(equalToConstant: 520).isActive = true
        viewForDescrMyopia.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
        viewForDescrMyopia.backgroundColor = .white
        
        viewForDescrMyopia.layer.cornerRadius = 20
        viewForDescrMyopia.layer.shadowOpacity = 0.1
        viewForDescrMyopia.layer.shadowColor = UIColor.gray.cgColor
        
        viewForDescrMyopia.addSubview(eyeView)
        viewForDescrMyopia.addSubview(hyperopiaLight)
        
        eyeView.translatesAutoresizingMaskIntoConstraints = false
        eyeView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        eyeView.topAnchor.constraint(equalTo: viewForDescrMyopia.topAnchor, constant: 0).isActive = true
        eyeView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        eyeView.centerXAnchor.constraint(equalTo: viewForDescrMyopia.centerXAnchor).isActive = true
        eyeView.backgroundColor = .clear
        
        hyperopiaLight.translatesAutoresizingMaskIntoConstraints = false
        hyperopiaLight.widthAnchor.constraint(equalToConstant: 200).isActive = true
        hyperopiaLight.topAnchor.constraint(equalTo: viewForDescrMyopia.topAnchor, constant: 0).isActive = true
        hyperopiaLight.heightAnchor.constraint(equalToConstant: 200).isActive = true
        hyperopiaLight.centerXAnchor.constraint(equalTo: viewForDescrMyopia.centerXAnchor).isActive = true
        hyperopiaLight.backgroundColor = .clear
        
        viewForDescrMyopia.addSubview(myopiaDescrLabel)
        
        myopiaDescrLabel.translatesAutoresizingMaskIntoConstraints = false
        myopiaDescrLabel.widthAnchor.constraint(equalTo: viewForDescrMyopia.widthAnchor, multiplier: 95/100).isActive = true
        myopiaDescrLabel.topAnchor.constraint(equalTo: eyeView.bottomAnchor, constant: 0).isActive = true
        myopiaDescrLabel.heightAnchor.constraint(equalToConstant: 320).isActive = true
        myopiaDescrLabel.centerXAnchor.constraint(equalTo: viewForDescrMyopia.centerXAnchor).isActive = true
        
        myopiaDescrLabel.numberOfLines = 0
        myopiaDescrLabel.textAlignment = .natural
        myopiaDescrLabel.text = "   Дальнозоркость (гиперметропи́я) — это дефект зрения, при котором хорошо видно лишь расположенные вдали объекты, а близко расположенные объекты видно плохо.\n   Этот дефект заключается в том, что из-за аномалии рефракции изображение фокусируется не на сетчатке глаза, а за сетчаткой. \n   Причинами дальнозоркости могут быть:\n-уменьшенный размер глазного яблока на передне-задней оси\n-уменьшение способности хрусталика изменять кривизну."
        
        
    }
    //MARK: окно внимание
    func addAttentionView() {
        scrolView.addSubview(attantionView)
        
        attantionView.translatesAutoresizingMaskIntoConstraints = false
        attantionView.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
        attantionView.topAnchor.constraint(equalTo: viewForDescrMyopia.bottomAnchor, constant: 10).isActive = true
        attantionView.heightAnchor.constraint(equalToConstant: 520).isActive = true
        attantionView.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
        attantionView.backgroundColor = .white
        
        attantionView.layer.cornerRadius = 20
        attantionView.layer.shadowOpacity = 0.1
        attantionView.layer.shadowColor = UIColor.gray.cgColor
        
        attantionView.addSubview(eyeNormView)
        attantionView.addSubview(normLight)
        attantionView.addSubview(phoneImageForTableView)
        attantionView.addSubview(ahtungLabel)
        
        ahtungLabel.translatesAutoresizingMaskIntoConstraints = false
        ahtungLabel.widthAnchor.constraint(equalTo: attantionView.widthAnchor).isActive = true
        ahtungLabel.topAnchor.constraint(equalTo: attantionView.topAnchor, constant: 0).isActive = true
        ahtungLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ahtungLabel.numberOfLines = 0
        ahtungLabel.textAlignment = .center
        ahtungLabel.text = "Внимание!"
        ahtungLabel.textColor = .red
        ahtungLabel.font = .boldSystemFont(ofSize: 17)
        
        
        eyeNormView.translatesAutoresizingMaskIntoConstraints = false
        eyeNormView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        eyeNormView.topAnchor.constraint(equalTo: ahtungLabel.bottomAnchor, constant: 0).isActive = true
        eyeNormView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        eyeNormView.rightAnchor.constraint(equalTo: attantionView.rightAnchor, constant: -50).isActive = true
        eyeNormView.backgroundColor = .clear
        
        normLight.translatesAutoresizingMaskIntoConstraints = false
        normLight.widthAnchor.constraint(equalToConstant: 200).isActive = true
        normLight.topAnchor.constraint(equalTo: ahtungLabel.bottomAnchor, constant: 0).isActive = true
        normLight.heightAnchor.constraint(equalToConstant: 200).isActive = true
        normLight.rightAnchor.constraint(equalTo: attantionView.rightAnchor, constant: -50).isActive = true
        normLight.backgroundColor = .clear
        
        let distanceLabel = UILabel()
        eyeNormView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        distanceLabel.bottomAnchor.constraint(equalTo: eyeNormView.bottomAnchor, constant: -35).isActive = true
        distanceLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        distanceLabel.leftAnchor.constraint(equalTo: eyeNormView.leftAnchor, constant: 5).isActive = true
        distanceLabel.backgroundColor = .clear
        
        distanceLabel.text = "30 - 40 см."
        distanceLabel.font = .boldSystemFont(ofSize: 7)
        distanceLabel.textColor = .red
        
        phoneImageForTableView.translatesAutoresizingMaskIntoConstraints = false
        phoneImageForTableView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        phoneImageForTableView.rightAnchor.constraint(equalTo: eyeNormView.leftAnchor, constant: 0).isActive = true
        phoneImageForTableView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        phoneImageForTableView.centerYAnchor.constraint(equalTo: eyeNormView.centerYAnchor).isActive = true
        phoneImageForTableView.backgroundColor = .clear
        
        phoneImageForTableView.image = UIImage(named: "hyperopia phone screen")
        phoneImageForTableView.layer.borderWidth = 1
        
        attantionView.addSubview(attantionLabel)
        
        attantionLabel.translatesAutoresizingMaskIntoConstraints = false
        attantionLabel.widthAnchor.constraint(equalTo: attantionView.widthAnchor, multiplier: 95/100).isActive = true
        attantionLabel.topAnchor.constraint(equalTo: eyeNormView.bottomAnchor, constant: 0).isActive = true
        attantionLabel.heightAnchor.constraint(equalToConstant: 320).isActive = true
        attantionLabel.centerXAnchor.constraint(equalTo: attantionView.centerXAnchor).isActive = true
        
        attantionLabel.numberOfLines = 0
        attantionLabel.textAlignment = .natural
        attantionLabel.text = "   Расстояние для проведения теста на наличие дальнозоркости должно составлять 30 - 40 сантиметров."
    }
    //MARK: окно таблицы
    func addTableViews() {
        
        scrolView.addSubview(viewForTable)
        
        viewForTable.translatesAutoresizingMaskIntoConstraints = false
        viewForTable.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
        viewForTable.topAnchor.constraint(equalTo: attantionView.bottomAnchor, constant: 10).isActive = true
        viewForTable.heightAnchor.constraint(equalToConstant: 520).isActive = true
        viewForTable.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
        
        viewForTable.backgroundColor = .white
        viewForTable.layer.cornerRadius = 20
        viewForTable.layer.shadowOpacity = 0.1
        viewForTable.layer.shadowColor = UIColor.gray.cgColor
        
        
        viewForTable.addSubview(tableImageView)
        
        tableImageView.translatesAutoresizingMaskIntoConstraints = false
        tableImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        tableImageView.topAnchor.constraint(equalTo: viewForTable.topAnchor, constant: 10).isActive = true
        tableImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tableImageView.centerXAnchor.constraint(equalTo: viewForTable.centerXAnchor).isActive = true
        tableImageView.backgroundColor = .clear
        tableImageView.image = UIImage(named: "hyptropia table")
        tableImageView.contentMode = .scaleAspectFit
        
        let tableTap = UITapGestureRecognizer(target: self, action: #selector(tableImageViewAction))
        tableImageView.isUserInteractionEnabled = true
        tableImageView.addGestureRecognizer(tableTap)
        
        
        viewForTable.addSubview(tableDescrLabel)
        
        tableDescrLabel.translatesAutoresizingMaskIntoConstraints = false
        tableDescrLabel.widthAnchor.constraint(equalTo: viewForTable.widthAnchor, multiplier: 95/100).isActive = true
        tableDescrLabel.topAnchor.constraint(equalTo: tableImageView.bottomAnchor, constant: 0).isActive = true
        tableDescrLabel.heightAnchor.constraint(equalToConstant: 320).isActive = true
        tableDescrLabel.centerXAnchor.constraint(equalTo: viewForTable.centerXAnchor).isActive = true
        
        tableDescrLabel.numberOfLines = 0
        tableDescrLabel.textAlignment = .natural
        tableDescrLabel.text = "Тексты для контроля остроты зрения с дистанции наблюдения 30 см используются как традиционное средство контроля зрения вблизи и подбора очков для чтения. Может использоваться в офтальмологических кабинетах при исследовании дальнозоркости у пациентов или в магазинах «Оптика» для подбора очков для близи."
        
    }
    
    @objc func tableImageViewAction(){
        view.addSubview(tappedImageView)
        tappedImageView.translatesAutoresizingMaskIntoConstraints = false
        tappedImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        tappedImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tappedImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1).isActive = true
        tappedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tappedImageView.backgroundColor = .clear
        tappedImageView.image = UIImage(named: "hyptropia table")
        tappedImageView.contentMode = .scaleAspectFit
        tappedImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedImageViewAction))
        tappedImageView.addGestureRecognizer(tap)
    }
    @objc func tappedImageViewAction(){
        tappedImageView.removeFromSuperview()
    }
    
    
    //MARK: окно символов в тесте
//    func addSybolDiscrView() {
//        scrolView.addSubview(symbolDescribeView)
//
//        symbolDescribeView.translatesAutoresizingMaskIntoConstraints = false
//        symbolDescribeView.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
//        symbolDescribeView.topAnchor.constraint(equalTo: viewForTable.bottomAnchor, constant: 10).isActive = true
//        symbolDescribeView.heightAnchor.constraint(equalToConstant: 650).isActive = true
//        symbolDescribeView.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
//
//        symbolDescribeView.backgroundColor = .white
//        symbolDescribeView.layer.cornerRadius = 20
//        symbolDescribeView.layer.shadowOpacity = 0.1
//        symbolDescribeView.layer.shadowColor = UIColor.gray.cgColor
//
//
//        symbolDescribeView.addSubview(firstLabel)
//
//        firstLabel.translatesAutoresizingMaskIntoConstraints = false
//        firstLabel.widthAnchor.constraint(equalTo: symbolDescribeView.widthAnchor, multiplier: 95/100).isActive = true
//        firstLabel.topAnchor.constraint(equalTo: symbolDescribeView.topAnchor, constant: 0).isActive = true
//        firstLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        firstLabel.centerXAnchor.constraint(equalTo: symbolDescribeView.centerXAnchor).isActive = true
//
//        firstLabel.numberOfLines = 0
//        firstLabel.textAlignment = .natural
//        firstLabel.text = "   В приложении (в тесте на наличие дальнозоркости)  используются используются трехзначные числа, например  '923'."
//
//        symbolDescribeView.addSubview(firstNumberLabel)
//
//        firstNumberLabel.translatesAutoresizingMaskIntoConstraints = false
//        firstNumberLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        firstNumberLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 20).isActive = true
//        firstNumberLabel.leftAnchor.constraint(equalTo: symbolDescribeView.leftAnchor, constant: 20).isActive = true
//        firstNumberLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        firstNumberLabel.text = "\(Int.random(in: 100...999))"
//        firstNumberLabel.textAlignment = .center
//        firstNumberLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
//
//
//        symbolDescribeView.addSubview(landoltLabel)
//
//        landoltLabel.translatesAutoresizingMaskIntoConstraints = false
//        landoltLabel.rightAnchor.constraint(equalTo: symbolDescribeView.rightAnchor).isActive = true
//        landoltLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 0).isActive = true
//        landoltLabel.leftAnchor.constraint(equalTo: firstNumberLabel.rightAnchor, constant: 20).isActive = true
//        landoltLabel.heightAnchor.constraint(equalToConstant: 210).isActive = true
//
//        landoltLabel.numberOfLines = 0
//        landoltLabel.textAlignment = .natural
//        landoltLabel.text = "Оптотипы Ландольта по форме представляют собой черные кольца разной величины с разрывами, обращенными в разные стороны, и по распознаванию этого разрыва можно определить минимальный угол разрешения глаза."
//
//        symbolDescribeView.addSubview(secondLandoltLabel)
//
//        secondLandoltLabel.translatesAutoresizingMaskIntoConstraints = false
//        secondLandoltLabel.rightAnchor.constraint(equalTo: symbolDescribeView.rightAnchor).isActive = true
//        secondLandoltLabel.topAnchor.constraint(equalTo: landoltLabel.bottomAnchor, constant: 0).isActive = true
//        secondLandoltLabel.leftAnchor.constraint(equalTo: symbolDescribeView.leftAnchor, constant: 5).isActive = true
//        secondLandoltLabel.heightAnchor.constraint(equalToConstant: 130).isActive = true
//
//        secondLandoltLabel.numberOfLines = 0
//        secondLandoltLabel.textAlignment = .natural
//        secondLandoltLabel.text = "Ширина кольца Ландольта и ширина разрыва в 5 раз меньше его наружного диаметра, то есть соотношение этих параметров – 5 : 1 : 1. Направление разрыва кольца может иметь четыре варианта (вверху, внизу, справа и слева)."
//
//        symbolDescribeView.addSubview(snelenView)
//
//        snelenView.translatesAutoresizingMaskIntoConstraints = false
//        snelenView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        snelenView.topAnchor.constraint(equalTo: secondLandoltLabel.bottomAnchor, constant: 60).isActive = true
//        snelenView.leftAnchor.constraint(equalTo: symbolDescribeView.leftAnchor, constant: 20).isActive = true
//        snelenView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//
//        symbolDescribeView.addSubview(snelenLabel)
//
//        snelenLabel.translatesAutoresizingMaskIntoConstraints = false
//        snelenLabel.rightAnchor.constraint(equalTo: symbolDescribeView.rightAnchor).isActive = true
//        snelenLabel.topAnchor.constraint(equalTo: secondLandoltLabel.bottomAnchor, constant: 0).isActive = true
//        snelenLabel.leftAnchor.constraint(equalTo: snelenView.rightAnchor, constant: 20).isActive = true
//        snelenLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//        snelenLabel.numberOfLines = 0
//        snelenLabel.textAlignment = .natural
//        snelenLabel.text = "Оптотип Снеллена - вписанная в квадрат фигура, подобная букве 'Ш', которая может иметь 4 ориентации. Такие знаки также широко используются в офтальмологии."
//    }
    
    
    //MARK: инструкция
    
    func addScrollInfoView() {
        
        view.addSubview(scrollInfoView)
        scrollInfoView.translatesAutoresizingMaskIntoConstraints = false
        scrollInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scrollInfoView.topAnchor.constraint(equalTo: segmentedContr.bottomAnchor).isActive = true
        
        scrollInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollInfoView.contentSize = CGSize(width: view.frame.width, height: 1330)
        
    }
    
    
    //MARK:addFirstInstrView()
    func addFirstInstrView() {
        scrollInfoView.addSubview(firstInstrView)
        
        firstInstrView.translatesAutoresizingMaskIntoConstraints = false
        firstInstrView.widthAnchor.constraint(equalTo: scrollInfoView.widthAnchor, multiplier: 95/100).isActive = true
        firstInstrView.topAnchor.constraint(equalTo: scrollInfoView.topAnchor, constant: 10).isActive = true
        firstInstrView.heightAnchor.constraint(equalToConstant: 650).isActive = true
        firstInstrView.centerXAnchor.constraint(equalTo: scrollInfoView.centerXAnchor).isActive = true
        
        firstInstrView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        firstInstrView.layer.cornerRadius = 20
        firstInstrView.layer.shadowOpacity = 0.1
        firstInstrView.layer.shadowColor = UIColor.gray.cgColor
        
        
        firstInstrView.addSubview(basicHyperScreenImageView)
        
        basicHyperScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        basicHyperScreenImageView.widthAnchor.constraint(equalTo: firstInstrView.widthAnchor, multiplier: 1/2).isActive = true
        basicHyperScreenImageView.heightAnchor.constraint(equalTo: basicHyperScreenImageView.widthAnchor, multiplier: 2.1).isActive = true
        basicHyperScreenImageView.centerXAnchor.constraint(equalTo: firstInstrView.centerXAnchor).isActive = true
        basicHyperScreenImageView.centerYAnchor.constraint(equalTo: firstInstrView.centerYAnchor).isActive = true
        basicHyperScreenImageView.backgroundColor = .clear
        basicHyperScreenImageView.image = UIImage(named: "hyperopia phone screen")
        basicHyperScreenImageView.layer.borderWidth = 0.5
        
        
        addCloseEyeDescrView()
        
        addStopBtnDescrView()
        
        addTimeProgressDescrView()
        
        addKeyboardDescrView()
        
        addtextFielDescrView()
        
        addNumberDescrView()
        
        addHowDoTestLabel()
        
        
    }
    
    func addHowDoTestLabel() {
        
        firstInstrView.addSubview(howDoTestLabel)
        howDoTestLabel.translatesAutoresizingMaskIntoConstraints = false
        howDoTestLabel.rightAnchor.constraint(equalTo: firstInstrView.rightAnchor, constant: -20).isActive = true
        howDoTestLabel.topAnchor.constraint(equalTo: firstInstrView.topAnchor, constant: 20).isActive = true
        howDoTestLabel.heightAnchor.constraint(equalTo: firstInstrView.heightAnchor, multiplier: 1/7).isActive = true
        howDoTestLabel.leftAnchor.constraint(equalTo: firstInstrView.leftAnchor, constant: 20).isActive = true
        howDoTestLabel.backgroundColor = .clear
        howDoTestLabel.numberOfLines = 0
        howDoTestLabel.font = .systemFont(ofSize: 15)
        howDoTestLabel.text = "   Расположите телефон на расстоянии 30 - 40 сантиметров. На клавиатуре наберите число, которое указанно в центральном окне. "
    }
    
    fileprivate func addCloseEyeDescrView() {
        firstInstrView.addSubview(closeEyeDiscrLBS)
        closeEyeDiscrLBS.radius = 10
        closeEyeDiscrLBS.fat = 5
        closeEyeDiscrLBS.ratio = 1/5
        
        closeEyeDiscrLBS.translatesAutoresizingMaskIntoConstraints = false
        closeEyeDiscrLBS.rightAnchor.constraint(equalTo: firstInstrView.rightAnchor, constant: -5).isActive = true
        closeEyeDiscrLBS.topAnchor.constraint(equalTo: basicHyperScreenImageView.topAnchor, constant: 0).isActive = true
        closeEyeDiscrLBS.heightAnchor.constraint(equalTo: basicHyperScreenImageView.heightAnchor, multiplier: 2/9).isActive = true
        closeEyeDiscrLBS.leftAnchor.constraint(equalTo: basicHyperScreenImageView.rightAnchor, constant: -15).isActive = true
        closeEyeDiscrLBS.backgroundColor = .clear
        
        
        closeEyeDiscrLBS.addSubview(closeEyeDiscrLabel)
        closeEyeDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        closeEyeDiscrLabel.rightAnchor.constraint(equalTo: closeEyeDiscrLBS.rightAnchor, constant: -5).isActive = true
        closeEyeDiscrLabel.topAnchor.constraint(equalTo: closeEyeDiscrLBS.topAnchor, constant: 5).isActive = true
        closeEyeDiscrLabel.heightAnchor.constraint(equalTo: closeEyeDiscrLBS.heightAnchor, multiplier: 10/11).isActive = true
        closeEyeDiscrLabel.widthAnchor.constraint(equalTo: closeEyeDiscrLBS.widthAnchor, multiplier: 4/5, constant: -10).isActive = true
        closeEyeDiscrLabel.backgroundColor = .clear
        closeEyeDiscrLabel.text = "Указано какой глаз необходимо закрыть для проведения теста."
        closeEyeDiscrLabel.font = .systemFont(ofSize: 7)
        closeEyeDiscrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        
        closeEyeDiscrLabel.isUserInteractionEnabled = true
        
        closeEyeDiscrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: closeEyeDiscrLabel)
    }
    
    fileprivate func addStopBtnDescrView() {
        firstInstrView.addSubview(stopBtnDiscrLBS)
        stopBtnDiscrLBS.radius = 10
        stopBtnDiscrLBS.fat = 5
        stopBtnDiscrLBS.ratio = 1/5
        
        stopBtnDiscrLBS.translatesAutoresizingMaskIntoConstraints = false
        stopBtnDiscrLBS.rightAnchor.constraint(equalTo: firstInstrView.rightAnchor, constant: -5).isActive = true
        stopBtnDiscrLBS.bottomAnchor.constraint(equalTo: basicHyperScreenImageView.centerYAnchor, constant: 0).isActive = true
        stopBtnDiscrLBS.heightAnchor.constraint(equalTo: basicHyperScreenImageView.heightAnchor, multiplier: 1/4).isActive = true
        stopBtnDiscrLBS.leftAnchor.constraint(equalTo: basicHyperScreenImageView.rightAnchor, constant: -10).isActive = true
        stopBtnDiscrLBS.backgroundColor = .clear
        
        
        stopBtnDiscrLBS.addSubview(stopBtnDiscrLabel)
        stopBtnDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        stopBtnDiscrLabel.rightAnchor.constraint(equalTo: stopBtnDiscrLBS.rightAnchor, constant: -5).isActive = true
        stopBtnDiscrLabel.topAnchor.constraint(equalTo: stopBtnDiscrLBS.topAnchor, constant: 5).isActive = true
        stopBtnDiscrLabel.heightAnchor.constraint(equalTo: stopBtnDiscrLBS.heightAnchor, multiplier: 10/11).isActive = true
        stopBtnDiscrLabel.widthAnchor.constraint(equalTo: stopBtnDiscrLBS.widthAnchor, multiplier: 4/5, constant: -10).isActive = true
        stopBtnDiscrLabel.backgroundColor = .clear
        stopBtnDiscrLabel.text = "Когда невозможно различить число в центральном окне - нажмите кнопку с символом '❌'. Тест будет остановлен, результат сохранится. Вам будет предложено пройти тест для другого глаза. Если Вы выйдете до окончания теста - результаты сохранены не будут."
        stopBtnDiscrLabel.font = .systemFont(ofSize: 7)
        stopBtnDiscrLabel.numberOfLines = 0
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        stopBtnDiscrLabel.isUserInteractionEnabled = true
        stopBtnDiscrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: stopBtnDiscrLabel)
    }
    
    
    fileprivate func addTimeProgressDescrView() {
        firstInstrView.addSubview(timeProgressDiscrLTS)
        timeProgressDiscrLTS.radius = 10
        timeProgressDiscrLTS.fat = 5
        timeProgressDiscrLTS.ratio = 1/2
        
        timeProgressDiscrLTS.translatesAutoresizingMaskIntoConstraints = false
        timeProgressDiscrLTS.rightAnchor.constraint(equalTo: firstInstrView.rightAnchor, constant: -5).isActive = true
        timeProgressDiscrLTS.topAnchor.constraint(equalTo: basicHyperScreenImageView.centerYAnchor, constant: 12).isActive = true
        timeProgressDiscrLTS.heightAnchor.constraint(equalTo: basicHyperScreenImageView.heightAnchor, multiplier: 1/7).isActive = true
        timeProgressDiscrLTS.leftAnchor.constraint(equalTo: basicHyperScreenImageView.centerXAnchor, constant: 20).isActive = true
        timeProgressDiscrLTS.backgroundColor = .clear
        
        
        timeProgressDiscrLTS.addSubview(timeProgressDiscrLabel)
        timeProgressDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        timeProgressDiscrLabel.rightAnchor.constraint(equalTo: timeProgressDiscrLTS.rightAnchor, constant: -5).isActive = true
        timeProgressDiscrLabel.topAnchor.constraint(equalTo: timeProgressDiscrLTS.topAnchor, constant: 5).isActive = true
        timeProgressDiscrLabel.heightAnchor.constraint(equalTo: timeProgressDiscrLTS.heightAnchor, multiplier: 10/11).isActive = true
        timeProgressDiscrLabel.widthAnchor.constraint(equalTo: timeProgressDiscrLTS.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        timeProgressDiscrLabel.backgroundColor = .clear
        timeProgressDiscrLabel.text = "Индикатор оставшегося времени до момента появления нового числа."
        timeProgressDiscrLabel.font = .systemFont(ofSize: 7)
        timeProgressDiscrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        timeProgressDiscrLabel.isUserInteractionEnabled = true
        timeProgressDiscrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: timeProgressDiscrLabel)
    }
    
    fileprivate func addKeyboardDescrView() {
        firstInstrView.addSubview(keyboardDiscrLTS)
        keyboardDiscrLTS.radius = 10
        keyboardDiscrLTS.fat = 5
        keyboardDiscrLTS.ratio = 1/2
        
        keyboardDiscrLTS.translatesAutoresizingMaskIntoConstraints = false
        keyboardDiscrLTS.rightAnchor.constraint(equalTo: firstInstrView.rightAnchor, constant: -5).isActive = true
        keyboardDiscrLTS.topAnchor.constraint(equalTo: timeProgressDiscrLTS.bottomAnchor, constant: 12).isActive = true
        keyboardDiscrLTS.heightAnchor.constraint(equalTo: basicHyperScreenImageView.heightAnchor, multiplier: 1/5).isActive = true
        keyboardDiscrLTS.leftAnchor.constraint(equalTo: basicHyperScreenImageView.centerXAnchor, constant: 20).isActive = true
        keyboardDiscrLTS.backgroundColor = .clear
        
        
        keyboardDiscrLTS.addSubview(keyboardDiscrLabel)
        keyboardDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        keyboardDiscrLabel.rightAnchor.constraint(equalTo: keyboardDiscrLTS.rightAnchor, constant: -5).isActive = true
        keyboardDiscrLabel.topAnchor.constraint(equalTo: keyboardDiscrLTS.topAnchor, constant: 5).isActive = true
        keyboardDiscrLabel.heightAnchor.constraint(equalTo: keyboardDiscrLTS.heightAnchor, multiplier: 10/11).isActive = true
        keyboardDiscrLabel.widthAnchor.constraint(equalTo: keyboardDiscrLTS.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        keyboardDiscrLabel.backgroundColor = .clear
        keyboardDiscrLabel.text = "Наберите на клавиатуре число, которое указано в центре экрана."
        keyboardDiscrLabel.font = .systemFont(ofSize: 7)
        keyboardDiscrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        keyboardDiscrLabel.isUserInteractionEnabled = true
        keyboardDiscrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: keyboardDiscrLabel)
    }
    
    fileprivate func addtextFielDescrView() {
        firstInstrView.addSubview(textFieldDiscrRTS)
        textFieldDiscrRTS.radius = 10
        textFieldDiscrRTS.fat = 5
        textFieldDiscrRTS.ratio = 2/5
        
        textFieldDiscrRTS.translatesAutoresizingMaskIntoConstraints = false
        textFieldDiscrRTS.rightAnchor.constraint(equalTo: basicHyperScreenImageView.leftAnchor, constant: 40).isActive = true
        textFieldDiscrRTS.topAnchor.constraint(equalTo: basicHyperScreenImageView.centerYAnchor, constant: 20).isActive = true
        textFieldDiscrRTS.heightAnchor.constraint(equalTo: basicHyperScreenImageView.heightAnchor, multiplier: 1/4).isActive = true
        textFieldDiscrRTS.leftAnchor.constraint(equalTo: firstInstrView.leftAnchor, constant: 5).isActive = true
        textFieldDiscrRTS.backgroundColor = .clear
        
        
        textFieldDiscrRTS.addSubview(textFieldLabel)
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.leftAnchor.constraint(equalTo: textFieldDiscrRTS.leftAnchor, constant: 5).isActive = true
        textFieldLabel.topAnchor.constraint(equalTo: textFieldDiscrRTS.topAnchor, constant: 5).isActive = true
        textFieldLabel.heightAnchor.constraint(equalTo: textFieldDiscrRTS.heightAnchor, multiplier: 10/11).isActive = true
        textFieldLabel.widthAnchor.constraint(equalTo: textFieldDiscrRTS.widthAnchor, multiplier: 3/5, constant: -10).isActive = true
        textFieldLabel.backgroundColor = .clear
        textFieldLabel.text = "Текстовое поле, в котором отображаются введенные на клавиатуре цифры."
        textFieldLabel.font = .systemFont(ofSize: 7)
        textFieldLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        textFieldLabel.isUserInteractionEnabled = true
        textFieldLabel.addGestureRecognizer(tap)
        
        lupaInView(view: textFieldLabel)
    }
    
    fileprivate func addNumberDescrView() {
        firstInstrView.addSubview(numberDiscrRBS)
        numberDiscrRBS.radius = 10
        numberDiscrRBS.fat = 10
        numberDiscrRBS.ratio = 1/2
        
        numberDiscrRBS.translatesAutoresizingMaskIntoConstraints = false
        numberDiscrRBS.rightAnchor.constraint(equalTo: basicHyperScreenImageView.centerXAnchor, constant: -15).isActive = true
        numberDiscrRBS.bottomAnchor.constraint(equalTo: basicHyperScreenImageView.centerYAnchor, constant: 0).isActive = true
        numberDiscrRBS.heightAnchor.constraint(equalTo: basicHyperScreenImageView.heightAnchor, multiplier: 10/45).isActive = true
        numberDiscrRBS.leftAnchor.constraint(equalTo: firstInstrView.leftAnchor, constant: 5).isActive = true
        numberDiscrRBS.backgroundColor = .clear
        numberDiscrRBS.layer.borderColor = UIColor.clear.cgColor
        
        
        numberDiscrRBS.addSubview(numberDiscrLabel)
        numberDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        numberDiscrLabel.leftAnchor.constraint(equalTo: numberDiscrRBS.leftAnchor, constant: 5).isActive = true
        numberDiscrLabel.topAnchor.constraint(equalTo: numberDiscrRBS.topAnchor, constant: 5).isActive = true
        numberDiscrLabel.heightAnchor.constraint(equalTo: numberDiscrRBS.heightAnchor, multiplier: 10/11).isActive = true
        numberDiscrLabel.widthAnchor.constraint(equalTo: numberDiscrRBS.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        numberDiscrLabel.backgroundColor = .clear
        numberDiscrLabel.text = " Трехзначное число. Если введенное Вами число окажется равно данному числу, то у следующего числа будет более мелкий шрифт."
        numberDiscrLabel.font = .systemFont(ofSize: 7)
        numberDiscrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        numberDiscrLabel.isUserInteractionEnabled = true
        numberDiscrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: numberDiscrLabel)
    }
    //MARK:bigLabel
    @objc func bigLabelAction(recognizer: UIGestureRecognizer) {
        //var bottomAnch = symbolDiscrLBS.bottomAnchor
        var text = String()
        if recognizer.view == closeEyeDiscrLabel{
            
            text = closeEyeDiscrLabel.text ?? ""
            
        }else if recognizer.view == stopBtnDiscrLabel{
            text = stopBtnDiscrLabel.text ?? ""
            
        }else if recognizer.view == timeProgressDiscrLabel{
            text = timeProgressDiscrLabel.text ?? ""
            
        }else if recognizer.view == textFieldLabel{
            text = textFieldLabel.text ?? ""
            
        }else if recognizer.view == numberDiscrLabel{
            text = numberDiscrLabel.text ?? ""
            
        }else if recognizer.view == speechSymbolDiscrLabel{
            text = speechSymbolDiscrLabel.text ?? ""
            
        }
        else if recognizer.view == lineDescrLabel{
            text = lineDescrLabel.text ?? ""
            
        }
        else if recognizer.view == keyboardDiscrLabel{
            text = keyboardDiscrLabel.text ?? ""
            
        }
        
        //bigLabel.center = view.center
        bigLabel.frame = CGRect(origin: CGPoint(x: view.frame.width/6, y: view.frame.height/4),
                                size: CGSize(width: view.frame.width*2/3, height: view.frame.height/2))
        
        view.addSubview(bigLabel)
        
        bigLabel.text = text
        bigLabel.backgroundColor = .white
        bigLabel.numberOfLines = 0
        bigLabel.layer.cornerRadius = 20
        bigLabel.clipsToBounds = true
        bigLabel.layer.borderWidth = 1
        bigLabel.textAlignment = .center
        
        bigLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelRemove))
        bigLabel.addGestureRecognizer(tap)
    }
    
    
    @objc func bigLabelRemove(){
        bigLabel.removeFromSuperview()
    }
    //MARK: addSecondInstrView()
    func addSecondInstrView() {
        scrollInfoView.addSubview(secondInstrView)
        
        secondInstrView.translatesAutoresizingMaskIntoConstraints = false
        secondInstrView.widthAnchor.constraint(equalTo: scrollInfoView.widthAnchor, multiplier: 95/100).isActive = true
        secondInstrView.topAnchor.constraint(equalTo: firstInstrView.bottomAnchor, constant: 10).isActive = true
        secondInstrView.heightAnchor.constraint(equalToConstant: 650).isActive = true
        secondInstrView.centerXAnchor.constraint(equalTo: scrollInfoView.centerXAnchor).isActive = true
        
        secondInstrView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        secondInstrView.layer.cornerRadius = 20
        secondInstrView.layer.shadowOpacity = 0.1
        secondInstrView.layer.shadowColor = UIColor.gray.cgColor
        
        addHowDoRecognLabel()
        
    }
    
    func addHowDoRecognLabel() {
        secondInstrView.addSubview(howDoRecognLabel)
        
        howDoRecognLabel.translatesAutoresizingMaskIntoConstraints = false
        howDoRecognLabel.widthAnchor.constraint(equalTo: secondInstrView.widthAnchor, multiplier: 95/100).isActive = true
        howDoRecognLabel.topAnchor.constraint(equalTo: secondInstrView.topAnchor, constant: 10).isActive = true
        howDoRecognLabel.heightAnchor.constraint(equalTo: secondInstrView.heightAnchor, multiplier: 1/2, constant: 0).isActive = true
        howDoRecognLabel.centerXAnchor.constraint(equalTo: scrollInfoView.centerXAnchor).isActive = true
        
        howDoRecognLabel.text = "Для распознавания речи включите соответствующий переключатель в настройках приложения.\n\n Тест проводится как и при выключенном распознавании речи, только надо не набирать на клавиатуре цифры, а произносить их в микрофон телефона. Можно использовать беспроводную гарнитуру.\n\n В случае невозможности определения числа на экране скажите 'СТОП'."
        
        howDoRecognLabel.numberOfLines = 0
        
        secondInstrView.addSubview(speechRecScreenImageView)
        
        speechRecScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        speechRecScreenImageView.widthAnchor.constraint(equalTo: secondInstrView.widthAnchor, multiplier: 1/3).isActive = true
        speechRecScreenImageView.heightAnchor.constraint(equalTo: speechRecScreenImageView.widthAnchor, multiplier: 2.1).isActive = true
        speechRecScreenImageView.leftAnchor.constraint(equalTo: secondInstrView.leftAnchor, constant: 20).isActive = true
        speechRecScreenImageView.bottomAnchor.constraint(equalTo: secondInstrView.bottomAnchor, constant: -40).isActive = true
        speechRecScreenImageView.backgroundColor = .clear
        speechRecScreenImageView.image = UIImage(named: "hyperopia speechRec screen")
        speechRecScreenImageView.layer.borderWidth = 0.5
        
        addSpeechSymbolDescrView()
        
        addLineDescrView()
    }
    
    func addSpeechSymbolDescrView() {
        
        secondInstrView.addSubview(speechSymbolDiscrLBS)
        
        speechSymbolDiscrLBS.radius = 10
        speechSymbolDiscrLBS.fat = 10
        speechSymbolDiscrLBS.ratio = 3/10
        
        speechSymbolDiscrLBS.translatesAutoresizingMaskIntoConstraints = false
        speechSymbolDiscrLBS.bottomAnchor.constraint(equalTo: speechRecScreenImageView.centerYAnchor).isActive = true
        speechSymbolDiscrLBS.leftAnchor.constraint(equalTo: speechRecScreenImageView.centerXAnchor, constant: 10).isActive = true
        speechSymbolDiscrLBS.heightAnchor.constraint(equalTo: speechRecScreenImageView.heightAnchor, multiplier: 1/3).isActive = true
        speechSymbolDiscrLBS.rightAnchor.constraint(equalTo: secondInstrView.rightAnchor, constant: -20).isActive = true
        speechSymbolDiscrLBS.backgroundColor = .clear
        
        speechSymbolDiscrLBS.addSubview(speechSymbolDiscrLabel)
        
        speechSymbolDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        speechSymbolDiscrLabel.topAnchor.constraint(equalTo: speechSymbolDiscrLBS.topAnchor, constant: 5).isActive = true
        speechSymbolDiscrLabel.rightAnchor.constraint(equalTo: speechSymbolDiscrLBS.rightAnchor, constant: -5).isActive = true
        speechSymbolDiscrLabel.heightAnchor.constraint(equalTo: speechSymbolDiscrLBS.heightAnchor, constant: -10).isActive = true
        speechSymbolDiscrLabel.widthAnchor.constraint(equalTo: speechSymbolDiscrLBS.widthAnchor, multiplier: 7/10, constant: -10).isActive = true
        speechSymbolDiscrLabel.backgroundColor = .clear
        
        speechSymbolDiscrLabel.text = "Если Вы можете различить число - произнесите в микрофон какое число Вы видите, например: 'двести сорок пять' или 'два' 'четыре' 'пять'. Когда Вы правильно назовете число - на экране появится число более мелкого размера. Если невозможно определить число  - произнесите слово 'СТОП'. Тест завершится. Результат будет сохранен."
        speechSymbolDiscrLabel.font = .systemFont(ofSize: 7)
        speechSymbolDiscrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        speechSymbolDiscrLabel.isUserInteractionEnabled = true
        speechSymbolDiscrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: speechSymbolDiscrLabel)
    }
    
    func addLineDescrView() {
        
        secondInstrView.addSubview(lineDescrLTS)
        
        lineDescrLTS.radius = 10
        lineDescrLTS.fat = 5
        lineDescrLTS.ratio = 3/10
        
        lineDescrLTS.translatesAutoresizingMaskIntoConstraints = false
        lineDescrLTS.topAnchor.constraint(equalTo: speechRecScreenImageView.centerYAnchor,  constant: 20).isActive = true
        lineDescrLTS.leftAnchor.constraint(equalTo: speechRecScreenImageView.centerXAnchor, constant: 20).isActive = true
        lineDescrLTS.heightAnchor.constraint(equalTo: speechRecScreenImageView.heightAnchor, multiplier: 1/7).isActive = true
        lineDescrLTS.rightAnchor.constraint(equalTo: secondInstrView.rightAnchor, constant: -20).isActive = true
        lineDescrLTS.backgroundColor = .clear
        
        lineDescrLTS.addSubview(lineDescrLabel)
        
        lineDescrLabel.translatesAutoresizingMaskIntoConstraints = false
        lineDescrLabel.topAnchor.constraint(equalTo: lineDescrLTS.topAnchor, constant: 5).isActive = true
        lineDescrLabel.rightAnchor.constraint(equalTo: lineDescrLTS.rightAnchor, constant: -5).isActive = true
        lineDescrLabel.heightAnchor.constraint(equalTo: lineDescrLTS.heightAnchor, constant: -10).isActive = true
        lineDescrLabel.widthAnchor.constraint(equalTo: lineDescrLTS.widthAnchor, multiplier: 7/10, constant: -10).isActive = true
        lineDescrLabel.backgroundColor = .clear
        
        lineDescrLabel.text = "Текстовое поле, в котором будет отображаться текст, который Вы произнесете в микрофон."
        lineDescrLabel.font = .systemFont(ofSize: 7)
        lineDescrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        lineDescrLabel.isUserInteractionEnabled = true
        lineDescrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: lineDescrLabel)
    }
    
    func lupaInView(view: UIView){
        let labelLupa = UILabel()
        view.addSubview(labelLupa)
        labelLupa.translatesAutoresizingMaskIntoConstraints = false
        labelLupa.text = "🔎"
        labelLupa.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        labelLupa.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        labelLupa.widthAnchor.constraint(equalToConstant: 40).isActive = true
        labelLupa.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelLupa.alpha = 0.7
        labelLupa.font = .boldSystemFont(ofSize: 20)
    }
}



