//
//  ForeCastViewModel.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/4/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation
import Reachability
import RxSwift
import RxCocoa

class ForecastViewModel: BaseViewModel {
    
    var reachability = Reachability()
    let networkClient: NetworkManager
    var forecastDataBehavior: PublishSubject<ForecastModel> = .init()
    var checkConection: BehaviorRelay<Bool> = .init(value: true)
    var countryID = ""
    
    init(networkClient: NetworkManager = NetworkManager(), countryID: String) {
        self.networkClient = networkClient
        self.countryID = countryID
    }
    
    func checkHandleConnectionFail() {
        if reachability?.connection == Reachability.Connection.none {
            reachability?.stopNotifier()
            checkConection.accept(false)
            let model = returnData(id: countryID)
            self.forecastDataBehavior.onNext(model)
        }
    }
    
    func saveDataLocally(model: ForecastModel, id: String) {
        let _ = CachingManager.shared.cache(model, with: id)
    }
    
    func returnData(id: String) -> ForecastModel {
        let model: ForecastModel = CachingManager.shared.getCached(value: id)!
        return model
    }
    
    func fetchForecastData(long: Double, lat: Double, finished: @escaping () -> () = {}) {
        if checkConection.value {
        self.networkClient.requestData(endPoint: .getListWeatherForecast(lat: lat, long: long), decodingType: ForecastModel.self, completionHandler: { [weak self] result in
            switch result {
            case .success(let model):
                self?.forecastDataBehavior.onNext(model)
                self?.saveDataLocally(model: model, id: self?.countryID ?? "")
                self?.isLoading.onNext(false)
                finished()
            case .failure( _):
                self?.isLoading.onNext(false)
                let model = self?.returnData(id: self?.countryID ?? "")
                self?.forecastDataBehavior.onNext(model!)
             }
          })
        }
    }
}

