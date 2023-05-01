////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import UIKit
import CoreLocation

class SearchCityVC: UIViewController, SearchProtocol, CLLocationManagerDelegate {
    
    
    private var searchPresenter: SearchPresenter!
    var weathermanger = WeatherManager()
    var cityName = ""
    
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        searchTextField.autocapitalizationType = .words
        searchTextField.keyboardType = .alphabet
        if let lat = defaults.object(forKey: "latitude") as? Double{
            if let lon = defaults.object(forKey: "longitude") as? Double {
                self.callCurrentLocationWeatherData(lat, long: lon)
            }
        } else {
            self.toGetCurrentLocation()
        }
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentingViewController?.viewWillDisappear(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    func toGetCurrentLocation(){
        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in
            if error != nil {
                return
            }
            guard let location = location else {
                return
            }
            LocationManager.shared.getReverseGeoCodedLocation(location: location) { location, placemark, error in
                self.cityName = (placemark?.locality)!
                self.callCurrentLocationWeatherData(location!.coordinate.latitude, long: location!.coordinate.longitude)
            }
           
        }
    }
    func callCurrentLocationWeatherData(_ lat: Double, long: Double){
        weathermanger.fetchWeatherByLocation(lat: lat,lon:long) { [self] (result) in
            switch result {
            case .success(let weatherModel):
                print("\(weatherModel) weatherModel.")
                // Instantiate the presenter
                self.searchPresenter = SearchPresenter(view: self, data: weatherModel)
                DispatchQueue.main.async {
                    self.searchPresenter.view?.updatePage(weatherModel)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        self.toGetCurrentLocation()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func updatePage(_ weather: WeatherModel) {
        //To update page based upon weather data
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weather.main?.temp ?? 0)"
            self.windSpeed.text = "\(weather.wind?.speed ?? 0)"
            self.humidity.text = "\(weather.main?.humidity ?? 0)"
            self.conditionsLabel.text = "\(weather.weather![0].description ?? "")"
            self.cityLabel.text = self.cityName + " (" + "\(weather.sys?.country ?? "")" + ")"
            self.riseLabel.text = Utilities.sunRiseInCorrectFormat((weather.sys?.sunrise!)!)
            self.setLabel.text = Utilities.sunRiseInCorrectFormat((weather.sys?.sunset!)!)
            let weatherImgae = weather.weather
            let weatherModel =  CoreDataManager.shared.checkWeatherModel(cityName: self.cityName)
            if(weatherModel == false){
                CoreDataManager.shared.saveWeatherModel(cityname: self.cityName, temp: weather.main?.temp ?? 0.0, image:  weatherImgae?[0].icon ?? "",lat:(weather.coord?.lat)!,lon:(weather.coord?.lon)! )
            }
            if let weather = weather.weather, weather.count > 0{
                if let icon = weather[0].icon {
                    let iconId = "https://openweathermap.org/img/wn/\(icon)@2x.png"
                    if let iconURL = URL(string: iconId) {
                        self.conditionImage.load(url: iconURL)
                    }
                }
            }
        }
    }
    
}

extension SearchCityVC: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            
            if city.count >= 1 {
                self.cityName = city
                weathermanger.fetchWeather(cityName: city) { [self] (result) in
                    switch result {
                    case .success(let weatherModel):
                        print("\(weatherModel) weatherModel.")
                        // Instantiate the presenter
                        self.searchPresenter = SearchPresenter(view: self, data: weatherModel)
                        DispatchQueue.main.async {
                            self.searchPresenter.view?.updatePage(weatherModel)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                self.toGetCurrentLocation()
            }
        }
        searchTextField.text = ""
    }
}
