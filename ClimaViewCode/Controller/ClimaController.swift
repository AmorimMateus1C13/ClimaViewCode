//
//  ClimaController.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 23/08/22.
//

import UIKit
import SnapKit
import CoreLocation

class ClimaController: UIViewController {
    
    var climaView = ClimaView()
    
    var apiManager = APIManager()
    let locationManager = CLLocationManager()
    var model: ClimaModel?
    
    func setupModel(model: ClimaModel) {
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        apiManager.delegate = self
        
        climaView.delegate = self
        climaView.searchTextField.delegate = self
        
        view.addSubview(climaView)
        makeConstraints()
    }
    
    func makeConstraints() {
        climaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension ClimaController: ClimaDelegate {
    func didUpdateClima(requistor: APIManager, conditions: ClimaModel) {
        print("oi")
        DispatchQueue.main.async {
            self.climaView.cloudImage.image = UIImage(systemName: conditions.conditionName)
            self.climaView.climaLabel.text = conditions.conditionName
            self.climaView.temperatureLabel.text = conditions.temperatureString
            self.climaView.cityLabel.text = conditions.cityName.capitalized
            
//            self.tableview.reloadData()
        }
    }

    func didFailWithError(error: Error) {
        print("Problemas com o DidFailWithError. Erro: \(error)")
    }

}

extension ClimaController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            apiManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro de domínio ao usar o Simulador do Xcode sem ter um local definido no simulador\(error)")
    }
}

extension ClimaController: CatchLocation{
    func getCurrentLocation() {
        DispatchQueue.main.async {
            self.locationManager.requestLocation()
        }
    }
    
    func getCityLocation() {
        print("get location")
        if let text = climaView.searchTextField.text {
            DispatchQueue.main.async {
                self.apiManager.fetchCity(city: text)
            }
        }
       
    }
}

extension ClimaController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else {
            textField.placeholder = "type something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text{
            apiManager.fetchCity(city: city)
        }
        textField.text = ""
    }

}

