//
//  APIManager.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 25/08/22.
//

import Foundation
import CoreLocation

protocol ClimaDelegate {
    func didUpdateClima(requistor: APIManager, conditions: ClimaModel)
    func didFailWithError(error: Error)
}

struct APIManager {
    
    let url = "https://api.openweathermap.org/data/2.5/weather?"
    let apiKey = "&appid=6be4196a200227d2702148c5e6a27cc0"
    let units = "&units=metric"
    let language = "&lang=pt_br"
    var delegate: ClimaDelegate?
    
    func fetchCity(city: String) {
        var cityTrimSpaces =  city.replacingOccurrences(of: " ", with: "%20")
        cityTrimSpaces = cityTrimSpaces.applyingTransform(.stripDiacritics, reverse: false)!
        let urlCity = "\(url+apiKey+units+language)&q=\(cityTrimSpaces)"
        performRequest(with: urlCity)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
       let urlString = "\(url)\(apiKey)\(units)\(language)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    print("Problemas com o PerformRequest. Erro: \(error!)")
                    return
                }
                if let safeData = data {
                    if let clima = self.parsonJSON(clima: safeData){
                        DispatchQueue.main.async {
                            
                            ClimaController().setupModel(model: clima)
                            self.delegate?.didUpdateClima(requistor: self, conditions: clima)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parsonJSON(clima: Data) -> ClimaModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ClimaData.self, from: clima)
            let country = decodedData.sys.country
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let descricao = decodedData.weather[0].description
            let cloud = decodedData.clouds.all
            let date = decodedData.dt
            let sunRise = decodedData.sys.sunrise
            let sunDown = decodedData.sys.sunset
            let min = decodedData.main.temp_min
            let max = decodedData.main.temp_max
            let hum = decodedData.main.humidity
            let climaWether = ClimaModel(
                conditionId: id,
                cityName: name,
                temperature: temp,
                description: descricao,
                cloud: cloud,
                date: date,
                sunRise: sunRise,
                sunDown: sunDown,
                temp_min: min,
                temp_max: max,
                humidity: hum,
                country: country
            )
            return climaWether
            
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
