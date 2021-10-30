//
//  ListOfLocationsViewController.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var Main: MainNavigator { get }
    var navigationController: UINavigationController { get }
    func dismiss()
    func pop()
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    var navigationController: UINavigationController
    
    lazy var Main: MainNavigator = {
        return .init(coordinator: self)
    }()
    
    private lazy var main: UIViewController = {
        let homeViewModel = HomeViewModel()
        return HomeViewController(viewModel: homeViewModel, coordinator: self)
    }()
    
    
    init(window: UIWindow = UIWindow(), navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
       }
    
    func pop() {
        self.navigationController.popViewController(animated: true)
          self.navigationController.dismiss(animated: true, completion: nil)
         }
    
    func start(){
        navigationController = UINavigationController(rootViewController: main)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
