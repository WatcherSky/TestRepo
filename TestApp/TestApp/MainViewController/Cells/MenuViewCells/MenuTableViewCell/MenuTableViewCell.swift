//
//  MenuTableViewCell.swift
//  TestApp
//
//  Created by Владимир on 26.06.2022.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    private let squareitemSide = 110
    private let itemNames = ["k_letter","z_letter"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.registerCell(MenuCollectionViewCell.self)
    }
}

extension MenuTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(MenuCollectionViewCell.self, for: indexPath)
        cell.imageView.image = UIImage(named: itemNames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: squareitemSide, height: squareitemSide)
    }
}
