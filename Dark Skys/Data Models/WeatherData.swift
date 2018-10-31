//
//  WeatherData.swift
//  Dark Skys
//
//  Created by Brian Sadler on 10/26/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherData {
    //Mark:- Types
    enum Condition: String {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        
        var icon: String {
            // switch based on value of enum
            switch self {
            case .clearDay:
                return "☀️"
            case .clearNight:
                return "🌝"
            case .rain:
                return "🌧"
            case .snow:
                return "🌨"
            case .sleet:
                return "❄️"
            case .wind:
                return "💨"
            case .fog:
                return "🌫"
            case .cloudy:
                return "☁️"
            case .partlyCloudyDay:
                return "🌤"
            case .partlyCloudyNight:
                return "🌚"
            }
        }
        
    }
    enum WeatherDataKeys: String {
        case currently = "currently"
        case temperature = "temperature"
        case icon = "icon"
        case daily = "daily"
        case data = "data"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
        
    }
    //Mark:- Properties
    
    let temperature: Double
    let highTemp: Double
    let lowTemp: Double
    let condition: Condition
    
    //Mark:- Methods
    
    init(temperature: Double, highTemp: Double, lowTemp:Double, condition: Condition) {
        self.temperature = temperature
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.condition = condition
    }
    convenience init?(json: JSON) {
        guard let temperature = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.temperature.rawValue].double else{
            return nil
        }
        guard let highTemperature =
            json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureHigh.rawValue].double else {
                return nil
        }
        guard let lowTemperature =
            json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureLow.rawValue].double else {
                return nil
        }
        guard let conditionString =
            json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.icon.rawValue].string else {
                return nil
        }
        // take the sting back from JSON and use it for an instance of the condition enum
        guard let condition = Condition(rawValue: conditionString) else {
            return nil
        }
        
        self.init(temperature: temperature, highTemp: highTemperature, lowTemp: lowTemperature, condition: condition)
    }
}
