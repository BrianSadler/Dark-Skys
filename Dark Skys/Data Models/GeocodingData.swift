//
//  GeocodingData.swift
//  Dark Skys
//
//  Created by Brian Sadler on 10/26/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeocodingData {
    //Mark:- Types
    
    //These are the keys that will be used to get the correct info from google geocode API
    enum GeocodingDataKeys: String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
        
        }
    
    //Mark:- Properties
    
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    //Mark:- Methods
    
    // Regular Init
    init(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.longitude = longitude
        self.latitude = latitude
    }
    
    //failable convenience init for breaking down data from JSON and creating GeocodingData
    
    convenience init?(json: JSON) {
        guard let results = json[GeocodingDataKeys.results.rawValue].array, results.count > 0  else {
            return nil
        }
        
        guard let formattedAdress = results[0][GeocodingDataKeys.formattedAddress.rawValue].string else {
            return nil
        }
        
        guard let latitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.latitude.rawValue].double else {
            return nil
        }
        guard let longitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.longitude.rawValue].double else {
            return nil
        }
        self.init(formattedAddress: formattedAdress, latitude: latitude, longitude: longitude)
    }
    
    
    
}
