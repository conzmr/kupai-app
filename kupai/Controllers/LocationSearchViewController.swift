//
//  LocationSearchTable .swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/17/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchViewController: UIViewController {
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    weak var delegate: LocationControllerDelegate?
    
    @IBOutlet weak var searchResultsTableView: UITableView!{
        didSet {
            let nib = UINib(nibName: "CurrentLocationTableViewCell", bundle: nil)
            searchResultsTableView.register(nib, forCellReuseIdentifier: "CurrentLocationCellId")
            searchResultsTableView.dataSource = self
            searchResultsTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
    }
    
}

extension LocationSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
    }
}

extension LocationSearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.showAlert(title: "Ocurrió un error buscando tu solicitud", message: "Prueba tu conexión a internet e intenta más tarde")
    }
}

extension LocationSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CurrentLocationCellId", for: indexPath) as! CurrentLocationTableViewCell
//            cell.textLabel?.text = "Usar mi ubicación actual"
//            cell.detailTextLabel?.text = ""
        }
        else{
            let searchResult = searchResults[indexPath.row-1]
            cell.textLabel?.text = searchResult.title
            cell.detailTextLabel?.text = searchResult.subtitle
        }
        return cell
    }
}

extension LocationSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            print("REMOVING FOR KEY, pressing 0 indexr")
            UserDefaults.standard.synchronize()
            UserDefaults.standard.removeObject(forKey: "address")
            self.delegate?.getCurrentLocation()
             _ = self.navigationController?.popViewController(animated: true)
        }else{
            let completion = searchResults[indexPath.row-1]
            let searchRequest = MKLocalSearch.Request(completion: completion)
            let search = MKLocalSearch(request: searchRequest)
            search.start { (response, error) in
                if let clickedItem  = response?.mapItems[0] {
                    let coordinate = clickedItem.placemark.coordinate
                    print("CLICKED ITEM", clickedItem.name ?? "No Address")
                    print("COORDINATE LATITUDE", clickedItem.placemark.coordinate.latitude)
                    self.saveLocalSearchResults(address: clickedItem.name!, latitude: coordinate.latitude, longitude: coordinate.longitude)
                    self.delegate?.reloadPromotionsData(latitude: coordinate.latitude, longitude: coordinate.longitude, address: clickedItem.name!)
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func saveLocalSearchResults(address: String, latitude: Double, longitude: Double) {
        UserDefaults.standard.set(address, forKey: "address")
        UserDefaults.standard.set(latitude, forKey: "latitude")
        UserDefaults.standard.set(longitude, forKey: "longitude")
        UserDefaults.standard.synchronize()
    }
}
