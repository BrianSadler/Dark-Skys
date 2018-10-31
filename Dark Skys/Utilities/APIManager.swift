//
//  APIManager.swift
//  Dark Skys
//
//  Created by Brian Sadler on 10/29/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    //Base URL for the Dark Sky API
    private let darkSkyURL = "https://api.darksky.net/forecast/"
    
    //Base URL for Google Geocoding API
    private let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    //Instance of the APIKeys struct
    private let apiKeys = APIKeys()
    
    //enum containg different errors we could get from trying to connect to an API
    enum APIErrors: Error {
        case noData
        case invalidData
        case noResponse
        
    }
    
    func getWeather(latitude: Double, longitude: Double, onCompletion: @escaping (WeatherData?, Error?)-> Void) {
        let url = darkSkyURL + apiKeys.darkSkyKey + "/" + "\(latitude)" + "," + "\(longitude)"
        
        let request = Alamofire.request(url)
        
        request.responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                if let weatherData = WeatherData(json: json) {
                    onCompletion(weatherData, nil) } else {
                    onCompletion(nil, APIErrors.invalidData)
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
            
        }
    }
    
    
    // Attempt to geocode the address that is passed in and call the onCompletion closure by passing geocoding data or an error
    func geocode(address: String, onCompletion: @escaping (GeocodingData?, Error?) -> Void) {
        let url = googleBaseURL + address + "&key=" + apiKeys.googleKey
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // If the JSON can be converted into geocoding data call the completion closure
                if let geocodingData = GeocodingData(json: json) {
                    onCompletion(geocodingData, nil) } else {
                    onCompletion(nil, APIErrors.invalidData)
                    
                }
                
            case .failure(let error):
                onCompletion(nil, error)
            }
            
        }
    }
}
