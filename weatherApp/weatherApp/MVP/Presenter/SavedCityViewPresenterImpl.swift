////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import Foundation
import UIKit
import CoreData
class SavedCityViewPresenterImpl {
    weak var view: CityProtocol?
    var data: [WeatherEntity] = []
    
    init(view: CityProtocol, data: [WeatherEntity]) {
        self.view = view
        self.data = data
    }
    func getData() {
        data = CoreDataManager.shared.retriveWeatherModel()
    }
    
    
    func configure(_ cell: CityTableCell, at index: Int) {
        cell.configure(with: data[index])
    }
    
    func numberOfItems() -> Int {
        return data.count
    }
    
    func item(atIndex index: Int) -> WeatherEntity{
        return data[index]
    }
    
}
