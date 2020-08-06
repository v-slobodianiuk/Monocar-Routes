//
//  AppDelegate.swift
//  Monocar Routes
//
//  Created by Vadym on 05.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import UIKit
import GoogleMaps

let googleApiKey = "AIzaSyCorjihLoh0-zZNj5UBqjdRrzPHddGBrLw"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupRootVC()
        navBar()
        
        /// Google Maps
        GMSServices.provideAPIKey(googleApiKey)
        
        return true
    }
    
    func setupRootVC() {
        
        let initialVC = MapViewController()
        let networkWorker = NetworkWorker()
        let passangerModel = Passanger(dictionary: nil)
        let driversModel = Drivers(dictionary: nil)
        let mapPresenter = MapPresenter(viewController: initialVC, networkWorker: networkWorker, passangerModel: passangerModel, driversModel: driversModel)
        initialVC.presenter = mapPresenter
        let rootNavController = UINavigationController(rootViewController: initialVC)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootNavController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func navBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .white
            UINavigationBar.appearance().isTranslucent = false
        }
    }
}

