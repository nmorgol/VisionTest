

import UIKit

class SectorView: UIView {

    
    override func draw(_ rect: CGRect) {
        
        
        
        let lightBlueYZ = UIBezierPath() // выделеная область Y0Z
        let lightBlueXZ = UIBezierPath() // выделеная область X0Z
        let lightBlueXY = UIBezierPath() // выделеная область X0Y
        //оси координат
        let lineZ = UIBezierPath()
        let lineY = UIBezierPath()
        let lineX = UIBezierPath()

        
        
        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/10))
        lightBlueYZ.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                       radius: self.frame.width*4/10,
                       startAngle: CGFloat.pi*3/2,
                       endAngle: CGFloat.pi*2,
                       clockwise: true)
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lightBlueYZ.close()
        
        #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).setFill()
        lightBlueYZ.fill()
//        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/10))
//        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/30,
//                                        y: self.frame.height/10 - self.frame.height/70))
//        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/10))
//        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/30,
//                                        y: self.frame.height/10 + self.frame.height/80))
//        lightBlueYZ.move(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2))
//        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width*9/10 + self.frame.width/70,
//                                        y: self.frame.height/2 - self.frame.height/30))
//        lightBlueYZ.move(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2))
//        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width*9/10 - self.frame.width/80,
//                                        y: self.frame.height/2 - self.frame.height/30))
        
        
        lightBlueYZ.lineWidth = 2
        UIColor.black.setStroke()
        lightBlueYZ.stroke()
        
        lightBlueXZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/10))
        lightBlueXZ.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                           radius: self.frame.width*4/10,
                           startAngle: CGFloat.pi*3/2,
                           endAngle: CGFloat.pi*7/8 + CGFloat.pi/32 - CGFloat.pi/128,
                           clockwise: false)
        lightBlueXZ.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lightBlueXZ.close()
        
        lightBlueXZ.apply(CGAffineTransform.init(scaleX: 1/3, y: 1))
        lightBlueXZ.apply(CGAffineTransform.init(translationX: self.frame.width/3, y: 0))
        
        #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).setFill()
        lightBlueXZ.fill()
//        lightBlueXZ.lineWidth = 1
//        UIColor.black.setStroke()
//        lightBlueXZ.stroke()
        
        
        
        
        
        lightBlueXY.move(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2))
        lightBlueXY.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                           radius: self.frame.width*4/10,
                           startAngle: CGFloat.pi*0,
                           endAngle: CGFloat.pi*5/8 - CGFloat.pi/32 + CGFloat.pi/128,
                           clockwise: true)
        lightBlueXY.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lightBlueXY.close()
        
        lightBlueXY.apply(CGAffineTransform.init(scaleX: 1, y: 1/3))
        lightBlueXY.apply(CGAffineTransform.init(translationX: 0, y: self.frame.height/3))
        
        #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).setFill()
        lightBlueXY.fill()
//        lightBlueXY.lineWidth = 1
//        UIColor.black.setStroke()
//        lightBlueXY.stroke()
        
        
        
        
        
        
        
        lineZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lineZ.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height*5/100))
        lineZ.addLine(to: CGPoint(x: self.frame.width/2 - self.frame.width/80,
                                  y: self.frame.height*5/100 + self.frame.height/40))
        lineZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height*5/100))
        lineZ.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/80,
        y: self.frame.height*5/100 + self.frame.height/40))
        
        lineZ.lineWidth = 1
        UIColor.black.setStroke()
        lineZ.stroke()
        
        
        lineY.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lineY.addLine(to: CGPoint(x: self.frame.width*95/100, y: self.frame.height/2))
        lineY.addLine(to: CGPoint(x: self.frame.width*95/100 - self.frame.width/40,
                                  y: self.frame.height/2 - self.frame.height/80))
        lineY.move(to: CGPoint(x: self.frame.width*95/100, y: self.frame.height/2))
        lineY.addLine(to: CGPoint(x: self.frame.width*95/100 - self.frame.width/40,
        y: self.frame.height/2 + self.frame.height/80))
        
        lineY.lineWidth = 1
        UIColor.black.setStroke()
        lineY.stroke()
        
        
        lineX.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lineX.addLine(to: CGPoint(x: self.frame.width*3/10, y: self.frame.height*7/10))
        lineX.addLine(to: CGPoint(x: self.frame.width*3/10 + self.frame.width/80,
                                  y: self.frame.height*7/10 - self.frame.height/40))
        lineX.move(to: CGPoint(x: self.frame.width*3/10, y: self.frame.height*7/10))
        lineX.addLine(to: CGPoint(x: self.frame.width*3/10 + self.frame.width/40,
                                  y: self.frame.height*7/10 - self.frame.height/80))
        
        lineX.lineWidth = 1
        UIColor.black.setStroke()
        lineX.stroke()
        
        
        
        
        
    }


}

