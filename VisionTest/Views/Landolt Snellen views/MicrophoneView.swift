

import UIKit

class MicrophoneView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let mainMicrophone = UIBezierPath()
        let bottomSuppor = UIBezierPath()
        let verticalSupport = UIBezierPath()
        let mainSupport = UIBezierPath()
        
        mainMicrophone.move(to: CGPoint(x: self.frame.width*0.3, y: self.frame.width*0.5))
        mainMicrophone.addLine(to: CGPoint(x: self.frame.width*0.3, y: self.frame.height*0.25))
        mainMicrophone.addArc(withCenter: CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.25),
                              radius: self.frame.width*0.2,
                              startAngle: CGFloat(Float.pi),
                              endAngle: CGFloat(Float.pi*2),
                              clockwise: true)
        mainMicrophone.addLine(to: CGPoint(x: self.frame.width*0.7, y: self.frame.height*0.5))
        mainMicrophone.addArc(withCenter: CGPoint(x: self.frame.width*0.5, y: self.frame.width*0.5),
                              radius: self.frame.width*0.2,
                              startAngle: CGFloat(Float.pi*2),
                              endAngle: CGFloat(Float.pi),
                              clockwise: true)
        UIColor.red.setFill()
        mainMicrophone.fill()
        
        bottomSuppor.move(to: CGPoint(x: self.frame.width*0.25, y: self.frame.width*0.95))
        bottomSuppor.addArc(withCenter: CGPoint(x: self.frame.width*0.25, y: self.frame.width*0.925),
        radius: self.frame.width*0.025,
        startAngle: CGFloat(Float.pi/2),
        endAngle: CGFloat(Float.pi*3/2),
        clockwise: true)
        bottomSuppor.addLine(to: CGPoint(x: self.frame.width*0.75, y: self.frame.width*0.9))
        bottomSuppor.addArc(withCenter: CGPoint(x: self.frame.width*0.75, y: self.frame.width*0.925),
        radius: self.frame.width*0.025,
        startAngle: CGFloat(Float.pi*3/2),
        endAngle: CGFloat(Float.pi/2),
        clockwise: true)
        bottomSuppor.close()
        UIColor.red.setFill()
        bottomSuppor.fill()
        
        verticalSupport.move(to: CGPoint(x: self.frame.width*0.45, y: self.frame.width*0.9))
        verticalSupport.addLine(to: CGPoint(x: self.frame.width*0.45, y: self.frame.width*0.775))
        verticalSupport.addLine(to: CGPoint(x: self.frame.width*0.55, y: self.frame.width*0.775))
        verticalSupport.addLine(to: CGPoint(x: self.frame.width*0.55, y: self.frame.width*0.9))
        UIColor.red.setFill()
        verticalSupport.fill()
        
        mainSupport.move(to: CGPoint(x: self.frame.width*0.2, y: self.frame.width*0.5))
        mainSupport.addLine(to: CGPoint(x: self.frame.width*0.2, y: self.frame.width*0.35))
        mainSupport.addArc(withCenter: CGPoint(x: self.frame.width*0.225, y: self.frame.width*0.35),
        radius: self.frame.width*0.025,
        startAngle: CGFloat(Float.pi),
        endAngle: CGFloat(Float.pi*2),
        clockwise: true)
        mainSupport.addLine(to: CGPoint(x: self.frame.width*0.25, y: self.frame.width*0.5))
        mainSupport.addArc(withCenter: CGPoint(x: self.frame.width*0.5, y: self.frame.width*0.5),
        radius: self.frame.width*0.25,
        startAngle: CGFloat(Float.pi),
        endAngle: CGFloat(Float.pi*2),
        clockwise: false)
        mainSupport.addLine(to: CGPoint(x: self.frame.width*0.75, y: self.frame.width*0.35))
        mainSupport.addArc(withCenter: CGPoint(x: self.frame.width*0.775, y: self.frame.width*0.35),
        radius: self.frame.width*0.025,
        startAngle: CGFloat(Float.pi),
        endAngle: CGFloat(Float.pi*2),
        clockwise: true)
        mainSupport.addLine(to: CGPoint(x: self.frame.width*0.8, y: self.frame.width*0.5))
        mainSupport.addArc(withCenter: CGPoint(x: self.frame.width*0.5, y: self.frame.width*0.5),
        radius: self.frame.width*0.3,
        startAngle: CGFloat(Float.pi*2),
        endAngle: CGFloat(Float.pi),
        clockwise: true)
        mainSupport.close()
        UIColor.red.setFill()
        mainSupport.fill()
    }
}
