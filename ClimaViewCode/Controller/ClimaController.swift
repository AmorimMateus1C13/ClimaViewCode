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
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
            indicator.style = .large
            indicator.color = .white
            indicator.startAnimating()
            indicator.autoresizingMask = [
                .flexibleLeftMargin, .flexibleRightMargin,
                .flexibleTopMargin, .flexibleBottomMargin
            ]
            return indicator
       }()
       
       var blurEffectView: UIVisualEffectView = {
           let blurEffect = UIBlurEffect(style: .dark)
           let blurEffectView = UIVisualEffectView(effect: blurEffect)
           
           blurEffectView.alpha = 0.8
           blurEffectView.autoresizingMask = [
               .flexibleWidth, .flexibleHeight
           ]
           return blurEffectView
       }()
    
    var climaView = ClimaView()
    var apiManager = APIManager()
    let locationManager = CLLocationManager()
    var model: ClimaModel?
    
    func setupModel(model: ClimaModel) {
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        loadIconAppear()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        apiManager.delegate = self
        climaView.loadingDelegate = self
        climaView.delegate = self
        climaView.searchTextField.delegate = self
    }
    
    func makeConstraints() {
        climaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func warningForUserDisappear() {
        DispatchQueue.main.async {
            self.climaView.infoLabel.isHidden = false
            self.loadIconDisappear()
            lazy var index = 1.0
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
                index += -0.1
                self.climaView.infoLabel.alpha = index
                if index <= 0 {
                    Timer.invalidate()
                    self.climaView.infoLabel.isHidden = true
                }
            }
        }
    }
}

extension ClimaController: ClimaDelegate {
    func didUpdateClima(requistor: APIManager, conditions: ClimaModel)   {
        loadIconDisappear()
        DispatchQueue.main.async {
            self.climaView.cloudImage.setImage(self.climaView.cloudImage, image: conditions.conditionName)
            self.climaView.climaLabel.text = conditions.description.capitalized
            self.climaView.temperatureLabel.text = "\(conditions.temperatureString)º"
            self.climaView.cityLabel.text = conditions.cityName.capitalized
            self.climaView.tableViewDataSource.updateCells(conditions)
        }
    }

    func didFailWithError(error: Error) {
        warningForUserDisappear()
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
        loadIconAppear()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text{
            apiManager.fetchCity(city: city)
        }
        textField.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        climaView.searchTextField.resignFirstResponder()
    }
}

extension ClimaController: LoadingScreen {
    
    func loadIconAppear() {
        DispatchQueue.main.async {
            self.climaView.infoLabel.isHidden = true
            self.climaView.removeFromSuperview()
            self.blurEffectView.frame = self.view.bounds
            self.view.insertSubview(self.blurEffectView, at: 0)
            
            self.loadingActivityIndicator.center = CGPoint(
                x: self.view.bounds.midX,
                y: self.view.bounds.midY
            )
            self.view.addSubview(self.loadingActivityIndicator)
            self.loadingActivityIndicator.startAnimating()
        }
    }
    
    func loadIconDisappear() {
        DispatchQueue.main.async {
            self.loadingActivityIndicator.stopAnimating()
            self.loadingActivityIndicator.removeFromSuperview()
            self.blurEffectView.removeFromSuperview()
            self.view.addSubview(self.climaView)
            self.makeConstraints()
        }
    }
}
