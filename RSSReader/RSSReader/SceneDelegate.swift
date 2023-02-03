//
//  SceneDelegate.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rssService = RSSService()
        let storageService = StorageService()
        let appManager = ApplicationManager(rssService: rssService, storageService: storageService)
        let startScreen = NewsListViewController(manager: appManager)
        let navigationVC = UINavigationController(rootViewController: startScreen)
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
        self.window = window
    }
}

