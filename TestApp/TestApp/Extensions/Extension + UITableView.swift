//
//  Extension + UITableView.swift
//  TestApp
//
//  Created by Владимир on 13.08.2022.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        let nibName = String(describing: cellClass.self)
        let cellId = String(describing: cellClass.self)
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func dequeueCell<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let cellId = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! T
    }
}


