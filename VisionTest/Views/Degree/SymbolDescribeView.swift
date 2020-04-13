

import UIKit

class SymbolDescribeView: UIView {

    
    
    override func draw(_ rect: CGRect) {
        
        let backround = UIBezierPath()
        let symbol = UIBezierPath()
        let symbolCenter = UIBezierPath()
        let roundrect = UIBezierPath()
        let lineRazr = UIBezierPath()
        let lineAngle = UIBezierPath()
        let lineDist = UIBezierPath()
        let lineAngleDiscr = UIBezierPath()
        
        
        backround.move(to: CGPoint(x: 0, y: 0))
        backround.addLine(to: CGPoint(x: self.frame.width, y: 0))
        backround.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        backround.addLine(to: CGPoint(x: 0, y: self.frame.height))
        backround.close()
        UIColor.white.setFill()
        backround.fill()
        
        symbol.move(to: CGPoint(x: self.frame.width*3/2, y: self.frame.height/4))
        symbol.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/4),
                      radius: self.frame.height/4,
                      startAngle: CGFloat.pi*0,
                      endAngle: CGFloat.pi*2,
                      clockwise: true)
        UIColor.black.setFill()
        symbol.fill()
        
        symbolCenter.move(to: CGPoint(x: self.frame.width*13/20, y: self.frame.height/4))
        symbolCenter.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/4),
                            radius: self.frame.width*3/20,
                            startAngle: CGFloat.pi*0,
                            endAngle: CGFloat.pi*2,
                            clockwise: true)
        UIColor.white.setFill()
        symbolCenter.fill()
        
        roundrect.move(to: CGPoint(x: self.frame.width*9/20, y: self.frame.height/4))
        roundrect.addLine(to: CGPoint(x: self.frame.width*9/20, y: self.frame.height/2))
        roundrect.addLine(to: CGPoint(x: self.frame.width*11/20, y: self.frame.height/2))
        roundrect.addLine(to: CGPoint(x: self.frame.width*11/20, y: self.frame.height/4))
        roundrect.close()
        UIColor.white.setFill()
        roundrect.fill()
        
        lineRazr.move(to: CGPoint(x: self.frame.width*4/20, y: self.frame.height/2))
        lineRazr.addLine(to: CGPoint(x: self.frame.width*16/20, y: self.frame.height/2))
        lineRazr.move(to: CGPoint(x: self.frame.width*9/20, y: self.frame.height/2))
        lineRazr.addLine(to: CGPoint(x: self.frame.width*8/20, y: self.frame.height*102/200))
        lineRazr.move(to: CGPoint(x: self.frame.width*9/20, y: self.frame.height/2))
        lineRazr.addLine(to: CGPoint(x: self.frame.width*8/20, y: self.frame.height*98/200))
        lineRazr.move(to: CGPoint(x: self.frame.width*11/20, y: self.frame.height/2))
        lineRazr.addLine(to: CGPoint(x: self.frame.width*12/20, y: self.frame.height*102/200))
        lineRazr.move(to: CGPoint(x: self.frame.width*11/20, y: self.frame.height/2))
        lineRazr.addLine(to: CGPoint(x: self.frame.width*12/20, y: self.frame.height*98/200))
        UIColor.blue.setStroke()
        lineRazr.stroke()
        
        lineAngle.move(to: CGPoint(x: self.frame.width*9/20, y: self.frame.height/2))
        lineAngle.addLine(to: CGPoint(x: self.frame.width*1/2, y: self.frame.height*3/4))
        lineAngle.addLine(to: CGPoint(x: self.frame.width*11/20, y: self.frame.height*2/4))
        lineAngle.close()
        UIColor.red.setStroke()
        lineAngle.stroke()
        
        lineDist.move(to: CGPoint(x: self.frame.width*3/4, y: self.frame.height/2))
        lineDist.addLine(to: CGPoint(x: self.frame.width*3/4, y: self.frame.height*3/4))
        lineDist.addLine(to: CGPoint(x: self.frame.width*152/200, y: self.frame.height*14/20))
        lineDist.move(to: CGPoint(x: self.frame.width*3/4, y: self.frame.height*3/4))
        lineDist.addLine(to: CGPoint(x: self.frame.width*148/200, y: self.frame.height*14/20))
        lineDist.move(to: CGPoint(x: self.frame.width*3/4, y: self.frame.height/2))
        lineDist.addLine(to: CGPoint(x: self.frame.width*152/200, y: self.frame.height*11/20))
        lineDist.move(to: CGPoint(x: self.frame.width*3/4, y: self.frame.height/2))
        lineDist.addLine(to: CGPoint(x: self.frame.width*148/200, y: self.frame.height*11/20))
        UIColor.blue.setStroke()
        lineDist.stroke()
        
        lineAngleDiscr.move(to: CGPoint(x: self.frame.width*100/200, y: self.frame.height*13/20))
        lineAngleDiscr.addLine(to: CGPoint(x: self.frame.width*70/200, y: self.frame.height*15/20))
        lineAngleDiscr.addLine(to: CGPoint(x: self.frame.width*20/200, y: self.frame.height*15/20))
        lineAngleDiscr.move(to: CGPoint(x: self.frame.width*100/200, y: self.frame.height*13/20))
        lineAngleDiscr.addLine(to: CGPoint(x: self.frame.width*90/200, y: self.frame.height*134/200))
        lineAngleDiscr.move(to: CGPoint(x: self.frame.width*100/200, y: self.frame.height*13/20))
        lineAngleDiscr.addLine(to: CGPoint(x: self.frame.width*93/200, y: self.frame.height*138/200))
        UIColor.blue.setStroke()
        lineAngleDiscr.stroke()
    }
    

}
