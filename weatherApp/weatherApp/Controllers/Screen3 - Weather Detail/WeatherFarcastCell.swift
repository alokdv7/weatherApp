////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import UIKit

class WeatherFarcastCell: UICollectionViewCell {
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastTemp: UILabel!
    @IBOutlet weak var time: UILabel!
    static let cell = "WeatherFarcastCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with data: WeatherDetailList) {
        if let weather = data.weather, weather.count > 0{
            if let icon = weather[0].icon {
                let iconId = "https://openweathermap.org/img/wn/\(icon)@2x.png"
                if let iconURL = URL(string: iconId) {
                    self.forecastImage.load(url: iconURL)
                }
            }
        }
        let tempValue: Double = (data.main?.temp!)!
        self.forecastTemp.text = "\(tempValue.customRound(.toNearestOrEven, precision: .thousands))°C"
        self.time.text = Utilities.forcastDateInCorrectTime("\(data.dtTxt ?? "")")
    }
}
