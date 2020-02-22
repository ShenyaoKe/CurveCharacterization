//
//  SplitViewController.swift
//  CurveCharacterization
//
//  Created by Shenyao Ke on 2/22/20.
//  Copyright © 2020 Shenyao Ke. All rights reserved.
//

import Cocoa

@IBDesignable class SplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        curveViewController = (splitViewItems[0].viewController as! CurveViewController)
        
        characterizationController = (splitViewItems[1].viewController as! CharacterizationViewController)
        
        
        NotificationCenter.default.post(name: .didChangeCurve,
                                        object: curveViewController,
                                        userInfo: ["Curve": curveViewController?.curve as Any])
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    //@IBInspectable var testVar = 1
    @IBOutlet weak var curveViewController: CurveViewController?
    @IBOutlet weak var characterizationController: CharacterizationViewController?
}
