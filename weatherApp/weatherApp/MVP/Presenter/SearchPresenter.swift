////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////

protocol SearchPresenterDelegate: AnyObject {
    func searchDidStart()
    func searchDidFinish(with results: [String])
}

class SearchPresenter {
    weak var view: SearchProtocol?
    weak var delegate: SearchPresenterDelegate?
    var  weatherApi = WeatherManager()
    private let data: WeatherModel
    
    init(view: SearchProtocol, data: WeatherModel) {
        self.view = view
        self.data = data
    }
}

