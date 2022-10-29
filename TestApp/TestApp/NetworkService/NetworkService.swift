//
//  NetworkClient.swift
//  TestApp
//
//  Created by Владимир on 30.07.2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

protocol NetworkServiceDelegate: AnyObject {
    func fetchTracks(results: [Results])
}

protocol Service {
    func getTracks(limit: Int, completion: @escaping (Result<[Results], Error>) -> Void)
}

class NetworkService: Service {
    private weak var delegate: NetworkServiceDelegate?

    init(delegate: NetworkServiceDelegate) {
        self.delegate = delegate
    }
    
    func getTracks(limit: Int, completion: @escaping (Result<[Results], Error>) -> Void) {
        fetchTracks(limit: limit) { results in
            switch results {
            case .success(let results):
                self.delegate?.fetchTracks(results: results)
                completion(.success(results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchTracks(limit: Int, completion: @escaping (Result<[Results], Error>) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term":"Never",
                          "limit":"\(limit)",
                          "media":"music"]
        
        Alamofire.AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                completion(.failure(error))
                return
            }
            guard let data = dataResponse.data else { return }
            completion(.success(self.parseJSON(data)))
        }
    }
    
    
    private func parseJSON(_ data: Data) -> [Results] {
        var results = [Results]()

        if let json = try? JSON(data: data) {
            for item in json["results"].arrayValue {
                results.append(Results.init(json: item))
            }
        }
        return results
    }
}
