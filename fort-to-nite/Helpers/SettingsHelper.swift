//
//  SettingsHelper.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 17.09.19.
//  Copyright © 2019 Romain Sickenberg. All rights reserved.
//

import Foundation

class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let BuildVersionKey = "build_setting"
        static let AppVersionKey = "version_setting"
    }

    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        UserDefaults.standard.set(version, forKey: SettingsBundleKeys.AppVersionKey)

        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
        UserDefaults.standard.set(build, forKey: SettingsBundleKeys.BuildVersionKey)
    }
}
