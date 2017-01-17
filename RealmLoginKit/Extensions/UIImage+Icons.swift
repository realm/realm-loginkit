//
//  LoginIcons.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 1/17/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit

extension UIImage {
    public class func mailIcon() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 15), false, 0.0)
        
        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 1, y: 1, width: 18, height: 13), cornerRadius: 2)
        color.setStroke()
        rectanglePath.lineWidth = 2
        rectanglePath.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 2, y: 2))
        bezierPath.addLine(to: CGPoint(x: 10, y: 9))
        bezierPath.addLine(to: CGPoint(x: 18, y: 2))
        color.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!.withRenderingMode(.alwaysTemplate)
    }
    
    public class func lockIcon() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 20), false, 0.0)
        
        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 3, y: 9, width: 14, height: 10), cornerRadius: 2)
        UIColor.black.setStroke()
        rectanglePath.lineWidth = 2
        rectanglePath.stroke()
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath()
        ovalPath.move(to: CGPoint(x: 5, y: 9))
        ovalPath.addCurve(to: CGPoint(x: 5, y: 5.29), controlPoint1: CGPoint(x: 5, y: 9), controlPoint2: CGPoint(x: 5, y: 7.65))
        ovalPath.addCurve(to: CGPoint(x: 10, y: 1), controlPoint1: CGPoint(x: 5, y: 2.92), controlPoint2: CGPoint(x: 7.24, y: 1))
        ovalPath.addCurve(to: CGPoint(x: 15, y: 5.29), controlPoint1: CGPoint(x: 12.76, y: 1), controlPoint2: CGPoint(x: 15, y: 2.92))
        ovalPath.addCurve(to: CGPoint(x: 15, y: 9), controlPoint1: CGPoint(x: 15, y: 7.65), controlPoint2: CGPoint(x: 15, y: 9))
        color.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.lineJoinStyle = .round
        ovalPath.stroke()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!.withRenderingMode(.alwaysTemplate)
    }
}
