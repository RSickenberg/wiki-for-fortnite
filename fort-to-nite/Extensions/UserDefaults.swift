//
//  UserDefaults.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 29.05.19.
//  Copyright © 2019 Romain Sickenberg. All rights reserved.
//

import Foundation

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag$
    // https://stackoverflow.com/questions/27208103/detect-first-launch-of-ios-app
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
    static func lastUpdate() -> Bool {
        let lastVersion = "1.1.2"
        let actualVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let isANewVersion = !UserDefaults.standard.bool(forKey: lastVersion)
        
        if (isANewVersion && lastVersion != actualVersion) {
            UserDefaults.standard.set(true, forKey: lastVersion)
        }
        
        return isANewVersion
    }
}
