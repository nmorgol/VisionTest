

import UIKit

class NormalLightView: UIView {

    override func draw(_ rect: CGRect) {
        
        let centralLine = UIBezierPath()
        let upLine = UIBezierPath()
        let downLine = UIBezierPath()
        let leftLine = UIBezierPath()
        let points = UIBezierPath()
        let number = UIBezierPath()
        let letter = UIBezierPath()
        
        centralLine.move(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*4.75/10))
        centralLine.addLine(to: CGPoint(x: self.frame.width*1.5/10, y: self.frame.height/2))
        centralLine.addLine(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*5.25/10))
        
        centralLine.move(to: CGPoint(x: 0, y: self.frame.height/2))
        centralLine.addLine(to: CGPoint(x: self.frame.width*3/4, y: self.frame.height/2  ))
        
        centralLine.lineWidth = 1
        UIColor.blue.setStroke()
        centralLine.stroke()
        
        
        upLine.move(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*3.75/10))
        upLine.addLine(to: CGPoint(x: self.frame.width*1.5/10, y: self.frame.height*4/10))
        upLine.addLine(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*4.25/10))
        
        upLine.move(to: CGPoint(x: 0, y: self.frame.height*4/10))
        upLine.addLine(to: CGPoint(x: self.frame.width/4 + self.frame.width/11, y: self.frame.height*4/10))//делить на 11 получил подбором
        upLine.addLine(to: CGPoint(x: self.frame.width*3/4, y: self.frame.height/2  ))
        
        upLine.lineWidth = 1
        UIColor.blue.setStroke()
        upLine.stroke()
        
        
        downLine.move(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*5.75/10))
        downLine.addLine(to: CGPoint(x: self.frame.width*1.5/10, y: self.frame.height*6/10))
        downLine.addLine(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*6.25/10))
        
        downLine.move(to: CGPoint(x: 0, y: self.frame.height*6/10))
        downLine.addLine(to: CGPoint(x: self.frame.width/4 + self.frame.width/11, y: self.frame.height*6/10))
        downLine.addLine(to: CGPoint(x: self.frame.width*3/4, y: self.frame.height/2  ))
        
        downLine.lineWidth = 1
        UIColor.blue.setStroke()
        downLine.stroke()
        
        
        leftLine.move(to: CGPoint(x: self.frame.width/40, y: self.frame.height*3/4 + self.frame.height/80))
        leftLine.addLine(to: CGPoint(x: 0, y: self.frame.height*3/4))
        leftLine.addLine(to: CGPoint(x: self.frame.width/40, y: self.frame.height*3/4 - self.frame.height/80))
        
        leftLine.move(to: CGPoint(x: 0, y: self.frame.height*3/4))
        leftLine.addLine(to: CGPoint(x: self.frame.width*3/40, y: self.frame.height*3/4))
        
        leftLine.move(to: CGPoint(x: self.frame.width*7/40, y: self.frame.height*3/4))
        leftLine.addLine(to: CGPoint(x: self.frame.width*1/4, y: self.frame.height*3/4))
        
        leftLine.move(to: CGPoint(x: self.frame.width/4 - self.frame.width/40, y: self.frame.height*3/4 - self.frame.height/80))
        leftLine.addLine(to: CGPoint(x: self.frame.width/4, y: self.frame.height*3/4))
        leftLine.addLine(to: CGPoint(x: self.frame.width/4 - self.frame.width/40, y: self.frame.height*3/4 + self.frame.height/80))
        
        leftLine.lineWidth = 1
        UIColor.red.setStroke()
        leftLine.stroke()
        
        
        points.move(to: CGPoint(x: self.frame.width/10, y: self.frame.height*3/4 + self.frame.height/160))
        points.addLine(to: CGPoint(x: self.frame.width/10, y: self.frame.height*3/4 - self.frame.height/160))
        
        points.move(to: CGPoint(x: self.frame.width*3/20, y: self.frame.height*3/4 + self.frame.height/160))
        points.addLine(to: CGPoint(x: self.frame.width*3/20, y: self.frame.height*3/4 - self.frame.height/160))
        
        points.move(to: CGPoint(x: self.frame.width*5/40, y: self.frame.height*3/4 + self.frame.height/160))
        points.addLine(to: CGPoint(x: self.frame.width*5/40, y: self.frame.height*3/4 - self.frame.height/160))
        
        points.lineWidth = 1
        UIColor.red.setStroke()
        points.stroke()
        
        
//        number.move(to: CGPoint(x: self.frame.width*2/20 + self.frame.width*1/40,
//                                y: self.frame.height*3/4 + self.frame.height*1/20))
//        
//        number.addLine(to: CGPoint(x: self.frame.width*2/20,
//                                   y: self.frame.height*3/4 + self.frame.height*1/20))
//        
//        number.addLine(to: CGPoint(x: self.frame.width*2/20,
//                                   y: self.frame.height*3/4 + self.frame.height*3/40))
//        
//        number.addCurve(to: CGPoint(x: self.frame.width*2/20,
//                                    y: self.frame.height*3/4 + self.frame.height*2/20),
//                        controlPoint1: CGPoint(x: self.frame.width*2/20 + self.frame.width*3/80,
//                                               y: self.frame.height*3/4 + self.frame.height*5/80),
//                        controlPoint2: CGPoint(x: self.frame.width*2/20 + self.frame.width*3/80,
//                                               y: self.frame.height*3/4 + self.frame.height*9/80))
//        
//        number.lineWidth = 1
//        UIColor.red.setStroke()
//        number.stroke()
//        
//        letter.move(to: CGPoint(x: self.frame.width*3/20, y: self.frame.height*3/4 + self.frame.height*2/20))
//        letter.addLine(to: CGPoint(x: self.frame.width*3/20, y: self.frame.height*3/4 + self.frame.height*3/40))
//        letter.addLine(to: CGPoint(x: self.frame.width*13/80, y: self.frame.height*3/4 + self.frame.height*7/80))
//        letter.addLine(to: CGPoint(x: self.frame.width*14/80, y: self.frame.height*3/4 + self.frame.height*6/80))
//        letter.addLine(to: CGPoint(x: self.frame.width*7/40, y: self.frame.height*3/4 + self.frame.height*8/80))
//        letter.move(to: CGPoint(x: self.frame.width*2/10,
//                                y: self.frame.height*3/4 + self.frame.height*1/10 + self.frame.height*1/160))
//        letter.addLine(to: CGPoint(x: self.frame.width*2/10,
//                                y: self.frame.height*3/4 + self.frame.height*1/10 - self.frame.height*1/160))
//        
//        letter.lineWidth = 1
//        UIColor.red.setStroke()
//        letter.stroke()
    }
    

}
