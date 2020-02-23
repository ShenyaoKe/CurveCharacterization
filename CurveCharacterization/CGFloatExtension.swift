//
//  CGFloatExtension.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/23/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Foundation

extension CGFloat {
    
    func isFuzzyZero() -> Bool {
        return self > -CGFloat.ulpOfOne && self < CGFloat.ulpOfOne
    }
    
    func isFuzzyEqual(other: CGFloat) -> Bool {
        let dist = self - other
        return dist.isFuzzyZero()
    }
    
    func sqr() -> CGFloat {
        return self * self
    }
    
}
