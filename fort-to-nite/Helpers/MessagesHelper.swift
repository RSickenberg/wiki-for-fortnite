//
//  MessagesHelper.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 5.08.19.
//  Copyright © 2019 Romain Sickenberg. All rights reserved.
//

import Foundation
import SwiftMessages

class AlertsManager {
    enum AlertStyle {
        case success
        case warning
        case error
        case info
        
        var iconText: String {
            switch self {
            case .success: return "✔"
            case .warning: return "⚠️"
            case .error: return "🚫"
            case .info: return "ℹ️"
            }
        }
        
        var theme: Theme {
            switch self {
            case .success: return .success
            case .warning: return .warning
            case .error: return .error
            case .info: return .info
            }
        }
    }
    
    var isPresented = false
    
    func show(title: String?, message: String, style: AlertStyle = .warning, duration: SwiftMessages.Duration = .forever, buttonTitle: String? = nil, interactiveHide: Bool = false, buttonTapHandler: (() -> Void)? = nil) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(style.theme)
        view.configureDropShadow()
        view.button?.setTitle(buttonTitle, for: .normal)
        if buttonTitle == nil {
            view.button?.isHidden = true
        }
        view.configureContent(title: title ?? "", body: message, iconText: style.iconText)
        view.buttonTapHandler = { _ in
            SwiftMessages.hide()
            buttonTapHandler?()
        }
        
        var config = SwiftMessages.defaultConfig
        config.duration = duration
        config.interactiveHide = interactiveHide
        config.dimMode = .none
        config.presentationContext = .window(windowLevel: UIWindow.Level.alert)
        
        config.eventListeners.append() { event in
            if case .didShow = event { self.isPresented = true }
            if case .didHide = event { self.isPresented = false }
        }
        
        SwiftMessages.show(config: config, view: view)
    }

}
