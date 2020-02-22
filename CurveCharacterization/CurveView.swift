//
//  CurveView.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Cocoa

class CurveView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = NSGraphicsContext.current?.cgContext
    
        context?.setFillColor(gray: 0.4, alpha: 1.0)
        context?.fill(dirtyRect)
        
        // Draw curve
        context?.move(to: curve.controlPointAt(index: 0))
        context?.addCurve(to: curve.controlPointAt(index: 3),
                          control1: curve.controlPointAt(index: 1),
                          control2: curve.controlPointAt(index: 2))
        context?.setStrokeColor(red: 1, green: 1, blue: 1, alpha: 1)
        context?.drawPath(using: .stroke)
        
        // Draw control cage
        context?.setStrokeColor(red: 0, green: 0.8, blue: 0.4, alpha: 1.0)
        context?.addLines(between: curve.points)
        context?.setLineDash(phase: 0, lengths: [8, 8])
        context?.drawPath(using: .stroke)
        
        // Draw control points
        context?.setStrokeColor(red: 0.8, green: 0.6, blue: 0.1, alpha: 1)
        for i in 0..<4
        {
            let pointCenter = curve.controlPointAt(index: i)
            let pointRadius = CGFloat(3)
            let pointDiameter = pointRadius * 2
            context?.addRect(NSMakeRect(pointCenter.x - pointRadius,
                                        pointCenter.y - pointRadius,
                                        pointDiameter,
                                        pointDiameter))
        }
        context?.drawPath(using: .fillStroke)
    }
    
    override func mouseDown(with event: NSEvent) {
        let mousePoint = convert(event.locationInWindow, to: nil)
        var closestDist = CGFloat.greatestFiniteMagnitude
        for i in 0..<4 {
            let distSqr = curve.controlPointAt(index: i).distanceSqrTo(point: mousePoint)
            if (distSqr < 16 && distSqr < closestDist) {
                closestDist = distSqr
                selectedPointIndex = i
            }
        }
    }
    override func mouseDragged(with event: NSEvent) {
        if (selectedPointIndex != kCFNotFound) {
            let mousePoint = convert(event.locationInWindow, to: nil)
            curve.points[selectedPointIndex] = mousePoint
            setNeedsDisplay(frame)
        }
    }
    override func mouseUp(with event: NSEvent) {
        selectedPointIndex = kCFNotFound
    }
    
    var curve = CubicBezierCurve(point0: NSMakePoint(100, 100),
                                 point1: NSMakePoint(150, 400),
                                 point2: NSMakePoint(540, 380),
                                 point3: NSMakePoint(450, 180))
    
    var selectedPointIndex = kCFNotFound
}
