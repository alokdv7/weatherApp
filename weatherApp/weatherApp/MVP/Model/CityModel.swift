
////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
///
struct CityModel: Codable {
    let location: Location?
    let current: Current?
}

struct Location: Codable {
    let name: String?
    let region: String?
    let country: String?
   
}

struct Current: Codable {
    let condition: Condition
}

struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}
