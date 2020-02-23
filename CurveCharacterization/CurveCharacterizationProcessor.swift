//
//  CurveCharacterizationProcessor.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Foundation

enum CurveCharacterization {
    case arch
    case one_inflection
    case cusp
    case two_inflection
    case loop
}

class CurveCharacterizationProcessor {
    
    func process(curve: CubicBezierCurve) {
        bezierCurve = curve
        
        computeB3()
        
        characterization()
    
    }
    
    func computeB3() {
        let v01 = bezierCurve!.controlPointAt(index: 0).vectorTo(point: bezierCurve!.controlPointAt(index: 1))
        let v12 = bezierCurve!.controlPointAt(index: 1).vectorTo(point: bezierCurve!.controlPointAt(index: 2))
        let v23 = bezierCurve!.controlPointAt(index: 2).vectorTo(point: bezierCurve!.controlPointAt(index: 3))
        b3 = NSMakePoint(1 + v01.cross(vector: v23) / v01.cross(vector: v12),
                         1 + v23.cross(vector: v12) / v01.cross(vector: v12))
    }
    
    func characterization() {
        if (b3!.y > CGFloat(1)) {
            // One inflection point
            charaterization = CurveCharacterization.one_inflection
            let coefA = b3!.x + b3!.y - 3
            if (coefA.isFuzzyZero()) {
                t1 = 1 / (3 - b3!.x)
            } else {
                t1 = ((b3!.x - 3) + sqrt(b3!.x * b3!.x - b3!.x * 2 + b3!.y * 4 - 3)) / (coefA * 2)
            }
            assert(t1 <= 1 && t1 >= 0)
            t2 = CGFloat.nan
        } else if (b3!.x > CGFloat(1)) {
            charaterization = CurveCharacterization.arch
        } else {
            let coefA1 = b3!.x + b3!.y - 3
            let coefB1 = 3 - b3!.x
            //let coefC1 = -1
            let delta1 = b3!.x * b3!.x - b3!.x * 2 + b3!.y * 4 - 3
            if (delta1.isFuzzyZero()) {
                charaterization = CurveCharacterization.cusp
                t1 = -coefB1 / (2 * coefA1)
                t2 = t1
            } else if (delta1 > 0) {
                charaterization = CurveCharacterization.two_inflection
                let sqrtDelta1 = sqrt(delta1)
                let invTwoA = 0.5 / coefA1
                
                t1 = (-coefB1 + sqrtDelta1) * invTwoA
                t2 = (-coefB1 - sqrtDelta1) * invTwoA
                
            } else {
                // delta < 0
                // arch or self-loop
                t1 = CGFloat.nan
                t2 = CGFloat.nan
                
                // TODO: compute characterization for loop
                charaterization = CurveCharacterization.arch
                if (b3!.x <= 0) {
                    // check poloba
                    let val = (b3!.x - 3) * b3!.x + 3 * b3!.y
                    if (val.isFuzzyZero()) {
                        charaterization = CurveCharacterization.loop
                        loopT1 = 0
                        // TODO: Compute t2
                    } else if (val > 0) {

                        charaterization = CurveCharacterization.loop
                    } else {
                        // val < 0
                        charaterization = CurveCharacterization.arch
                    }
                } else {
                    // check ellipse
                    let val = b3!.x.sqr()+b3!.y.sqr() + b3!.x * b3!.y - 3 * b3!.x
                    if (val.isFuzzyZero()) {
                        charaterization = CurveCharacterization.loop
                        // TODO: Compute t1
                        loopT2 = 1
                    } else if (val > 0) {
                        charaterization = CurveCharacterization.loop
                    } else {
                        // val < 0
                        charaterization = CurveCharacterization.arch
                    }
                }
            }
        }
    }
    
    var t1 = CGFloat.nan
    var t2 = CGFloat.nan
    var loopT1 = CGFloat.nan
    var loopT2 = CGFloat.nan
    var charaterization = CurveCharacterization.arch
    
    var b3: NSPoint?
    weak var bezierCurve: CubicBezierCurve?
}
