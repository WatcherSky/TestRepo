//
//  ItemTableViewCell.swift
//  TestApp
//
//  Created by Владимир on 25.06.2022.
//

import UIKit
import Kingfisher

class ItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(resultsFromApi: Results) {
        
        nameLabel.text = resultsFromApi.trackName
        descriptionLabel.text = "Описание отсутствует. На бэке его нет. К сожалению."
        
        if let trackPrice = resultsFromApi.trackPrice, let currency = resultsFromApi.currency {
            priceLabel.text = "\(trackPrice) \(currency)"
        } else {
            priceLabel.text = "No data"
        }
        
        if let urlFromApi = resultsFromApi.artworkUrl60 {
            let url = URL(string: urlFromApi)
            itemImageView.kf.setImage(with: url)
        }
        
        setupDateLabel(resultsFromApi: resultsFromApi)
    }
    
    func setupDateLabel(resultsFromApi: Results) {
        let dateFormatter = ISO8601DateFormatter()
        
        guard let releaseDate = resultsFromApi.releaseDate else {
            return
        }
        guard let getDateFromJson = dateFormatter.date(from: releaseDate) else {
            return
        }
        
        let dateFormatterToChange = DateFormatter()
        dateFormatterToChange.dateFormat = "dd MMMM"
        let changedDateFromJson = dateFormatterToChange.string(from: getDateFromJson)
        dateLabel.text = changedDateFromJson
    }
}
