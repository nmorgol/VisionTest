//
//  EyeView.swift
//  VisionTest
//
//  Created by kolya on 2/6/20.
//  Copyright © 2020 kolya. All rights reserved.
//

import UIKit

class EyeView: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        let outEye = UIBezierPath()
        let khrust = UIBezierPath()
        
        outEye.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                      radius: self.frame.width/4,
                      startAngle: CGFloat(Float.pi*5/6),
                      endAngle: CGFloat.pi*7/6,
                      clockwise: false)
        
        outEye.addArc(withCenter: CGPoint(x: self.frame.width/2 - (self.frame.width/4)/CGFloat((sqrtf(3))) , y: self.frame.height/2),
                      radius: (self.frame.width/4)/CGFloat((sqrtf(3))),
                      startAngle: CGFloat.pi*4/3,
                      endAngle: CGFloat.pi*2/3,
                      clockwise: false)
        
        
        //outEye.stroke()
        
        outEye.lineWidth = 2
        UIColor.darkGray.setStroke()
        outEye.stroke()
        
        khrust.addArc(withCenter: CGPoint(x: self.frame.width/2 + self.frame.width/20, y: self.frame.height/2),
        radius: self.frame.width/4,
        startAngle: CGFloat(Float.pi*5/6),
        endAngle: CGFloat.pi*7/6,
        clockwise: true)
        
        
        khrust.addArc(withCenter: CGPoint(x: self.frame.width*2.5/20, y: self.frame.height/2),
        radius: self.frame.width/4,
        startAngle: CGFloat(Float.pi*11/6),
        endAngle: CGFloat.pi/6,
        clockwise: true)
        
        khrust.close()
        
        khrust.lineWidth = 2
        UIColor.lightGray.setStroke()
        khrust.stroke()
        
    }
    


}
