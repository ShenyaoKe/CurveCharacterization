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
    
        // Draw background
        context?.setFillColor(gray: 0.4, alpha: 1.0)
        context?.fill(dirtyRect)
        
        drawCurve(context: context!, curve: &curveController!.curve)
        
        // Draw inflection points
        if (curveController!.inflectionPoints.count > 0) {
            context!.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
            context!.setFillColor(red: 1, green: 0, blue: 0, alpha: 1)
            for point in curveController!.inflectionPoints {
                context!.addEllipse(in: makeRect(center: point))
            }
            context!.drawPath(using: .fillStroke)
            
        }
        let attrs = [NSAttributedString.Key.font:NSFont.monospacedSystemFont(ofSize: 16, weight: NSFont.Weight.regular),
                     NSAttributedString.Key.foregroundColor: NSColor.orange,]
        let attributedString = NSAttributedString(string: curveController!.inflectionType, attributes: attrs)
        attributedString.draw(at: NSPoint(x: 4, y: 4))
    }
    
    func drawCurve(context: CGContext, curve: inout CubicBezierCurve) {
        // Draw curve
        context.move(to: curve.controlPointAt(index: 0))
        context.addCurve(to: curve.controlPointAt(index: 3),
                          control1: curve.controlPointAt(index: 1),
                          control2: curve.controlPointAt(index: 2))
        context.setStrokeColor(red: 1, green: 1, blue: 1, alpha: 1)
        context.drawPath(using: .stroke)
        
        // Draw control cage
        context.saveGState()
        context.setStrokeColor(red: 0, green: 0.8, blue: 0.4, alpha: 1.0)
        context.addLines(between: curve.points)
        context.setLineDash(phase: 0, lengths: [8, 8])
        context.drawPath(using: .stroke)
        context.restoreGState()
        
        // Draw control points
        context.setStrokeColor(red: 0.8, green: 0.6, blue: 0.1, alpha: 1)
        for i in 0..<4 {
            context.addRect(makeRect(center: curve.controlPointAt(index: i)))
        }
        context.drawPath(using: .stroke)

        // Draw point string
        let attrs = [NSAttributedString.Key.font:NSFont.monospacedSystemFont(ofSize: 13, weight: NSFont.Weight(rawValue: 0)),
                     NSAttributedString.Key.foregroundColor: NSColor.white,]
        for i in 0..<4 {

            let attributedString = NSAttributedString(string: String(format: "P%d", i),
                                                      attributes: attrs)
            attributedString.draw(at: curve.controlPointAt(index: i))
        }
    }

    override func mouseDown(with event: NSEvent) {
        let mousePoint = convert(event.locationInWindow, to: nil)
        var closestDist = CGFloat.greatestFiniteMagnitude
        for i in 0..<4 {
            let distSqr = curveController!.curve.controlPointAt(index: i).distanceSqrTo(point: mousePoint)
            if (distSqr < 16 && distSqr < closestDist) {
                closestDist = distSqr
                selectedPointIndex = i
            }
        }
    }

    override func mouseDragged(with event: NSEvent) {
        if (selectedPointIndex != kCFNotFound) {
            let mousePoint = convert(event.locationInWindow, to: nil)
            curveController!.setPointAt(index: selectedPointIndex, to: mousePoint)
            setNeedsDisplay(frame)
        }
    }

    override func mouseUp(with event: NSEvent) {
        selectedPointIndex = kCFNotFound
    }
    
    func makeRect(center: NSPoint) -> NSRect {
        let pointRadius = CGFloat(3)
        let pointDiameter = pointRadius * 2
        return NSMakeRect(center.x - pointRadius,
                          center.y - pointRadius,
                          pointDiameter,
                          pointDiameter)
    }
    
    @IBOutlet weak var curveController: CurveViewController?
    
    var selectedPointIndex = kCFNotFound
}
