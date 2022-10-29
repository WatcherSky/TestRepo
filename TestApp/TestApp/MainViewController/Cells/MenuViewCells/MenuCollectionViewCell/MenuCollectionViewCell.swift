//
//  MenuCollectionViewCell.swift
//  TestApp
//
//  Created by Владимир on 25.06.2022.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCell()
    }
    
    func setCell() {
        imageView.layer.cornerRadius = 2
        imageView.layer.borderWidth = 6
        imageView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    }
}
