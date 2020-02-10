

import UIKit

class SpeakLeftBottomView: UIView {

    let speak = UIBezierPath()
    var radius = CGFloat(5)
    var fat = CGFloat(10)
    var ratio = CGFloat(1/2)
    var strokeColor = UIColor.black
    var fillColor = UIColor.white
    
    
    override func draw(_ rect: CGRect) {
        
        speak.lineWidth = 0.5
        let otstup = speak.lineWidth
        
        speak.move(to: CGPoint(x: otstup, y: self.frame.height - otstup))
        
        speak.addLine(to: CGPoint(x: self.frame.width - radius - otstup, y: self.frame.height - otstup))
        
        speak.addArc(withCenter: CGPoint(x: self.frame.width - radius - otstup, y: self.frame.height - radius - otstup),
                     radius: radius,
                     startAngle: CGFloat.pi/2,
                     endAngle: CGFloat.pi*0,
                     clockwise: false)
        
        speak.addLine(to: CGPoint(x: self.frame.width - otstup, y: radius + otstup))
        
        speak.addArc(withCenter: CGPoint(x: self.frame.width - radius - otstup, y: radius + otstup),
        radius: radius,
        startAngle: CGFloat.pi*0,
        endAngle: CGFloat.pi*3/2,
        clockwise: false)
        
        speak.addLine(to: CGPoint(x: self.frame.width*ratio + radius, y: otstup))
        
        speak.addArc(withCenter: CGPoint(x: self.frame.width*ratio + radius, y: radius + otstup),
        radius: radius,
        startAngle: CGFloat.pi/2,
        endAngle: CGFloat.pi,
        clockwise: false)
        
        speak.addLine(to: CGPoint(x: self.frame.width*ratio, y: self.frame.height - fat))
        speak.close()
        
        
        
        strokeColor.setStroke()
        speak.stroke()
        
        fillColor.setFill()
        speak.fill()
    }
    

}
