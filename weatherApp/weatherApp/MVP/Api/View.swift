////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import Foundation
import UIKit

protocol CityProtocol: AnyObject {
    func updateTableView()
}

protocol SearchProtocol: AnyObject {
    func updatePage(_ weather: WeatherModel)
}
protocol WeatherDetailsProtol: AnyObject {
    func updatePage(_ weather: WeatherDetailModel)
}
protocol CollectionViewViewProtocol: AnyObject {
    func reloadCollection()
}
