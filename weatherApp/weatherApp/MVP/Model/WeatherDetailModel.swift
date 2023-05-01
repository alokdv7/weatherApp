////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////

import Foundation

// MARK: - WeatherDetailModel
struct WeatherDetailModel: Codable {
    var cod: String?
    var message, cnt: Int?
    var list: [WeatherDetailList]?
    var city: WeatherDetailCity?
}

// MARK: - City
struct WeatherDetailCity: Codable {
    var id: Int?
    var name: String?
    var coord: WeatherDetailCoord?
    var country: String?
    var population, timezone, sunrise, sunset: Double?
}

// MARK: - Coord
struct WeatherDetailCoord: Codable {
    var lat, lon: Double?
}

// MARK: - List
struct WeatherDetailList: Codable {
    var dt: Int?
    var main: WeatherDetailMain?
    var weather: [WeatherDetail]?
    var clouds: WeatherDetailClouds?
    var wind: WeatherDetailWind?
    var visibility: Int?
    var pop: Double?
    var sys: WeatherDetailSys?
    var dtTxt: String?
    var rain: WeatherDetailRain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - Clouds
struct WeatherDetailClouds: Codable {
    var all: Int?
}

// MARK: - MainClass
struct WeatherDetailMain: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, seaLevel, grndLevel, humidity: Double?
    var tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct WeatherDetailRain: Codable {
    var the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct WeatherDetailSys: Codable {
    var pod: WeatherDetailPod?
}

enum WeatherDetailPod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct WeatherDetail: Codable {
    var id: Int?
    var main: MainEnum?
    var description, icon: String?
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct WeatherDetailWind: Codable {
    var speed: Double?
    var deg: Double?
    var gust: Double?
}
