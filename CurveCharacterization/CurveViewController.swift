//
//  ViewController.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Cocoa

class CurveViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //(view as! CurveView).curveController = self
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.post(name: .didChangeCurve,
                                        object: self,
                                        userInfo: ["Curve": curve as Any])
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setPointAt(index: CFIndex, to: NSPoint) {
        curve.points[index] = to
        
        NotificationCenter.default.post(name: .didChangeCurve,
                                        object: self,
                                        userInfo: ["Curve": curve as Any])
    }

    var curve = CubicBezierCurve(point0: NSMakePoint(100, 100),
                                 point1: NSMakePoint(150, 400),
                                 point2: NSMakePoint(540, 380),
                                 point3: NSMakePoint(450, 180))
}

