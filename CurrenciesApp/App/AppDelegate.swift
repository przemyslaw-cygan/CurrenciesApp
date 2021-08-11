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
        let viewControllers = ["List A", "List B", "List C"].map { Self.mockListViewController(with: $0) }
        let tabNavigationViewModel = DefaultTabNavigationViewModel(with: viewControllers)
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

private extension AppDelegate {
    static func mockListViewController(with title: String) -> ListViewController {
        let viewController = ListViewController(with: MockListViewModel())
        viewController.title = title
        return viewController
    }
}
