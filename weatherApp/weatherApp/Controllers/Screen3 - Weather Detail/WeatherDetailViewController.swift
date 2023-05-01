////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////

import UIKit

class WeatherDetailViewController: UIViewController{
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var forcastCollectionView: UICollectionView!
    
    private var weatherDetailPresenter: WeatherDetailPresenter!
    private var collectionViewPresenter: CollectionViewPresenter!
    var weatherDetailManeger = WeatherDetailManeger()
    var lat = 0.0
    var long = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.forcastCollectionView.registerCell(WeatherFarcastCell.cell)
        self.forcastCollectionView.dataSource = self
        self.forcastCollectionView.delegate = self
        weatherDetailManeger.getWeatherDataDetails(lat: self.lat, lon: self.long){ [self] (result) in
            switch result {
            case .success(let weatherDetailModel):
                print("\(weatherDetailModel) weatherDetailModel.")
                // Instantiate the presenter
                self.weatherDetailPresenter = WeatherDetailPresenter(view: self, data: weatherDetailModel)
                //self.WeatherDetailPresenter.delegate = self
                DispatchQueue.main.async {
                    self.weatherDetailPresenter.view?.updatePage(weatherDetailModel)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension WeatherDetailViewController: WeatherDetailsProtol{
    func updatePage(_ weather: WeatherDetailModel) {
        //Update Page based upon model
        self.temperatureLabel.text = "\(weather.list![0].main?.temp ?? 0)"
        if let weather = weather.list![0].weather, weather.count > 0{
            if let icon = weather[0].icon {
                let iconId = "https://openweathermap.org/img/wn/\(icon)@2x.png"
                if let iconURL = URL(string: iconId) {
                    self.conditionImageView.load(url: iconURL)
                }
            }
        }
        self.cityLabel.text = "\(weather.city?.name ?? "")"
        self.feelsLikeLabel.text = "\(weather.list![0].main?.feelsLike ?? 0)" + "°C"
        self.humidityLabel.text = "\(String("\(weather.list![0].main?.humidity ?? 0)"))%"
        self.sunriseTime.text = Utilities.sunRiseInCorrectFormat((weather.city?.sunrise)!)
        self.sunsetLabel.text = Utilities.sunRiseInCorrectFormat((weather.city?.sunset)!)
        self.collectionViewPresenter = CollectionViewPresenter(view: self, model: weather)
        self.collectionViewPresenter.viewDidLoad()
        
    }
}

extension WeatherDetailViewController: CollectionViewViewProtocol{
    func reloadCollection() {
        self.forcastCollectionView.reloadData()
    }
}

extension WeatherDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = self.collectionViewPresenter else{
            return 0
        }
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherFarcastCell", for: indexPath) as? WeatherFarcastCell else {
            fatalError("Failed to dequeue TableViewCell")
        }
        self.collectionViewPresenter.configure(cell, at: indexPath.row)
        return cell
    }
}
