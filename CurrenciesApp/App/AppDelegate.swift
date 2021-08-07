//
//  AppDelegate.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 03/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let tabNavigationViewModel = DefaultTabNavigationViewModel(with: [])
        let tabNavigationViewController = TabNavigationViewController(with: tabNavigationViewModel)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabNavigationViewController
        window?.makeKeyAndVisible()
        setupAppearance()

        return true
    }

    func setupAppearance() {
        UIButton.appearance().tintColor = Color.text(variant: .regular).uiColor()
        UIButton.appearance().adjustsImageWhenHighlighted = false
        UIButton.appearance().adjustsImageWhenDisabled = false
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = Color.background(variant: .regular).uiColor()
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = Color.text(variant: .regular).uiColor()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Color.text(variant: .regular).uiColor()]
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.left")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
    }

}
