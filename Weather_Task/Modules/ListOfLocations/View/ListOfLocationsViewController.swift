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

class ListOfLocationsViewController: BaseWireframe<ListOfLocationsViewModel> {

    @IBOutlet weak var locationListTableView: UITableView! {
        didSet {
            locationListTableView.delegate = self
            locationListTableView.registerCellNib(cellClass: LocationsCell.self)
            locationListTableView.registerCellNib(cellClass: ListOfLocationsHeader.self)
        }
    }
    
    var delegate: AllLocationsTableViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind(viewModel: ListOfLocationsViewModel) {
        viewModel.checkHandleConnectionFail()
        viewModel.checkCountOfLocations()
        viewModel.weatherDataBehavior.bind(to: locationListTableView.rx.items(cellIdentifier: String(describing: LocationsCell.self), cellType: LocationsCell.self)) { index, model, cell in
            cell.locationName.text = model.name
            cell.temp.text = "\(String(describing: model.main?.temp ?? 0.0))°"
        }.disposed(by: disposeBag)
        
        locationListTableView.rx.itemSelected.subscribe { [weak self] (indexPath) in
            guard let self = self, let index = indexPath.element else { return }
            self.delegate?.didChooseLocation(atIndex: index.row, shouldRefresh: true)
            self.coordinator.pop()
        }.disposed(by: disposeBag)
        
        locationListTableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            viewModel.removeItem(atRow: indexPath.row)
        }).disposed(by: disposeBag)
        
    }

}

extension ListOfLocationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeue() as ListOfLocationsHeader
        viewModel.deactivateBtn.subscribe { (active) in
            guard let active = active.element else { return }
                cell.addAnotherlocation.isUserInteractionEnabled = active
        }.disposed(by: disposeBag)
        cell.addAnotherlocation.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.coordinator.Main.navigate(to: .searchViewController, with: .present, vc: { [weak self] searchViewController in
                (searchViewController as! SearchViewController).viewModel.locationDetailsModel.subscribe(onNext: { [weak self] model in
                    self?.viewModel.addCountryWeather(model: model)
                }).disposed(by: self?.disposeBag ?? DisposeBag())
            })
        }).disposed(by: disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height * 0.1
    }
}
