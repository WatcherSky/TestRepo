//
//  Extensions + CollectionView.swift
//  TestApp
//
//  Created by Владимир on 18.08.2022.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let nibName = String(describing: cellClass.self)
        let cellId = String(describing: cellClass.self)
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    func dequeueCell<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let cellId = String(describing: T.self)
        return self.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! T
    }
}
