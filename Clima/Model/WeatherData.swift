//
//  WeatherData.swift
//  Clima
//
//  Created by Fazle Rabbi Linkon on 9/1/20.
//  Copyright © Fazle Rabbi Linkon. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
