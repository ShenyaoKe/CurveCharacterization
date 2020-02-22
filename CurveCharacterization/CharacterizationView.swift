//
//  CharacterizationView.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Cocoa

class CharacterizationView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = NSGraphicsContext.current?.cgContext
        
        context?.move(to: NSMakePoint(0, 0.5 * frame.height))
        context?.addLine(to: NSMakePoint(frame.width, 0.5 * frame.height))
        context?.drawPath(using: .stroke)
        
        context?.move(to: NSMakePoint(0.5 * frame.width, 0))
        context?.addLine(to: NSMakePoint(0.5 * frame.width, frame.height))
        context?.drawPath(using: .stroke)
        
        context?.setStrokeColor(red: 0.8, green: 0.2, blue: 0.5, alpha: 1.0)
        
        context?.addEllipse(in: characterizationController!.rectAt(point: convertToViewSpace(point: NSMakePoint(0, 0))))
        context?.addEllipse(in: characterizationController!.rectAt(point: convertToViewSpace(point: NSMakePoint(0, 1))))
        context?.addEllipse(in: characterizationController!.rectAt(point: convertToViewSpace(point: NSMakePoint(1, 1))))
        context?.addEllipse(in: characterizationController!.rectAt(point: convertToViewSpace(point: characterizationController!.b3())))
        context?.drawPath(using: .stroke)
    }
    
    func convertToViewSpace(point: NSPoint) -> NSPoint {
        return NSMakePoint(point.x * CharacterizationView.grid_size + frame.width * 0.5,
                           point.y * CharacterizationView.grid_size + frame.height * 0.5)
    }
    
    static let grid_size = CGFloat(100)
    
    @IBOutlet weak var characterizationController: CharacterizationViewController?
}
