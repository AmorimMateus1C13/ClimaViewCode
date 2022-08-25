//
//  StackViewConfiguration.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 23/08/22.
//

import Foundation
import UIKit

class StackViewConfiguration: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func horizontalConfiguration() {
        axis = .horizontal
        distribution = .fill
        alignment = .fill
        spacing = 5
    }
    
    func verticalConfiguration() {
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 1
    }
    
    func cellHorizontalConfig() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        spacing = 5
    }
    
    func equalSpacing() {
        axis = .vertical
        distribution = .equalSpacing
        alignment = .fill
        spacing = 5
    }
    
    func verticalCentralized() {
        axis = .vertical
        distribution = .fillEqually
        alignment = .center
        spacing = 1
    }
}
