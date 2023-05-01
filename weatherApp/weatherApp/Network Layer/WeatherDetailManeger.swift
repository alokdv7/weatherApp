////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////

protocol WeatherDetailManagerDelegate {
    func didUpdateWeatherDetail(_ weatherDetailManeger: WeatherDetailManeger, weatherDetailModel: WeatherDetailModel)
    func didFailWithError(error: Error)
}

import Foundation
import UIKit
struct WeatherDetailManeger {
    var delegate: WeatherDetailManagerDelegate?
    private let apiKey = "80560928235f2595a139e2f7d3c57398"
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
       
    func getWeatherDataDetails(lat: Double,lon :Double, completion: @escaping (Result<WeatherDetailModel, Error>)-> Void) {
        guard let url = URL(string: "\(baseURL)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            let decoder = JSONDecoder()
            do {
                guard let data = data else{
                    completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                    return
                }
                completion(.success(try decoder.decode(WeatherDetailModel.self, from: data)))
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
