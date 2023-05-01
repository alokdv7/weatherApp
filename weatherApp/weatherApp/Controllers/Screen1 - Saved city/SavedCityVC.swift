////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import Foundation
import UIKit

class SavedCityVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var presenter : SavedCityViewPresenterImpl!
    var detailsApi = WeatherDetailManeger()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //Main code
        self.tableView.registerCell(CityTableCell.cell)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        self.presenter = SavedCityViewPresenterImpl(view: self, data: CoreDataManager.shared.retriveWeatherModel())
        DispatchQueue.main.async {
            self.presenter.view?.updateTableView()
        }
    }
}


extension SavedCityVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else{
            return 0
        }
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableCell", for: indexPath) as? CityTableCell else {
            fatalError("Failed to dequeue TableViewCell")
        }
        presenter.configure(cell, at: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let vc: WeatherDetailViewController = UIStoryboard.controller(storyboard: .main)
        vc.lat = presenter.item(atIndex: indexPath.row).lat
        vc.long = presenter.item(atIndex: indexPath.row).long
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SavedCityVC: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        let vc: SearchCityVC = UIStoryboard.controller(storyboard: .main)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        
    }
}

extension SavedCityVC: CityProtocol{
    func updateTableView() {
        self.tableView.reloadData()
    }
}
