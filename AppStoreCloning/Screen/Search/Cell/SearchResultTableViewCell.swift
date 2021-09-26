//
//  SearchResultTableViewCell.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/09/26.
//

import UIKit

final class SearchResultTableViewCell: UITableViewCell {

    static let identifier = "SearchResultTableViewCell"
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let searchIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ic_search")
        return image
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
        contentView.addSubview(appNameLabel)
        contentView.addSubview(searchIcon)
        contentView.addSubview(separator)
    }
    
    private func autoLayout() {
        appNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        appNameLabel.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 5).isActive = true
        
        searchIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        searchIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
        
        separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    

}
