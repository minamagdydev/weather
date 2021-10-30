//
//  HomeViewModel.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 10/31/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation
import Reachability

protocol HomeViewModelOutput {
    var weatherDataBehavior: BehaviorRelay<[CountryWeatherModel]> { get set }
    func getInitialData()
}

protocol HomeViewModelInput {
    func fetchCurrentLocationData(defaultCountry: Bool, finished: @escaping () -> ())
    func didSelectItemAtIndexPath(_ indexPath: IndexPath)
}

class HomeViewModel: BaseViewModel, HomeViewModelOutput {
    
    var weatherDataBehavior: BehaviorRelay<[CountryWeatherModel]> = .init(value: [])
    var reachability = Reachability()
    let locationManager = LocationManager()
    var coordinate: CLLocationCoordinate2D?
    let disposeBag = DisposeBag()
    let networkClient: NetworkManager
    var checkConection: BehaviorRelay<Bool> = .init(value: true)
    
    init(networkClient: NetworkManager = NetworkManager()) {
        self.networkClient = networkClient
    }
    var weatherData: Observable<[CountryWeatherModel]> {
        return weatherDataBehavior.asObservable()
    }
    
    func checkHandleConnectionFail() {
        if reachability?.connection == Reachability.Connection.none {
            checkConection.accept(false)
            self.weatherDataBehavior.accept(returnData())
        }
    }
    
    func saveDataLocally(model: [CountryWeatherModel] = []) {
        let _ = CachingManager.shared.cache(model, with: CachKeys.countryWeather)
    }
    
    func returnData() -> [CountryWeatherModel] {
        let model: [CountryWeatherModel] = CachingManager.shared.getCached(value: CachKeys.countryWeather) ?? []
        return model
    }
    
    func getInitialData() {
        locationManager.request {
            if let location = $0 {
                self.coordinate = location.coordinate
                self.fetchCurrentLocationData(defaultCountry: false)
            } else {
                self.fetchCurrentLocationData(defaultCountry: true)
            }
        }
    }
    
    func formmatingDate() -> String {
        let date = Date()
        return CODateFormatter.onlyWeekdayDateFormatter.string(from: date)
    }
    
    func fetchCurrentLocationData(defaultCountry: Bool, finished: @escaping () -> () = {}) {
        isLoading.onNext(true)
        let endPoint:APIService = (defaultCountry == true ? .getWeatherByCountaryName : .getWeather(lat: (self.coordinate?.latitude ?? 0.0), long: (self.coordinate?.longitude ?? 0.0)) )
        self.networkClient.requestData(endPoint: endPoint, decodingType: CountryWeatherModel.self, completionHandler: { [weak self] result in
            switch result {
            case .success(let model):
                self?.weatherDataBehavior.acceptAppending(model)
                self?.saveDataLocally(model: self?.weatherDataBehavior.value ?? [])
                self?.isLoading.onNext(false)
                finished()
            case .failure( _):
                self?.isLoading.onNext(false)
            }
        })
    }
    
    func addCountryWeather(model: [CountryWeatherModel]) {
        self.weatherDataBehavior.accept(model)
    } 
    
}
