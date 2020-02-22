//
//  CurveCharacterizationProcessor.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Foundation

class CurveCharacterizationProcessor: NSObject {
    
    override init() {
        super.init()
    }
    
    init(inCurve: inout CubicBezierCurve) {
        curve = inCurve
    }
    
    weak var curve: CubicBezierCurve?
}
