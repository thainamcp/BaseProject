//
//  DayWeather.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 26/12/2023.
//  Copyright © 2023 Vulcan Labs. All rights reserved.
//

import Foundation
struct DayWeather{
    var contry : String
    var timezone: Int
    var weatherData : [WeatherData]
    
    init(contry: String, timezone: Int, weatherData: [WeatherData]) {
        self.contry = contry
        self.timezone = timezone
        self.weatherData = weatherData
    }
    
    func getTemperatureCMaxOnDay() -> String {
        let weather = weatherData.max(by: {$0.main.temp < $1.main.temp})
        let temperature = ConvertUilt.shared.ConvertTemperatureC(temp: weather?.main.temp ?? 0)
        return temperature;
    }
    
    func getTemperatureCMixOnDay() -> String {
        let weather = weatherData.min(by: {$0.main.temp < $1.main.temp})
        let temperature = ConvertUilt.shared.ConvertTemperatureC(temp: weather?.main.temp ?? 0)
        return temperature;
        
    }
    
    func getTemperatureFMaxOnDay() -> String {
        let weather = weatherData.max(by: {$0.main.temp < $1.main.temp})
        let temperature = ConvertUilt.shared.ConvertTemperatureF(temp: weather?.main.temp ?? 0)
        return temperature;
    }
    
    func getTemperatureFMixOnDay() -> String {
        let weather = weatherData.min(by: {$0.main.temp < $1.main.temp})
        let temperature = ConvertUilt.shared.ConvertTemperatureF(temp: weather?.main.temp ?? 0)
        return temperature;
    }   
    
    func sortWeatherData () -> [WeatherData] {
        let list = self.weatherData.sorted( by: {$0.dt < $1.dt})
        return list
    }
    
    func getWeatherCurrent()-> WeatherData?{
        let currentDate = Date()
        let currentTimestamp = Int(currentDate.timeIntervalSince1970) + self.timezone
     
        if let lastWeatherData = self.weatherData.filter({$0.dt < currentTimestamp}).last {
            return lastWeatherData;
        }
        return nil
    }
    
    
}
