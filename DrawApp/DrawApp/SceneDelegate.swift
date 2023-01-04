//
//  SceneDelegate.swift
//  DrawApp
//
//  Created by Дмитрий Осипенко on 4.01.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let draw = DrawViewController()
        let navigationController = UINavigationController(rootViewController: draw)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

