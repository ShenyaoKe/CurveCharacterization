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
                                               name: .didChangeCurve,
                                               object: nil)
    }
    
    @objc func onCurveChanged(_ notification: Notification) {
        // process
        charaterizationProcessor.process(curve: (notification.userInfo!["Curve"] as! CubicBezierCurve))
        
        NotificationCenter.default.post(name: .didComputeCurveCharacterization,
                                        object: self,
                                        userInfo: ["Type": charaterizationProcessor.charaterization as Any,
                                                   "T1": charaterizationProcessor.t1 as Any,
                                                   "T2": charaterizationProcessor.t2 as Any])
        view.setNeedsDisplay(view.frame)
    }
    
    func rectAt(point: NSPoint) -> NSRect {
        return NSMakeRect(point.x - CharacterizationViewController.pointRadius,
                          point.y - CharacterizationViewController.pointRadius,
                          CharacterizationViewController.pointRadius * 2,
                          CharacterizationViewController.pointRadius * 2)
    }
    
    func b3() -> NSPoint {
        return charaterizationProcessor.b3!
    }
    
    static let pointRadius = CGFloat(3)
    var charaterizationProcessor = CurveCharacterizationProcessor()
}
