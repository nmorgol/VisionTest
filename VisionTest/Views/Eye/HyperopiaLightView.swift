

import UIKit

class HyperopiaLightView: UIView {

    override func draw(_ rect: CGRect) {
        
        let centralLine = UIBezierPath()
        let upLine = UIBezierPath()
        let downLine = UIBezierPath()
        
        
        centralLine.move(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*4.75/10))
        centralLine.addLine(to: CGPoint(x: self.frame.width*1.5/10, y: self.frame.height/2))
        centralLine.addLine(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*5.25/10))
        
        centralLine.move(to: CGPoint(x: self.frame.width/10, y: self.frame.height/2))
        centralLine.addLine(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2  ))
        
        centralLine.lineWidth = 1
        UIColor.red.setStroke()
        centralLine.stroke()
        
        upLine.move(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*3.75/10))
        upLine.addLine(to: CGPoint(x: self.frame.width*1.5/10, y: self.frame.height*4/10))
        upLine.addLine(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*4.25/10))
        
        upLine.move(to: CGPoint(x: self.frame.width/10, y: self.frame.height*4/10))
        upLine.addLine(to: CGPoint(x: self.frame.width/4 + self.frame.width/11, y: self.frame.height*4/10))//делить на 11 получил подбором
        upLine.addLine(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2  ))
        
        upLine.lineWidth = 1
        UIColor.red.setStroke()
        upLine.stroke()
        
        downLine.move(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*5.75/10))
        downLine.addLine(to: CGPoint(x: self.frame.width*1.5/10, y: self.frame.height*6/10))
        downLine.addLine(to: CGPoint(x: self.frame.width*1.25/10, y: self.frame.height*6.25/10))
        
        downLine.move(to: CGPoint(x: self.frame.width/10, y: self.frame.height*6/10))
        downLine.addLine(to: CGPoint(x: self.frame.width/4 + self.frame.width/11, y: self.frame.height*6/10))
        downLine.addLine(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2  ))
        
        downLine.lineWidth = 1
        UIColor.red.setStroke()
        downLine.stroke()
    }

}
