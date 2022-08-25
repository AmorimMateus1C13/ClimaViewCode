//
//  SearchConfiguration.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 23/08/22.
//

import Foundation
import UIKit

class SearchConfiguration: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration() {
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 30)
        textAlignment = .center
        textColor = .black
        borderStyle = .roundedRect
    }
}
