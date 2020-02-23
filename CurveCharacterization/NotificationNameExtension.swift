//
//  NotificationNameExtension.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didChangeCurve = Notification.Name("didChangeCurve")
    static let didComputeCurveCharacterization = Notification.Name("didComputeCurveCharacterization")
}
