//
//  WeatherView.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherView: NibLoadingView {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerCellNib(cellClass: ForecastCell.self)
        }
    }
    let disposeBag = DisposeBag()
    var long = 0.0
    var lat = 0.0
    var countryID = 0
    var viewModel: ForecastViewModel?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bindForecast()
    }
    
    init(frame: CGRect = CGRect(), long: Double, lat: Double, countryID: Int) {
        self.long = long
        self.lat = lat
        self.countryID = countryID
        viewModel = ForecastViewModel(countryID: "\(countryID)")
        super.init(frame: frame)
        bindForecast()
    }
    
    func bindForecast() {
        viewModel?.forecastDataBehavior.map{$0.list ?? []}.bind(to: tableView.rx.items(cellIdentifier: String(describing: ForecastCell.self), cellType: ForecastCell.self)) { index, model, cell in
            cell.configure(with: model, index: index)
        }.disposed(by: disposeBag)
        viewModel?.checkHandleConnectionFail()
        viewModel?.fetchForecastData(long: long, lat: lat)
    }
    
    func config(model: CountryWeatherModel, date: String) {
        countryName.text = model.name ?? ""
        degree.text = "\(String(describing: model.main?.temp ?? 0.0))°"
        day.text = "\(String(describing: date))"
    }
    
}


