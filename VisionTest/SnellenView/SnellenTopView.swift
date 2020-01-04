

import UIKit

class SnellenTopView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let blackRect = UIBezierPath()
        let topLeftRect = UIBezierPath()
        let topRightRect = UIBezierPath()
        
        blackRect.move(to: CGPoint(x: 0, y: 0))
        blackRect.addLine(to: CGPoint(x: 0, y: self.frame.height))
        blackRect.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        blackRect.addLine(to: CGPoint(x: self.frame.width, y: 0))
        blackRect.close()
        UIColor.black.setFill()
        blackRect.fill()
        
        topLeftRect.move(to: CGPoint(x: self.frame.width*0.2, y: 0))
        topLeftRect.addLine(to: CGPoint(x: self.frame.width*0.4, y: 0))
        topLeftRect.addLine(to: CGPoint(x: self.frame.width*0.4, y: self.frame.height*0.8))
        topLeftRect.addLine(to: CGPoint(x: self.frame.width*0.2, y: self.frame.height*0.8))
        topLeftRect.close()
        UIColor.white.setFill()
        topLeftRect.fill()
        
        topRightRect.move(to: CGPoint(x: self.frame.width*0.6, y: 0))
        topRightRect.addLine(to: CGPoint(x: self.frame.width*0.8, y: 0))
        topRightRect.addLine(to: CGPoint(x: self.frame.width*0.8, y: self.frame.height*0.8))
        topRightRect.addLine(to: CGPoint(x: self.frame.width*0.6, y: self.frame.height*0.8))
        topRightRect.close()
        UIColor.white.setFill()
        topRightRect.fill()
        
    }

}
