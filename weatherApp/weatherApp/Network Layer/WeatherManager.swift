////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    var delegate: WeatherManagerDelegate?

    private let apiKey = "80560928235f2595a139e2f7d3c57398"
    private let url = "https://api.openweathermap.org/data/2.5/weather?&appid"
    
    func fetchWeather(cityName: String, completion: @escaping (Result<WeatherModel, Error>)-> Void){
        let weatherURL = "\(url)=\(apiKey)&q=\(cityName)&units=metric"
         guard let url = URL(string: weatherURL) else {
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
                 completion(.success(try decoder.decode(WeatherModel.self, from: data)))
             } catch {
                 print(error.localizedDescription)
             }
         }.resume()
    }
    func fetchWeatherByLocation(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (Result<WeatherModel, Error>)-> Void){
        let weatherURL = "\(url)=\(apiKey)&lat=\(lat)&lon=\(lon)&units=metric"
         guard let url = URL(string: weatherURL) else {
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
                 completion(.success(try decoder.decode(WeatherModel.self, from: data)))
             } catch {
                 print(error.localizedDescription)
             }
         }.resume()
    }
}
