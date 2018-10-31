//
//  ViewController.swift
//  Dark Skys
//
//  Created by Brian Sadler on 10/24/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherDisplayViewController: UIViewController {
    @IBOutlet weak var darkSkyLogo: UIImageView!
    @IBOutlet weak var locationTitleView: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            iconLabel.text = displayWeatherData.condition.icon
            currentTempLabel.text = "\(displayWeatherData.temperature)º"
            highTempLabel.text = "\(displayWeatherData.highTemp)º"
            lowTempLabel.text = "\(displayWeatherData.lowTemp)º"
            
        }
        
    }
    
    var displayGeocodingData: GeocodingData! {
        didSet {
            locationTitleView.text = displayGeocodingData.formattedAddress
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets default UI
        defaultUI()
  let apiManager = APIManager()
        
        
//        apiManager.geocode(address: "Glasgow,+Kentucky") {
//            (data, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            guard let data = data else {
//                return
//            }
//            print(data.formattedAddress)
//            print(data.latitude)
//            print(data.longitude)
//        }
    }
    // this function gives default data when the app is first loaded
    func defaultUI() {
        locationTitleView.text =  ""
        iconLabel.text = "🌞"
        currentTempLabel.text = "Enter a location"
        highTempLabel.text = "-"
        lowTempLabel.text = "-"
        
        
        
        
    }
    // Unwind action so that we can unwind to this screen after retrieving data
    @IBAction func unwindToWeatherDisplay(segue:UIStoryboardSegue) {
        
    }

}

