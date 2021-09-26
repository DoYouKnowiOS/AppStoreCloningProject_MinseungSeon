//
//  RecommendTableViewCell.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/09/25.
//

import UIKit

final class RecommendTableViewCell: UITableViewCell {
    
    static let identifier = "RecommendTableViewCell"
    
    private let purchaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("받기", for: .normal)
        button.setRounded(radius: 14)
        button.backgroundColor = .systemGroupedBackground
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    let appImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setRounded(radius: 13)
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.borderWidth = 0.2
        return image
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private let appPurchaseDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "앱 내 구입"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 8)
        return label
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubview(appImage)
        contentView.addSubview(purchaseButton)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appDescriptionLabel)
        contentView.addSubview(appPurchaseDescriptionLabel)
        contentView.addSubview(separator)
    }
    
    private func autoLayout() {
        purchaseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        purchaseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        purchaseButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        appImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        appImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        appImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive  = true
        appImage.widthAnchor.constraint(equalTo: appImage.heightAnchor, multiplier: 1).isActive = true
        
        appNameLabel.leadingAnchor.constraint(equalTo: appImage.trailingAnchor, constant: 10).isActive = true
        appNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: purchaseButton.leadingAnchor, constant: -10).isActive = true
        appNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        
        appDescriptionLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 3).isActive = true
        appDescriptionLabel.leadingAnchor.constraint(equalTo: appNameLabel.leadingAnchor).isActive = true
        appDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: purchaseButton.leadingAnchor, constant: -10).isActive = true
        
        appPurchaseDescriptionLabel.topAnchor.constraint(equalTo: purchaseButton.bottomAnchor, constant: 5).isActive = true
        appPurchaseDescriptionLabel.centerXAnchor.constraint(equalTo: purchaseButton.centerXAnchor).isActive = true
        
        separator.leadingAnchor.constraint(equalTo: appImage.trailingAnchor, constant: 7).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17).isActive = true
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
