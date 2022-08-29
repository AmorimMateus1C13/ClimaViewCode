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
    
    func temperature() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 30)
        textColor = .white
    }
    
    func centralized() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 21)
        textColor = .white
        numberOfLines = 0
    }
    
    func description() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 14)
        textColor = .white
        numberOfLines = 0
    }
    
    func errorLabel() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 15)
        textColor = .red
        numberOfLines = 1
        text = "Cidade não encontrada! Verifique a digitação."
        backgroundColor = .systemFill
    }
}
