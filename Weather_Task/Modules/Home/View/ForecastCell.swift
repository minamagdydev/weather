//
//  ForecastCell.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var temp: UILabel!
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: List, index: Int){
        if let date = model.dtTxt {
            dayLbl.text = CODateFormatter.slashSeparatorDateFormatter(input: date)
        }
        temp.text = "\(String(describing: model.main?.temp ?? 0.0))°"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        temp.text = nil
        dayLbl.text = nil
    }
}
