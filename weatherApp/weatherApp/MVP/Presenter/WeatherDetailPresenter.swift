////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////

import Foundation

class WeatherDetailPresenter {
    
    weak var view: WeatherDetailsProtol?
    private let data: WeatherDetailModel
    weak var delegate: WeatherDetailsProtol?
    var  networkAPI = WeatherDetailManeger()
    
    init(view: WeatherDetailsProtol, data: WeatherDetailModel) {
        self.view = view
        self.data = data
    }
}
