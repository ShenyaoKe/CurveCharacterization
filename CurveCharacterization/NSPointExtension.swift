//
//  NSPointExtension.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Cocoa

extension NSPoint {
    func vectorTo(point: NSPoint) -> NSPoint {
        return NSMakePoint(point.x - x, point.y - y)
    }
    func lengthSqr() -> CGFloat {
        return x * x + y * y
    }
    func length() -> CGFloat {
        return sqrt(lengthSqr())
    }
    func distanceSqrTo(point: NSPoint) -> CGFloat {
        return (x - point.x) * (x - point.x) + (y - point.y) * (y - point.y)
    }
    func distanceTo(point: NSPoint) -> CGFloat {
        return sqrt(distanceSqrTo(point: point))
    }
    func dot(vector: NSPoint) -> CGFloat {
        return x * vector.x + y * vector.y
    }
    func cross(vector: NSPoint) -> CGFloat {
        return x * vector.y - y * vector.x
    }
    func lerp(point: NSPoint, t: CGFloat) -> NSPoint {
        return NSMakePoint((1-t) * x + t * point.x, (1-t) * y + t * point.y)
    }
}
