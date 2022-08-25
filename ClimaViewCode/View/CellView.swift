//
//  CellView.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 23/08/22.
//

import Foundation
import UIKit

class CellView: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConfiguration()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func identifier() -> String {
        "CellView"
    }
    
    var infoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemFill
        return view
    }()
    
    var climaView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemFill
        return view
    }()
    
    // MARK: - StackView
    
    var dateStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalCentralized()
        
        var dayLabel = LabelConfiguration()
        dayLabel.centralized()
        dayLabel.text = "31/DEZ"
        
        var hourLabel = LabelConfiguration()
        hourLabel.centralized()
        hourLabel.text = "12:00"
        
        stack.addArrangedSubview(dayLabel)
        stack.addArrangedSubview(hourLabel)
        
        return stack
    }()
    
    var humidityStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalCentralized()
        
        var humidityImage = ImageConfiguration(frame: .zero)
        humidityImage.setImage(humidityImage, image: ImageSet.humidity,size: 30)
        
        var percentage = LabelConfiguration()
        percentage.centralized()
        percentage.text = "100%"
        
        stack.addArrangedSubview(humidityImage)
        stack.addArrangedSubview(percentage)
        
        return stack
    }()
    
    var maxStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalCentralized()
        
        var maxImage = ImageConfiguration(frame: .zero)
        maxImage.setImage(maxImage, image: ImageSet.thermometer,size: 30)
        
        var maxTemp = LabelConfiguration()
        maxTemp.centralized()
        maxTemp.text = "0º"
        
        stack.addArrangedSubview(maxImage)
        stack.addArrangedSubview(maxTemp)
        
        return stack
    }()
    
    var minStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalCentralized()
        
        var minImage = ImageConfiguration(frame: .zero)
        minImage.setImage(minImage, image: ImageSet.thermoterSnow,size: 30)
        
        var minTemp = LabelConfiguration()
        minTemp.centralized()
        minTemp.text = "100º"
        
        stack.addArrangedSubview(minImage)
        stack.addArrangedSubview(minTemp)
        
        return stack
    }()
    
    // MARK: - View
    
    var stackViewHorizontal: UIStackView = {
        let stack = StackViewConfiguration()
        stack.cellHorizontalConfig()
        return stack
    }()
    
    var climaHorizontalStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.cellHorizontalConfig()
        return stack
    }()
    
    
    var sunVerticalStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalCentralized()
        return stack
    }()
    
    var sunlabel: UILabel = {
        let sun = LabelConfiguration()
        sun.text = "sun"
        sun.centralized()
        return sun
    }()
    
    var hour: UILabel = {
        let hour = LabelConfiguration()
        hour.text = "hour"
        hour.centralized()
        return hour
    }()
    
    var sunImage: UIImageView = {
        let sun = ImageConfiguration(frame: .zero)
        sun.setImage(sun, image: ImageSet.sunRise, size: 60, color: .yellow)
        return sun
    }()

    
    
    var setVerticalStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalCentralized()
        return stack
    }()
    
    var setLabel: UILabel = {
        let set = LabelConfiguration()
        set.text = "SunSet"
        set.centralized()
        return set
    }()
    
    var hourSet: UILabel = {
        let hour = LabelConfiguration()
        hour.text = "hour"
        hour.centralized()
        return hour
    }()
    
    var downImage: UIImageView = {
        let down = ImageConfiguration(frame: .zero)
        down.setImage(down, image: ImageSet.sunSet, size: 60, color: .orange)
        return down
    }()
    

    
}

extension CellView: ViewConfiguration {
    func buildViewHierachy() {
        addSubview(infoView)
        infoView.addSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(dateStack)
        stackViewHorizontal.addArrangedSubview(humidityStack)
        stackViewHorizontal.addArrangedSubview(maxStack)
        stackViewHorizontal.addArrangedSubview(minStack)
        
        addSubview(climaView)
        climaView.addSubview(climaHorizontalStack)
        
        climaHorizontalStack.addArrangedSubview(sunVerticalStack)
        sunVerticalStack.addArrangedSubview(sunlabel)
        sunVerticalStack.addArrangedSubview(hour)
        sunVerticalStack.addArrangedSubview(sunImage)
        
        climaHorizontalStack.addArrangedSubview(setVerticalStack)
        
        setVerticalStack.addArrangedSubview(setLabel)
        setVerticalStack.addArrangedSubview(hourSet)
        setVerticalStack.addArrangedSubview(downImage)
        
    }
    
    func setupConstrants() {
        infoView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(120)
        }
        
        stackViewHorizontal.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        climaView.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(120)
        }
        
        climaHorizontalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
