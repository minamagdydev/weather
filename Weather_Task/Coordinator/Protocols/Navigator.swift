//
//  ListOfLocationsViewController.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation
import UIKit

enum NavigatorTypes {
    case present
    case push
}

protocol Navigator {
    associatedtype Destination
    func viewController(for destination: Destination) -> UIViewController
    init(coordinator: Coordinator)
    var coordinator: Coordinator { get }
    func navigate(to destination: Destination, with navigationType: NavigatorTypes, vc: (UIViewController) -> ())
}

extension Navigator {
    func navigate(to destination: Destination,
                  with navigationType: NavigatorTypes = .push, vc: (UIViewController) -> () = {_ in }) {
        let viewController = self.viewController(for: destination)
        vc(viewController)
        switch navigationType {
        case .present:
            coordinator.navigationController.present(viewController, animated: true, completion: nil)
        case .push:
            coordinator.navigationController.pushViewController(viewController, animated: true)
            
        }
    }
}
