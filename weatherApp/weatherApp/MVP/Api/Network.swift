//
//  Network.swift
//  weatherApp
//
//  Created by Rahul Srivastava on 29/04/23.
//

import Foundation
import UIKit
class WeatherAPIService: WeatherService {
    private let baseURL = "http://api.weatherapi.com/v1/current.json?key=d96e3b27510e418c81785214232904&q=London&aqi=no"
   // private let baseURL = "http://api.weatherapi.com/v1/current.json"
   // private let apiKey = "d96e3b27510e418c81785214232904"
    public let cityName = ""

    func getWeatherData(for city: String, completion: @escaping (Result<CityModel, Error>) -> Void) {
       // guard let url = URL(string: "\(baseURL)?q=\(cityName)&appid=\(apiKey)") else {
        guard let url = URL(string: "\(baseURL)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

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
                completion(.success(try decoder.decode(CityModel.self, from: data)))
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
