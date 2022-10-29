//
//  MainViewController.swift
//  TestApp
//
//  Created by Владимир on 26.06.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    
    var networkService: Service!
    private let sections: [Section] = [.menu(1, 110, 0),
                                       .grid(1, 160, 4),
                                       .table(nil, 290, 0)]
    private var results = [Results]()
    private var itemsShows = 10
    //MARK: - ViewController life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNetworkService()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.networkService = NetworkService(delegate: self)
    }

    //MARK: - Methods
    func setupTableView() {
        tableView.sectionHeaderTopPadding = 0
        
        tableView.registerCell(MenuTableViewCell.self)
        tableView.registerCell(GridTableViewCell.self)
        tableView.registerCell(ItemTableViewCell.self)
    }
    
    private func setupNetworkService() {
        networkService.getTracks(limit: itemsShows) { results in
            switch results {
            case .success(let results):
                self.results = results
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - NetworkServiceProtocol
extension MainViewController: NetworkServiceDelegate {
    func fetchTracks(results: [Results]) {
        self.results = results
        self.tableView.reloadData()
    }
}

// MARK: - TableViewDelegate and DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .menu(let count, _, _):
            return count
        case .grid(let count, _, _):
            return count
        case .table:
            return results.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
        case .menu(_, let menuHeight, _):
            return menuHeight
        case .grid(_, let gridHeight, _):
            return gridHeight
        case .table(_, let tableHeight, _):
            return tableHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .menu:
            let cell = tableView.dequeueCell(MenuTableViewCell.self, for: indexPath)
            return cell
        case .grid:
            let cell = tableView.dequeueCell(GridTableViewCell.self, for: indexPath)
            return cell
        case .table:
            let cell = tableView.dequeueCell(ItemTableViewCell.self, for: indexPath)
            cell.configureCell(resultsFromApi: results[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        
        switch section {
        case .grid(_, _, let headerHeight):
            return headerHeight
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == results.count - 2 && results.count < 40 {
            itemsShows += 10
            setupNetworkService()
        }
    }
}
