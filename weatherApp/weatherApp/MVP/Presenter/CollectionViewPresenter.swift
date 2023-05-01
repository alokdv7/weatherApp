////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import UIKit
protocol CollectionViewPresenterProtocol {
    var view: CollectionViewViewProtocol? { get set }
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func configure(_ cell: WeatherFarcastCell, at index: Int)
}

class CollectionViewPresenter: CollectionViewPresenterProtocol {
    var view: CollectionViewViewProtocol?
    var model: WeatherDetailModel

    init(view: CollectionViewViewProtocol, model: WeatherDetailModel) {
        self.model = model
        self.view = view
    }

    func viewDidLoad() {
        self.view!.reloadCollection()
    }

    func numberOfItemsInSection() -> Int {
        guard let list = model.list, list.count > 0 else{
            return 0
        }
        return list.count
    }

    func configure(_ cell: WeatherFarcastCell, at index: Int) {
         cell.configure(with: model.list![index])
    }
    
    func item(atIndex index: Int) -> WeatherDetailList{
        return self.model.list![index]
    }
}
