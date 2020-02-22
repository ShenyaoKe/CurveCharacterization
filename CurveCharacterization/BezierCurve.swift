//
//  BezierCurve.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Cocoa

class CubicBezierCurve: NSObject {
    init(point0: NSPoint, point1: NSPoint, point2: NSPoint, point3: NSPoint) {
        points[0] = point0
        points[1] = point1
        points[2] = point2
        points[3] = point3
    }
    
    func controlPointAt(index: CFIndex) -> NSPoint {
        assert(index >= 0 && index < 4)
        return points[index]
    }
    
    func eval(t: CGFloat) -> NSPoint {
        let p01 = points[0].lerp(point: points[1], t: t)
        let p12 = points[1].lerp(point: points[2], t: t)
        let p23 = points[2].lerp(point: points[3], t: t)
        
        let p012 = p01.lerp(point: p12, t: t)
        let p123 = p12.lerp(point: p23, t: t)
        
        return p012.lerp(point: p123, t: t)
    }
    
    var points = Array(repeating: NSMakePoint(0, 0), count: 4)
}
