//
//  AppDelegate.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initServices()
        return true
    }

    private func initServices() {
        let apiService = APIService()
        
        ServiceLocator.shared.addService(service: apiService)
    }


}

