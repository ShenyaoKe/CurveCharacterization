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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onCharacterizationComputed),
                                               name: .didComputeCurveCharacterization,
                                               object: nil)
        
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
    
    @objc func onCharacterizationComputed(_ notification: Notification) {
        // process
        let type = notification.userInfo!["Type"] as! CurveCharacterization
        let t1 = notification.userInfo!["T1"] as! CGFloat
        let t2 = notification.userInfo!["T2"] as! CGFloat
        
        inflectionPoints.removeAll()
        switch type {
        case CurveCharacterization.arch:
            inflectionType = "Arch"
        case CurveCharacterization.one_inflection:
            assert(t1 <= 1 && t1 >= 0)
            inflectionPoints.append(curve.eval(t: t1))
            inflectionType = "One Inflection"
        case CurveCharacterization.cusp:
            assert(t1 <= 1 && t1 >= 0)
            inflectionPoints.append(curve.eval(t: t1))
            inflectionType = "Cusp"
        case CurveCharacterization.two_inflection:
            assert(t1 <= 1 && t1 >= 0)
            
            assert(t2 <= 1 && t2 >= 0)
            inflectionPoints.append(curve.eval(t: t1))
            inflectionPoints.append(curve.eval(t: t2))
            inflectionType = "Two Inflection"
        case CurveCharacterization.loop:
            inflectionType = "Loop"
        default:
            inflectionType = ""
        }
        view.setNeedsDisplay(view.frame)
    }
    

    var curve = CubicBezierCurve(point0: NSMakePoint(100, 100),
                                 point1: NSMakePoint(150, 400),
                                 point2: NSMakePoint(540, 380),
                                 point3: NSMakePoint(450, 180))
    var inflectionPoints = Array<NSPoint>()
    var inflectionType = String()
}

