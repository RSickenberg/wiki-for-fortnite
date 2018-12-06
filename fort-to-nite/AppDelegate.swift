//
//  AppDelegate.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

//import Fabric
import UIKit
import Crashlytics
import StatusAlert
import Siren

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    enum ShortCut: String {
        case favortites = "favorite"
        case market = "market"
    }

    var window: UIWindow?
    var settings: UserDefaults?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let siren = Siren.shared
        
        siren.alertMessaging = SirenAlertMessaging(updateButtonMessage: NSAttributedString(string: "Update"),
                                                   nextTimeButtonMessage: NSAttributedString(string: "Next Time"),
                                                   skipVersionButtonMessage: NSAttributedString(string: "Skip this version"))
        
        siren.alertType = .option
        siren.majorUpdateAlertType = .force
        siren.minorUpdateAlertType = .option
        siren.patchUpdateAlertType = .skip
        siren.revisionUpdateAlertType = .skip
        
        UIApplication.shared.statusBarStyle = .lightContent
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print("Version : " + text)
        }
        if let text = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            print("Build : " + text)
        }
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font : UIFont(name: "BurbankBigCondensed-bold", size: 19)!,
                NSAttributedString.Key.foregroundColor : UIColor.white,
            ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font : UIFont(name: "BurbankBigCondensed-bold", size: 17)!,
                NSAttributedString.Key.foregroundColor : UIColor.white,
            ], for: .highlighted)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "BurbankBigCondensed-bold", size: 13)!], for: .normal)
        UITableView.appearance().separatorColor = UIColor.black
        
        siren.checkVersion(checkType: .weekly)
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleQuickAction(shortCutItem: shortcutItem))
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        Siren.shared.checkVersion(checkType: .immediately)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
    private func handleQuickAction(shortCutItem: UIApplicationShortcutItem) -> Bool {
        guard let tabBar = self.window?.rootViewController as? UITabBarController else { return false }
        tabBar.selectedIndex = 0
        WeaponViewController().getData()
        
        var quickActionHandled = false
        let type = shortCutItem.type.components(separatedBy: ".").last!
        if let shortCutType = ShortCut.init(rawValue: type) {
            switch shortCutType {
            case .favortites:
                tabBar.selectedIndex = 2
                guard let nvc = tabBar.viewControllers?.last as? UINavigationController else { return false }
                guard let vc = nvc.viewControllers.first as? FavoritesTableViewController else { return false }
                nvc.popToRootViewController(animated: true)
                vc.getFavorites()
                vc.reloadTable()
                quickActionHandled = true
                break
            case .market:
                tabBar.selectedIndex = 3
                guard let nvc = tabBar.viewControllers?.last as? UINavigationController else { return false }
                guard let vc = nvc.viewControllers.first as? StoreViewController else { return false }
                nvc.popToRootViewController(animated: true)
                vc.getData()
                quickActionHandled = true
                break
            }
        }
        return quickActionHandled
    }
}

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
        let lastVersion = "1.0.9"
        let actualVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let isANewVersion = !UserDefaults.standard.bool(forKey: lastVersion)
        
        if (isANewVersion && lastVersion != actualVersion) {
            UserDefaults.standard.set(true, forKey: lastVersion)
        }
        
        return isANewVersion
    }
}
