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
        return stack
    }()
    
    var dayLabel: UILabel = {
        let day = LabelConfiguration()
        day.centralized()
    return day
    }()
    
    var hourLabel: UILabel = {
        let hourLabel = LabelConfiguration()
        hourLabel.centralized()
    return hourLabel
    }()
    
    var humidityStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalCentralized()
        return stack
    }()
    
    var humidityImage: UIImageView = {
        let image = ImageConfiguration(frame: .zero)
        image.setImage(image, image: ImageSet.humidity,size: 30, color: Colors.humidy)
        return image
    }()
    
    var percentage: UILabel = {
        let percentage = LabelConfiguration()
        percentage.centralized()
        return percentage
    }()
    
    var maxStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalCentralized()
        return stack
    }()
    
    var maxImage: UIImageView = {
        let maxImage = ImageConfiguration(frame: .zero)
        maxImage.setImage(maxImage, image: ImageSet.thermometer,size: 30,color: Colors.hot)
        return maxImage
    }()
    
    var maxTemp: UILabel = {
        let maxTemp = LabelConfiguration()
        maxTemp.centralized()
        return maxTemp
    }()
    
    var minStack: UIStackView = {
        let stack = StackViewConfiguration()
        stack.verticalCentralized()
        return stack
    }()
    
    var minImage: UIImageView = {
        let minImage = ImageConfiguration(frame: .zero)
        minImage.setImage(minImage, image: ImageSet.thermoterSnow,size: 30,color: Colors.cold)
        return minImage
    }()

    var minTemp: UILabel = {
        let minTemp = LabelConfiguration()
        minTemp.centralized()
        return minTemp
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
        sun.description()
        return sun
    }()
    
    var hourRise: UILabel = {
        let hour = LabelConfiguration()
        hour.centralized()
        return hour
    }()
    
    let sunImage: UIImageView = {
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
        set.description()
        return set
    }()
    
    var hourSet: UILabel = {
        let hour = LabelConfiguration()
        hour.centralized()
        return hour
    }()
    
    let downImage: UIImageView = {
        let down = ImageConfiguration(frame: .zero)
        down.setImage(down, image: ImageSet.sunSet, size: 60, color: Colors.sunSet)
        return down
    }()
    
    func setupData(model: ClimaModel?){
        guard let info = model else {
            return
        }

        dayLabel.text = "\(info.date.formatted(date: .numeric, time: .omitted).dropLast(5))"
        hourLabel.text = info.date.formatted(date: .omitted, time: .shortened)
        percentage.text = "\(info.humidity)%"
        
        switch info.country {
        case "VN", "TH", "PG", "NZ", "MY", "LA", "JP", "ID", "HK", "TW", "PH", "FJ", "KR", "CN", "AU":
            hourRise.text = "\(info.sunDown.formatted(date: .omitted, time: .shortened))"
            hourSet.text = "\(info.sunRise.formatted(date: .omitted, time: .shortened))"
        
        default:
            hourRise.text = "\(info.sunRise.formatted(date: .omitted, time: .shortened))"
            hourSet.text = "\(info.sunDown.formatted(date: .omitted, time: .shortened))"
        }
        maxTemp.text = String(format: "%.1fº", info.temp_max)
        minTemp.text = String(format: "%.1fº", info.temp_min)
        
        sunlabel.text =  clima.titles.sunrisen
       
        setLabel.text = clima.titles.sunSet
    }
}

extension CellView: ViewConfiguration {
    func buildViewHierachy() {
        addSubview(infoView)
        
        infoView.addSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(dateStack)
        dateStack.addArrangedSubview(dayLabel)
        dateStack.addArrangedSubview(hourLabel)
        
        stackViewHorizontal.addArrangedSubview(humidityStack)
        humidityStack.addArrangedSubview(humidityImage)
        humidityStack.addArrangedSubview(percentage)
        
        stackViewHorizontal.addArrangedSubview(maxStack)
        maxStack.addArrangedSubview(maxImage)
        maxStack.addArrangedSubview(maxTemp)
        
        stackViewHorizontal.addArrangedSubview(minStack)
        minStack.addArrangedSubview(minImage)
        minStack.addArrangedSubview(minTemp)
        
        addSubview(climaView)
        climaView.addSubview(climaHorizontalStack)
        
        climaHorizontalStack.addArrangedSubview(sunVerticalStack)
        sunVerticalStack.addArrangedSubview(sunlabel)
        sunVerticalStack.addArrangedSubview(hourRise)
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
