//
//  ClimaData.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 25/08/22.
//

import Foundation
import CoreLocation

struct ClimaData: Codable {
    let coord: Coord
    let weather: [Weather]
    let name: String
    let sys: Sys
    let main: Main
    let clouds: Cloud
    let dt: Date
}

struct Coord: Codable {
    let lon: CLLocationDegrees
    let lat: CLLocationDegrees
}

struct Weather: Codable {
    let id: Int
    let description: String
    let main: String
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Cloud: Codable {
    let all: Int
}

struct Sys: Codable {
    let country: String
    let sunrise: Date
    let sunset: Date
}
