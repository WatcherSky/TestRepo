//
//  Results.swift
//  TestApp
//
//  Created by Владимир on 01.08.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Results {
    let trackName: String?
    let trackPrice: Double?
    let currency: String?
    let releaseDate: String?
    let artworkUrl60: String?

    init(json: JSON) {
        self.trackName = json["trackName"].stringValue
        self.currency = json["currency"].stringValue
        self.releaseDate = json["releaseDate"].stringValue
        self.artworkUrl60 = json["artworkUrl60"].stringValue
        self.trackPrice = json["trackPrice"].doubleValue
    }
}
