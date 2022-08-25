//
//  ViewConfiguration.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 23/08/22.
//

import Foundation

protocol ViewConfiguration {
    func setupConfiguration()
    func buildViewHierachy()
    func setupConstrants()
}

extension ViewConfiguration {
    func setupConfiguration() {
        buildViewHierachy()
        setupConstrants()
    }
}
