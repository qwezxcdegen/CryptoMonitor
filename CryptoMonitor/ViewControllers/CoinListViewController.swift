//
//  CoinListViewController.swift
//  CryptoMonitor
//
//  Created by Степан Фоминцев on 09.05.2023.
//

import UIKit

class CoinListViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var coins: [Coin] = []
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoins()
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)
        guard let cell = cell as? CoinTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: coins[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}

// MARK: - Fetch Methods
private extension CoinListViewController {
    func fetchCoins() {
        networkManager.fetch(CoinData.self, url: coinsURL) { [weak self] result in
            switch result {
            case .success(let coinsData):
                coinsData.coins.forEach { self?.coins.append($0) }
                self?.tableView.reloadData()
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
