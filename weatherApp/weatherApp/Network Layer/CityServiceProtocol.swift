////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import Foundation
protocol WeatherService {
    func getWeatherData(for city: String, completion: @escaping (Result<CityModel, Error>) -> Void)
}


