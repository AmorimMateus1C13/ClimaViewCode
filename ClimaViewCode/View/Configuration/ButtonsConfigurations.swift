//
//  ButtonsConfigurations.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 23/08/22.
//

import Foundation
import UIKit

class ButtonsConfigurations: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func homeSetImage(_ sender: UIButton) {
        var config = UIImage.SymbolConfiguration(hierarchicalColor: .white)
        config = config.applying(UIImage.SymbolConfiguration(pointSize: 50))
        
        if let image = UIImage(systemName: ImageSet.home, withConfiguration: config){
            sender.setImage(image, for: .normal)
            sender.contentMode = .scaleAspectFill

        }
    }
    
//    func homeButton() {
//        print("Go to home")
//    }
//    
//    func locationButton() {
//        print("Get location")
//    }
    
    func locationSetImage(_ sender: UIButton) {
        var config = UIImage.SymbolConfiguration(hierarchicalColor: .white)
        config = config.applying(UIImage.SymbolConfiguration(pointSize: 50))
        if let image = UIImage(systemName: ImageSet.location, withConfiguration:  config) {
            sender.setImage(image, for: .normal)
            sender.contentMode = .scaleAspectFill
        }
    }
}
