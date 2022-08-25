//
//  ImageConfiguration.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 23/08/22.
//

import Foundation
import UIKit

class ImageConfiguration: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setImage(_ sender: UIImageView, image: String, style: Bool? = false, size: CGFloat? = nil, color: UIColor? = nil) {
        
      
        var config = UIImage.SymbolConfiguration(hierarchicalColor: .white)

        if let userSize = size {
           config = config.applying(UIImage.SymbolConfiguration(pointSize: userSize))
        }

        if let userColor = color {
            config = config.applying(UIImage.SymbolConfiguration(hierarchicalColor: userColor))
        }
        
        if style == true{
            config = config.applying(UIImage.SymbolConfiguration(weight: .ultraLight))
        }else {
            config = config.applying(UIImage.SymbolConfiguration(weight: .medium))
        }
        

        if let newImage = UIImage(systemName: image, withConfiguration: config) {
            sender.image = newImage
            sender.contentMode = .scaleAspectFit
        }

    }
}
