//
//  GridCollectionViewCell.swift
//  TestApp
//
//  Created by Владимир on 25.06.2022.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    
    
    func configureCell(text: String) {
        nameLabel.text = text
    }
    
    private func setCell() {
        contentView.layer.cornerRadius = 0.5
        contentView.layer.borderWidth = 0.5
        contentView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
