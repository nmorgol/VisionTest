//
//  LockUIView.swift
//  VisionTest
//
//  Created by kolya on 2/22/20.
//  Copyright © 2020 kolya. All rights reserved.
//

import UIKit

class LockUIView: UIView {

    override func draw(_ rect: CGRect) {
        let lockBody = UIBezierPath()
        let lockTop = UIBezierPath()
        let forKeyTop = UIBezierPath()
        let forKeyBottom = UIBezierPath()
        
        
        lockBody.move(to: CGPoint(x: self.frame.width/2 - self.frame.width/5, y: self.frame.height/2 - self.frame.height/20))
        lockBody.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/5, y: self.frame.height/2 - self.frame.height/20))
        lockBody.addArc(withCenter: CGPoint(x: self.frame.width/2 + self.frame.width/5, y: self.frame.height/2),
                        radius: self.frame.width/20,
                        startAngle: CGFloat.pi*3/2,
                        endAngle: CGFloat.pi*2,
                        clockwise: true)
        lockBody.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/4, y: self.frame.height/2 + self.frame.height*3/10))
        lockBody.addArc(withCenter: CGPoint(x: self.frame.width/2 + self.frame.width/5, y: self.frame.height/2 + self.frame.height*3/10),
                        radius: self.frame.width/20,
                        startAngle: CGFloat.pi*0,
                        endAngle: CGFloat.pi/2,
                        clockwise: true)
        lockBody.addLine(to: CGPoint(x: self.frame.width/2 - self.frame.width/5, y: self.frame.height/2 + self.frame.height*7/20))
        lockBody.addArc(withCenter: CGPoint(x: self.frame.width/2 - self.frame.width/5, y: self.frame.height/2 + self.frame.height*6/20),
                        radius: self.frame.width/20,
                        startAngle: CGFloat.pi/2,
                        endAngle: CGFloat.pi,
                        clockwise: true)
        lockBody.addLine(to: CGPoint(x: self.frame.width/4, y: self.frame.height/2))
        lockBody.addArc(withCenter: CGPoint(x: self.frame.width/2 - self.frame.width/5, y: self.frame.height/2),
                        radius: self.frame.width/20,
                        startAngle: CGFloat.pi,
                        endAngle: CGFloat.pi*3/2,
                        clockwise: true)
        
        
        UIColor.red.setFill()
        lockBody.fill()
        
        lockTop.move(to: CGPoint(x: self.frame.width/2 - self.frame.width/5, y: self.frame.height/2 - self.frame.height/20))
        lockTop.addLine(to: CGPoint(x: self.frame.width/2 - self.frame.width/5, y: self.frame.height/2 - self.frame.height*3/20))
        lockTop.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2 - self.frame.height*3/20),
                       radius: self.frame.width/5,
                       startAngle: CGFloat.pi,
                       endAngle: CGFloat.pi*0,
                       clockwise: true)
        lockTop.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/5, y: self.frame.height/2 - self.frame.height/20))
        lockTop.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/10, y: self.frame.height/2 - self.frame.height/20))
        lockTop.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/10, y: self.frame.height/2 - self.frame.height*3/20))
        lockTop.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2 - self.frame.height*3/20),
                       radius: self.frame.width/10,
                       startAngle: CGFloat.pi*2,
                       endAngle: CGFloat.pi,
                       clockwise: false)
        lockTop.addLine(to: CGPoint(x: self.frame.width/2 - self.frame.width/10, y: self.frame.height/2 - self.frame.height/20))
        lockTop.close()
        
        UIColor.red.setFill()
        lockTop.fill()
        
        forKeyTop.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2 + self.frame.height/10),
                         radius: self.frame.width/20,
                         startAngle: CGFloat.pi*0,
                         endAngle: CGFloat.pi*2,
                         clockwise: true)
        
        UIColor.white.setFill()
        forKeyTop.fill()
        
        forKeyBottom.move(to: CGPoint(x: self.frame.width/2 - self.frame.width/40, y: self.frame.height*7/10))
        forKeyBottom.addLine(to: CGPoint(x: self.frame.width/2 - self.frame.width/40, y: self.frame.height*6/10))
        forKeyBottom.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/40, y: self.frame.height*6/10))
        forKeyBottom.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/40, y: self.frame.height*7/10))
        forKeyBottom.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height*7/10),
                            radius: self.frame.width/40,
                            startAngle: CGFloat.pi*0,
                            endAngle: CGFloat.pi,
                            clockwise: true)
        UIColor.white.setFill()
        forKeyBottom.fill()
    }
    

}
