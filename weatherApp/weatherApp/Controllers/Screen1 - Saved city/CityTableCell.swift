////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////

import UIKit
import CoreData
import Foundation

class CityTableCell: UITableViewCell {
    // Outlets for image and text views
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    static let cell = "CityTableCell"
    // Configure the cell with data
   
    func configure(with data: WeatherEntity) {
        titleLabel.text = "\(data.value(forKey: "cityName") ?? "")"
        let tempValue: Double = data.value(forKey: "temp") as! Double
        tempLabel.text = "\(tempValue.customRound(.toNearestOrEven, precision: .thousands))"
        let icon = "\(data.value(forKey: "image") ?? "")"
        
        let iconId = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        if let iconURL = URL(string: iconId) {
            self.cityImage.load(url: iconURL)
        }
    }
}


