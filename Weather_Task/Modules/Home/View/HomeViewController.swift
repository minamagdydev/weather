//
//  HomeViewController.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 10/28/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: BaseWireframe<HomeViewModel> {
    
    //MARK: - IBOulets
    @IBOutlet weak var weatherScrollView: UIScrollView! {
        didSet {
            weatherScrollView.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var navigateToList: UIBarButtonItem!
    var currentLocation: CLLocationCoordinate2D!
    var allLocations: [WeatherLocation] = []
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    override func bind(viewModel: HomeViewModel) {
        viewModel.checkHandleConnectionFail()
        createCountryWeatherSlide(refreachUI: { allWeatherViews in
            self.setupWeatherScrollView(weatherViews: allWeatherViews)
            self.pageControl.numberOfPages = allWeatherViews.count
            self.pageControl.currentPage = 0
            self.view.bringSubviewToFront(self.pageControl)
        })
    }
    
    func setupWeatherScrollView(weatherViews: [WeatherView]) {
        for item in 0 ..< weatherViews.count {
            let weatherView = weatherViews[item]
            let xPos = self.view.frame.width * CGFloat(item)
            weatherView.frame = CGRect(x: xPos, y: 0, width: view.bounds.width, height: weatherScrollView.bounds.height)
            weatherScrollView.addSubview(weatherView)
            weatherScrollView.contentSize.width = weatherView.frame.width * CGFloat(item+1)
        }
    }
    
    func createCountryWeatherSlide(refreachUI: @escaping ([WeatherView])->()){
        var views = [WeatherView]()
        viewModel.getInitialData()
        viewModel.weatherData.subscribe(onNext: { [weak self] model in
            if model.count > 0 {
                views = []
                for index in 0...model.count - 1{
                    let country = WeatherView(long: model[index].coord?.lon ?? 0.0, lat: model[index].coord?.lat ?? 0.0, countryID: model[index].id ?? 0)
                    let date = self?.viewModel.formmatingDate()
                    country.tableView.reloadData()
                    country.config(model: model[index], date: date ?? "")
                    views.append(country)
                    refreachUI(views)
                }
            }}).disposed(by: disposeBag)
        navigateToList.rx.tap.subscribe({ [weak self] _ in
            ()
            self?.coordinator.Main.navigate(to: .listOfLocations(weatherDataBehavior: self?.viewModel?.weatherDataBehavior ?? .init(value: [])), vc: { listOfLocationsView in
                (listOfLocationsView as! ListOfLocationsViewController).delegate = self
            })
        }).disposed(by: disposeBag)
           
    }
    
    private func updatePageControlSelectedPage(currentPage: Int){
        pageControl.currentPage = currentPage
    }
  
}

extension HomeViewController: AllLocationsTableViewControllerDelegate {
    func didChooseLocation(atIndex: Int, shouldRefresh: Bool) {
        let viewNumber = CGFloat(integerLiteral: atIndex)
        let newOffset = CGPoint(x: (weatherScrollView.frame.width + 1) * viewNumber, y: 0)
        weatherScrollView.setContentOffset(newOffset, animated: false)
        updatePageControlSelectedPage(currentPage: atIndex)
    }
    
    
}
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        updatePageControlSelectedPage(currentPage: Int(round(value)))
    }
}
