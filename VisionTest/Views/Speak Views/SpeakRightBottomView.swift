

import UIKit

class SpeakRightBottomView: UIView {

    let speak = UIBezierPath()
    var radius = CGFloat(5)
    var fat = CGFloat(10)
    var ratio = CGFloat(1/2)
    var strokeColor = UIColor.black
    var fillColor = UIColor.white
    
    
    override func draw(_ rect: CGRect) {
        
        
        speak.lineWidth = 0.5
        let otstup = speak.lineWidth
        speak.move(to: CGPoint(x: self.frame.width - otstup, y: self.frame.height - otstup))
        
        speak.addLine(to: CGPoint(x: otstup + radius, y: self.frame.height - otstup))
        
        speak.addArc(withCenter: CGPoint(x: otstup + radius, y: self.frame.height - otstup - radius),
                     radius: radius,
                     startAngle: CGFloat.pi*1/2,
                     endAngle: CGFloat.pi*1,
                     clockwise: true)
        
        speak.addLine(to: CGPoint(x: otstup, y: otstup + radius))
        
        speak.addArc(withCenter: CGPoint(x: radius + otstup, y: radius + otstup),
        radius: radius,
        startAngle: CGFloat.pi*1,
        endAngle: CGFloat.pi*3/2,
        clockwise: true)
        
        speak.addLine(to: CGPoint(x: self.frame.width*ratio + radius, y: otstup))
        
        speak.addArc(withCenter: CGPoint(x: self.frame.width*(1 - ratio) - radius, y:radius + otstup),
        radius: radius,
        startAngle: CGFloat.pi*3/2,
        endAngle: CGFloat.pi*2,
        clockwise: true)
        
        speak.addLine(to: CGPoint(x: self.frame.width*(1 - ratio), y: self.frame.height - fat))
        speak.close()
        
        
        
        strokeColor.setStroke()
        speak.stroke()
        
        fillColor.setFill()
        speak.fill()
    }

}
