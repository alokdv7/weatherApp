//
//  CityServiceProtocol.swift
//  weatherApp
//
//  Created by Rahul Srivastava on 29/04/23.
//

import Foundation
protocol WeatherService {
    func getWeatherData(for city: String, completion: @escaping (Result<CityModel, Error>) -> Void)
}
