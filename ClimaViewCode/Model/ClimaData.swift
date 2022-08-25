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
    let main: Main
//    let visibility: Int
    let clouds: Cloud
    let dt: Date
    let sys: Sys
    let name: String
}

struct Coord: Codable {
    let lon: CLLocationDegrees
    let lat: CLLocationDegrees
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Double
    let fells_like: Double
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



