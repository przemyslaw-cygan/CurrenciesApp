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

    let items: [AppTabBarController.Item] = [
        .init(
            with: {
                let button = UIButton()
                button.setBackgroundColor(color: Color.text(variant: .regular).uiColor(with: 0.1), forState: .selected)
                button.setImage(.init(systemName: "house"), for: .normal)
                return button
            }(),
            for: UINavigationController(rootViewController: {
                let viewController = UIViewController()
                viewController.title = "Dashboard"
                return viewController
            }())
        ),
        .init(
            with: {
                let button = UIButton()
                button.setBackgroundColor(color: Color.text(variant: .regular).uiColor(with: 0.1), forState: .selected)
                button.setImage(.init(systemName: "arrow.left.arrow.right"), for: .normal)
                return button
            }(),
            for: UINavigationController(rootViewController: {
                let viewController = UIViewController()
                viewController.title = "Convert"
                return viewController
            }())
        ),
        .init(
            with: {
                let button = UIButton()
                button.setBackgroundColor(color: Color.text(variant: .regular).uiColor(with: 0.1), forState: .selected)
                button.setImage(.init(systemName: "magnifyingglass"), for: .normal)
                return button
            }(),
            for: UINavigationController(rootViewController: {
                let viewController = UIViewController()
                viewController.title = "Search"
                return viewController
            }())
        )
    ]

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let appTabBarController = AppTabBarController()
        appTabBarController.items = items

        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appTabBarController
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
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)
    }

}
