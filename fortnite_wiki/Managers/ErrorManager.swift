//
//  ErrorManager.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 04.05.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit
import PKHUD

struct ErrorManager {
    static func showError(_ title: String, error: Error) {
        if HUD.isVisible {
            HUD.hide()
        }
        
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: UIAlertActionStyle.default, handler: nil))
        
        var viewController = UIApplication.shared.keyWindow?.rootViewController
        
        // Ensure we present 'alert' on top of current view controller
        // http://pinkstone.co.uk/how-to-avoid-whose-view-is-not-in-the-window-hierarchy-error-when-presenting-a-uiviewcontroller/
        while ((viewController!.presentedViewController) != nil) {
            viewController = viewController!.presentedViewController;
        }
        
        viewController!.present(alert, animated: true, completion: nil)
    }
    
    static func showMessage(_ title: String, message: String) {
        if HUD.isVisible {
            HUD.hide()
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: UIAlertActionStyle.default, handler: nil))
        
        var viewController = UIApplication.shared.keyWindow?.rootViewController
        
        // Ensure we present 'alert' on top of current view controller
        // http://pinkstone.co.uk/how-to-avoid-whose-view-is-not-in-the-window-hierarchy-error-when-presenting-a-uiviewcontroller/
        while ((viewController!.presentedViewController) != nil) {
            viewController = viewController!.presentedViewController;
        }
        
        viewController!.present(alert, animated: true, completion: nil)
    }
    
}
