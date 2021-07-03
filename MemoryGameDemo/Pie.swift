//
//  Pie.swift
//  MemoryGameDemo
//
//  Created by 兔子 on 2021/6/30.
//  countdown pie custom shape

import SwiftUI
struct Pie: Shape{// All shapes are assumed doing animation
    // 倒數圓角
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool = true
    var animatableData: AnimatablePair<Double,Double>{// Double: Two angles
        get{
            AnimatablePair(startAngle.radians,endAngle.radians)
        }
        set{
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width,rect.height)/2
        
        // 倒數圓角開始的線 對應p.addLine(to: start)
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
       
        // 圓周
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        
        p.addLine(to: center)
        
        return p
    }

}
