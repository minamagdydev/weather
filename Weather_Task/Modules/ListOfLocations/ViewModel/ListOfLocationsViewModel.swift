//
//  ListOfLocationsViewModel.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Reachability

protocol AllLocationsTableViewControllerDelegate {
    func didChooseLocation(atIndex: Int, shouldRefresh: Bool)
}

class ListOfLocationsViewModel: BaseViewModel {
    
    var reachability = Reachability()
    var weatherDataBehavior: BehaviorRelay<[CountryWeatherModel]> = .init(value: [])
    let disposeBag = DisposeBag()
    var deactivateBtn: PublishSubject<Bool> = .init()
    var checkConection: BehaviorRelay<Bool> = .init(value: true)
    var indexSelected = 0
    var weatherobservableCount: Observable<Bool> {
        return weatherDataBehavior.asObservable().map { $0.count == 5}
    }
    
    init (weatherDataBehavior: BehaviorRelay<[CountryWeatherModel]>) {
        self.weatherDataBehavior = weatherDataBehavior
        
    }
    
    func checkHandleConnectionFail() {
        if reachability?.connection == Reachability.Connection.none {
            checkConection.accept(false)
            self.weatherDataBehavior.accept(returnData())
        }
    }
    
    func checkCountOfLocations() {
        weatherobservableCount.subscribe(onNext: { [weak self] bool in
            if bool {
                self?.deactivateBtn.onNext(true)
            } else{
                self?.deactivateBtn.onNext(false)
            }
        }).disposed(by: disposeBag)
    }
    
    func saveDataLocally(model: [CountryWeatherModel] = []) {
       let _ = CachingManager.shared.cache(model, with: CachKeys.countryWeather)
    }
    
    func returnData() -> [CountryWeatherModel] {
        let model: [CountryWeatherModel] = CachingManager.shared.getCached(value: CachKeys.countryWeather) ?? []
        return model
    }
    
    func addCountryWeather(model: CountryWeatherModel) {
        let isExist = weatherDataBehavior.value.contains(model)
        if checkConection.value {
            if self.weatherDataBehavior.value.count < 5  && !isExist{
                self.weatherDataBehavior.acceptAppending(model)
                saveDataLocally(model: self.weatherDataBehavior.value)
            }
        }else {
                self.weatherDataBehavior.accept(returnData())
        }
    }
    
    func removeItem(atRow: Int){
        weatherDataBehavior.remove(at: atRow)
    }
    
}
