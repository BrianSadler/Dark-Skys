//
//  LocationSelectionViewController.swift
//  Dark Skys
//
//  Created by Brian Sadler on 10/26/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import UIKit

class LocationSelectionViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var locationSearch: UISearchBar!
    
    //Instance of API Manager class so we can make API calls on this screen
    let apiManager = APIManager()
    
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
locationSearch.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    func retriveGeocodingData(searchAddress: String) {
        apiManager.geocode(address: searchAddress) {
            (geocodingData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            if let recievedData = geocodingData {
                self.geocodingData = recievedData
                //Use that data to make a dark sky call
                self.retriveWeatherData(latitude: recievedData.latitude, longitude: recievedData.longitude)
            } else {
                self.handleError()
                return
            }
            
        }
    }
    func retriveWeatherData(latitude: Double, longitude: Double) {
        apiManager.getWeather(latitude: latitude, longitude: longitude) { (weatherData, error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            if let recievedData = weatherData {
                self.weatherData = recievedData
                // Segue to main screen
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retriveGeocodingData(searchAddress: searchAddress)

    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let destinationVC = segue.destination as?
        WeatherDisplayViewController, let retriveGeocodingData = geocodingData, let retrievingWeatherData = weatherData {
        destinationVC.displayGeocodingData = retriveGeocodingData
        destinationVC.displayWeatherData = retrievingWeatherData
        }
        
        }
    }
 


