//
//  BaseWireframe.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Toast_Swift
import RxReachability
import Reachability

protocol ViewModel {
    
}

class BaseWireframe<T: BaseViewModel>: UIViewController {
    var viewModel: T!
    var coordinator: Coordinator!

    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
    }
    
    init(viewModel: T, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func bind(viewModel: T){
        fatalError("Please override bind function")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension BaseWireframe {
    func displayError(text: String){
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelButton = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
}

extension BaseWireframe where T: BaseViewModel {
    func bindLoadings(){
        print("Base view model is implemneted here..")
    }
}
