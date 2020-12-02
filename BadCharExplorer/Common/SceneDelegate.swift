//
//  SceneDelegate.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 29/11/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootFlow: RootFlow!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        rootFlow = RootFlow(navigationController: UINavigationController(), environment: .dev)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootFlow.navigationController
        window?.makeKeyAndVisible()
        
        rootFlow.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

