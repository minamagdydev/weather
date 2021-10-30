//
//  ListOfLocationsViewController.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainNavigator: Navigator {
    var coordinator: Coordinator
    
    enum Destination {
        case home
        case listOfLocations(weatherDataBehavior: BehaviorRelay<[CountryWeatherModel]>)
        case searchViewController
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .home:
            let viewModel = HomeViewModel()
            let view = HomeViewController(viewModel: viewModel, coordinator: coordinator)
            return view
        case .listOfLocations(let weatherDataBehavior):
            let viewModel = ListOfLocationsViewModel(weatherDataBehavior: weatherDataBehavior)
            let view = ListOfLocationsViewController(viewModel: viewModel, coordinator: coordinator)
            return view
        case .searchViewController:
            let viewModel = SearchViewModel()
            let view = SearchViewController(viewModel: viewModel, coordinator: coordinator)
            return view
        }
    }
}
