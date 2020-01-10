//
//  WeatherManager.swift
//  Clima
//
//  Created by Fazle Rabbi Linkon on 9/1/20.
//  Copyright © Fazle Rabbi Linkon. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func weatherDidUpdate(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d71895db00ed5a89ffd7aabee587776a&units=metric"
    

    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //        1. Create a URL
        if let url = URL(string: urlString) {
            //        2. Create a URL Session
            let session = URLSession(configuration: .default)
            //        3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    //                    let dataString = String(data: safeData, encoding: .utf8)
                    //                    print(dataString!)
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.weatherDidUpdate(weather: weather)
                    }
                }
            }
            //        4. Start the Task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            
            let weather = WeatherModel(cityName: name, conditionId: id, temperature: temp)
//            print(weather.conditionName)
//            print(weather.temperatureString)
            return weather
        } catch {
            print(error)
            return nil
        }
    }
    
    
    
}
