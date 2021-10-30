//
//  SearchCell.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(model: WeatherLocation) {
        countryName.text = "\(String(describing: model.country ?? ""))"+" , \(String(describing: model.city ?? ""))"
    }
}
