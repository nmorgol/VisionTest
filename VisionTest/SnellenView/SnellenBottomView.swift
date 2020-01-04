

import UIKit

class SnellenBottomView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let blackRect = UIBezierPath()
        let bottomLeftRect = UIBezierPath()
        let bottomRightRect = UIBezierPath()
        
        blackRect.move(to: CGPoint(x: 0, y: 0))
        blackRect.addLine(to: CGPoint(x: 0, y: self.frame.height))
        blackRect.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        blackRect.addLine(to: CGPoint(x: self.frame.width, y: 0))
        blackRect.close()
        UIColor.black.setFill()
        blackRect.fill()
        
        bottomLeftRect.move(to: CGPoint(x: self.frame.width*0.2, y: self.frame.height))
        bottomLeftRect.addLine(to: CGPoint(x: self.frame.width*0.4, y: self.frame.height))
        bottomLeftRect.addLine(to: CGPoint(x: self.frame.width*0.4, y: self.frame.height*0.2))
        bottomLeftRect.addLine(to: CGPoint(x: self.frame.width*0.2, y: self.frame.height*0.2))
        bottomLeftRect.close()
        UIColor.white.setFill()
        bottomLeftRect.fill()
        
        bottomRightRect.move(to: CGPoint(x: self.frame.width*0.6, y: self.frame.height))
        bottomRightRect.addLine(to: CGPoint(x: self.frame.width*0.8, y: self.frame.height))
        bottomRightRect.addLine(to: CGPoint(x: self.frame.width*0.8, y: self.frame.height*0.2))
        bottomRightRect.addLine(to: CGPoint(x: self.frame.width*0.6, y: self.frame.height*0.2))
        bottomRightRect.close()
        UIColor.white.setFill()
        bottomRightRect.fill()
        
    }
}
