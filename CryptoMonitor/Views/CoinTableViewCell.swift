//
//  CoinTableViewCell.swift
//  CryptoMonitor
//
//  Created by Степан Фоминцев on 09.05.2023.
//

import UIKit

final class CoinTableViewCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet var coinImage: UIImageView!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var changeLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        coinImage.image = nil
    }
    
    // MARK: - Public Methods
    func configure(with coin: Coin) {
        symbolLabel.text = coin.symbol
        nameLabel.text = coin.name
        priceLabel.text = String(format: "%.3f%$", coin.price)
        changeLabel.textColor = coin.priceChange1d > 0 ? .systemGreen : .systemRed
        changeLabel.text = String(format: "%.2f%%", coin.priceChange1d)
        rankLabel.text = coin.rank.formatted()
        
        NetworkManager.shared.fetchImage(from: coin.icon) { [unowned self] result in
            switch result {
            case .success(let imageData):
                coinImage.image = UIImage(data: imageData)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
