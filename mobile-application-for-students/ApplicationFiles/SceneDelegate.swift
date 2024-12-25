//
//  SceneDelegate.swift
//  mobile-application-for-students
//
//  Created by Егорио on 18.12.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        // Подписка на изменения авторизации
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, _ in
            self?.checkAuthentification()
        }
        
        // Установка начального экрана
        checkAuthentification()
        window?.makeKeyAndVisible()
    }

    deinit {
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    /// Проверяет состояние авторизации и переключает rootViewController
    public func checkAuthentification() {
        let rootVC: UIViewController = Auth.auth().currentUser == nil
            ? GreetingsScreenVC()
            : createTabBarController()
        
        // Смена rootViewController только если он отличается
        if !(window?.rootViewController is UINavigationController &&
             (window?.rootViewController as? UINavigationController)?.viewControllers.first === rootVC) {
            goToController(with: rootVC)
        }
    }

    /// Анимация смены контроллера
    private func goToController(with viewController: UIViewController) {
        guard let window = self.window else { return }
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: {
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
        })
    }

    /// Создание TabBarController
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = createTabBarItems()
        configureTabBarAppearance(tabBarController)
        tabBarController.selectedIndex = 0
        return tabBarController
    }

    /// Конфигурация внешнего вида TabBar
    private func configureTabBarAppearance(_ tabBarController: UITabBarController) {
        tabBarController.tabBar.tintColor = Styles.Colors.appBlackColor
        tabBarController.tabBar.unselectedItemTintColor = Styles.Colors.appSecondaryColor
    }

    /// Создаёт элементы для TabBar
    private func createTabBarItems() -> [UINavigationController] {
        return [
            UINavigationController(rootViewController: NewsScreenVC()).applyTabBarItem(title: nil, image: "newspaper", selectedImage: "newspaper.fill"),
            UINavigationController(rootViewController: ProfileScreenVC()).applyTabBarItem(title: nil, image: "person", selectedImage: "person.fill"),
            UINavigationController(rootViewController: ChatScreenVC()).applyTabBarItem(title: nil, image: "message", selectedImage: "message.fill"),
            UINavigationController(rootViewController: SettingsScreenVC()).applyTabBarItem(title: nil, image: "gearshape", selectedImage: "gearshape.fill")
        ]
    }
}

extension UINavigationController {
    /// Применяет TabBarItem к UINavigationController
    func applyTabBarItem(title: String?, image: String, selectedImage: String) -> UINavigationController {
        tabBarItem = UITabBarItem(title: title,
                                  image: UIImage(systemName: image),
                                  selectedImage: UIImage(systemName: selectedImage))
        return self
    }
}



