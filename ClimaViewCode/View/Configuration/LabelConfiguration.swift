//
//  UILabelConfiguration.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 24/08/22.
//

import Foundation
import UIKit

class LabelConfiguration: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func centralized() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 21)
        textColor = .black
    }
}
