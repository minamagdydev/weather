//
//  SearchViewModel.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchViewModelOutput {
    var locationDetails: BehaviorRelay<WeatherLocation> { get set }
    var locationDetailsModel: PublishSubject<CountryWeatherModel> { get set }
}

protocol SearchViewModelInput {
    func search(searchText: String)
    func didSelectItemAtIndexPath(_ indexPath: IndexPath)
}

class SearchViewModel:BaseViewModel, SearchViewModelInput, SearchViewModelOutput {

    var locationDetails: BehaviorRelay<WeatherLocation> = .init(value: WeatherLocation())
    var locationDetailsModel: PublishSubject<CountryWeatherModel> = .init()
    var allLocations: BehaviorRelay<[WeatherLocation]> = .init(value: [])
    var filteredLocations: BehaviorRelay<[WeatherLocation]> = .init(value: [])
    let disposeBag = DisposeBag()
    let networkClient: NetworkManager
    var filteredLocation: Observable<[WeatherLocation]> {
           filteredLocations.asObservable().map{
               Array($0.prefix(20))
           }
       }
    var dismissView: () -> () = {}
    var allLocationsArray: [WeatherLocation] = .init([])
    
    init(networkClient: NetworkManager = NetworkManager()) {
        self.networkClient = networkClient
    }
    
    private func createLocation(line: [String]){
        allLocations.acceptAppending(WeatherLocation(city: line.first!, country: line.last!, countryCode: line[1], isCurrentLocation: false))
        allLocationsArray.append(WeatherLocation(city: line.first!, country: line.last!, countryCode: line[1], isCurrentLocation: false))
    }
    
    func search(searchText: String) {
        filteredLocations.accept(Array(allLocationsArray.filter({ (location) -> Bool in
            return location.city.lowercased().contains(searchText.lowercased()) || location.country.lowercased().contains(searchText.lowercased())
        }).prefix(15)))
    }
    
    func didSelectItemAtIndexPath(_ indexPath: IndexPath) {
        filteredLocation.subscribe(onNext: { [weak self] model in
            self?.locationDetails.accept(model[indexPath.row])
            self?.fetchCurrentLocationData()
        }).disposed(by: disposeBag)
        
    }
    
    func fetchCurrentLocationData(finished: @escaping () -> () = {}) {
        isLoading.onNext(true)
        let city = "\(locationDetails.value.city ?? "")"+", \( locationDetails.value.countryCode ?? "")"
        self.networkClient.requestData(endPoint: .searchLocation(id: city), decodingType: CountryWeatherModel.self, completionHandler: { [weak self] result in
            self?.dismissView()
            switch result {
            case .success(let model):
                self?.locationDetailsModel.onNext(model)
                self?.isLoading.onNext(false)
                finished()
            case .failure( _):
                self?.isLoading.onNext(false)
                
            }
        })
    }
    
    
    private func parseCSVAt(url: URL){
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                var i = 0
                for line in dataArr {
                    if line.count > 2 && i != 0 {
                        createLocation(line: line)
                    }
                    i += 1
                }
            }
        } catch {
            fatalError("error read CSV")
        }
    }
    
    func loadLocationsFromCSV() {
        if let path = Bundle.main.path(forResource: "location", ofType: "csv") {
            parseCSVAt(url: URL(fileURLWithPath: path))
        }
    }
}
