//
//  SearchViewController.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import UIKit

class SearchViewController: BaseWireframe<SearchViewModel> {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerCellNib(cellClass: SearchCell.self)
        }
    }
    
    @IBOutlet weak var dismiss: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        searchBar.becomeFirstResponder()
        searchBar.rx.cancelButtonClicked.subscribe(onNext: { [weak self] _ in
            self?.coordinator.dismiss()
        }).disposed(by: disposeBag)
    }
    
    override func bind(viewModel: SearchViewModel) {
        DispatchQueue.global().async {
            viewModel.loadLocationsFromCSV()
        }
        viewModel.filteredLocation.bind(to: tableView.rx.items(cellIdentifier: String(describing: SearchCell.self), cellType: SearchCell.self)) { index, model, cell in
            cell.config(model: model)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { [weak self] (indexPath) in
            guard let self = self, let indexPath = indexPath.element else { return }
            self.viewModel.didSelectItemAtIndexPath(indexPath)
        }.disposed(by: disposeBag)
        viewModel.dismissView = { [weak self] in
            self?.coordinator.dismiss()
        }
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            return
        }
        self.viewModel.search(searchText: searchText)
    }
}



