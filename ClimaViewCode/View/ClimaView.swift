//
//  ClimaView.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 23/08/22.
//

import UIKit
import SnapKit

protocol CatchLocation{
    func getCurrentLocation()
    func getCityLocation()
}


class ClimaView: UIView {
    var delegate: CatchLocation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.background
        setupConfiguration()
        tableViewDataSource.reload()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var homeButton: UIButton = {
        let button = ButtonsConfigurations()
        button.homeSetImage(button)
        button.addTarget(self, action: #selector(homebuttonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func homebuttonPressed() {
        delegate?.getCurrentLocation()
    }
    
     var locationButton: UIButton = {
        let button = ButtonsConfigurations()
         button.locationSetImage(button)
         button.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func locationButtonPressed() {
        delegate?.getCityLocation()
    }
    
     var searchTextField: UITextField = {
        let search = SearchConfiguration()
        search.configuration()
        return search
    }()
    
     var temperatureLabel: UILabel = {
         let temp = LabelConfiguration()
         temp.centralized()
         temp.text = "19º"
        return temp
    }()
    
    var cityLabel: UILabel = {
        let city = LabelConfiguration()
        city.centralized()
        city.text = "Brasil"
        return city
    }()
    
     var climaLabel: UILabel = {
        let label = LabelConfiguration()
         label.centralized()
         label.text = "Nublado"
        return label
    }()
    
    
    var cloudImage: UIImageView = {
        let cloud = ImageConfiguration(frame: .zero)
        cloud.setImage(cloud, image: ImageSet.cloud, style: true)
        return cloud
    }()
    
    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        return tableview
    }()
    
    lazy var tableViewDataSource = TableViewDataSource(tableview: tableView)
    
    var stackViewHorizontal: UIStackView = {
        let stack = StackViewConfiguration()
        stack.horizontalConfiguration()
        return stack
    }()
    
    var stackViewVertical: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalConfiguration()
        return stack
    }()
    
}

extension ClimaView: ViewConfiguration {
    func buildViewHierachy() {
        addSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(homeButton)
        stackViewHorizontal.addArrangedSubview(searchTextField)
        stackViewHorizontal.addArrangedSubview(locationButton)
        
        addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(temperatureLabel)
        stackViewVertical.addArrangedSubview(cityLabel)
        stackViewVertical.addArrangedSubview(climaLabel)
        
        addSubview(cloudImage)
        
        addSubview(tableView)
        
        
    }
    
    func setupConstrants() {
        stackViewHorizontal.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.trailing.leading.equalToSuperview().inset(16)
        }
        
        homeButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        stackViewVertical.snp.makeConstraints { make in
            make.height.width.equalTo(150)
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(stackViewHorizontal.snp.bottom).offset(50)
        }
        temperatureLabel.snp.makeConstraints { make in
            make.height.equalTo(75)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        
        cloudImage.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(75)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(stackViewHorizontal.snp.bottom).offset(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview().inset(16)
            make.top.equalTo(stackViewVertical.snp.bottom).offset(16)
        }
    }
}


