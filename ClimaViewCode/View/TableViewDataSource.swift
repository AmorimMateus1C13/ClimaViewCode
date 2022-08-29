//
//  TableViewDataSource.swift
//  ClimaViewCode
//
//  Created by Mateus Amorim on 23/08/22.
//

import Foundation
import UIKit
class TableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var climaModel: ClimaModel?
    
    let tableView: UITableView
    
    init(tableview: UITableView) {
        self.tableView = tableview
        super.init()
        register(tableView: tableview)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.isUserInteractionEnabled = false
        tableview.separatorStyle = .none
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    
    func updateCells(_ data: ClimaModel) {
        self.climaModel = data
        tableView.reloadData()
    }
    
    func register(tableView: UITableView) {
        tableView.register(CellView.self, forCellReuseIdentifier: CellView.identifier())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellView.identifier(), for: indexPath) as? CellView else{ return UITableViewCell()}
        
        cell.setupData(model: climaModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
