//
//  CharacterizationViewController.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Cocoa

class CharacterizationViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onCurveChanged),
                                               name: .didChangeCurve, object: nil)
    }
    
    @objc func onCurveChanged(_ notification: Notification) {
        // process
        curve = (notification.userInfo?["Curve"] as! CubicBezierCurve)
        
        
        view.setNeedsDisplay(view.frame)
    }
    
    func rectAt(index: CFIndex) -> NSRect {
        return rectAt(point: (curve?.controlPointAt(index: index))!)
    }
    
    func rectAt(point: NSPoint) -> NSRect {
        return NSMakeRect(point.x - CharacterizationViewController.pointRadius,
                          point.y - CharacterizationViewController.pointRadius,
                          CharacterizationViewController.pointRadius * 2,
                          CharacterizationViewController.pointRadius * 2)
    }
    
    func b3() -> NSPoint {
        let v01 = curve!.controlPointAt(index: 0).vectorTo(point: curve!.controlPointAt(index: 1))
        let v12 = curve!.controlPointAt(index: 1).vectorTo(point: curve!.controlPointAt(index: 2))
        let v23 = curve!.controlPointAt(index: 2).vectorTo(point: curve!.controlPointAt(index: 3))
        return NSMakePoint(1 + v01.cross(vector: v23) / v01.cross(vector: v12),
                           1 + v23.cross(vector: v12) / v01.cross(vector: v12))
    }
    
    static let pointRadius = CGFloat(3)
    weak var curve: CubicBezierCurve?
    var charaterizationProcessor: CharacterizationViewController?
}
