//
//  SearchViewController.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/08/28.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: Variable
    
    private let searchViewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.setRounded(radius: 18)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let homeContentsTableView: UITableView = {
        let tableview = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableview.backgroundColor = .clear
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.identifier)
        tableview.register(NewFindingsTableViewCell.self, forCellReuseIdentifier: NewFindingsTableViewCell.identifier)
        return tableview
    }()
    
    private let searchResultTableView: UITableView = {
        let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableview.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        return tableview
    }()
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.hidesNavigationBarDuringPresentation = true
        return searchController
    }()
    
    private var searchBar: UISearchBar { return searchController.searchBar }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setDataSource()
        setProperty()
        autolayout()
        bindUI()
        setNavigation()
    }
    
    // MARK: Function
    
    func bindUI() {
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .do(onNext:{
                if $0.count > 0 {
                    self.searchResultTableView.isHidden = false
                } else {
                    self.searchResultTableView.isHidden = true
                }
            })
            .bind(to: searchViewModel.input.searchText)
            .disposed(by: disposeBag)
        
        searchViewModel.output.searchResult
            .asDriver(onErrorJustReturn: [])
                .drive(searchResultTableView.rx.items) { tableView, indexPath, item in
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier) as? SearchResultTableViewCell else { return UITableViewCell() }
                    cell.appNameLabel.text = item
                    return cell
                }
                .disposed(by: disposeBag)
        
        searchResultTableView.rx.modelSelected(String.self)
            .subscribe(onNext:{ appName in
                print(appName)
                // 일단 String 값 프린트 되게 했는데.. 아예 여기 searchResult array 에 정보 전부다 가지고 있게 하는게 편하려나요..? 눌렀을 때 디테일뷰로 바로 가야하니까!
            })
            .disposed(by: disposeBag)
        
        homeContentsTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                switch indexPath.section {
                case 0:
                    let text = self.searchViewModel.output.sections[0].items[indexPath.row].title
                    self.searchBar.becomeFirstResponder()
                    self.searchBar.text = text
                    self.searchViewModel.input.searchText.accept(text)
                    self.searchResultTableView.isHidden = false
                case 1:
                    print("\(self.searchViewModel.output.sections[1].items[indexPath.row].title)")
                default:
                    return
                }
                
            })
            .disposed(by: disposeBag)
    }
    
    func autolayout() {
        // large title 옆 이미지 넣는 방법 3번
        //        guard let navigationBar = self.navigationController?.navigationBar else { return }
        //        navigationBar.addSubview(imageView)
        //        imageView.rightAnchor.constraint(equalTo: (navigationBar.rightAnchor), constant: -15).isActive = true
        //        imageView.bottomAnchor.constraint(equalTo: (navigationBar.bottomAnchor), constant: -60).isActive = true
        //        imageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        //        imageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        //
        
        view.addSubview(homeContentsTableView)
        homeContentsTableView.topAnchor.constraint(equalTo:view.topAnchor, constant: 10).isActive = true
        homeContentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeContentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        homeContentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(searchResultTableView)
        searchResultTableView.isHidden = true
    }
    private func setNavigation() {
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = "Search"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        // large title 옆 이미지 넣는 방법 1번
        //        navigationController?.navigationBar.subviews.forEach { subview in
        //                    let stringFromClass = NSStringFromClass(subview.classForCoder)
        //            print(stringFromClass);
        //            guard stringFromClass.contains("_UINavigationBarContentView") else { return }
        //                    subview.subviews.forEach { label in
        //                        print("--\(label)")
        //                        guard label is UILabel else { return }
        //                        subview.addSubview(imageView)
        //
        //                        NSLayoutConstraint.activate([
        //                            imageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
        //                            imageView.widthAnchor.constraint(equalToConstant: 40),
        //                            imageView.heightAnchor.constraint(equalToConstant: 40),
        //                            imageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20)
        //                        ])
        //                    }
        //                }
    }
    private func setDataSource() {
        let dataSource = SearchViewController.dataSource()
        Observable.just(searchViewModel.output.sections)
            .bind(to: homeContentsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func setProperty() {
        homeContentsTableView.separatorStyle = .none
        homeContentsTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        searchResultTableView.dataSource = nil
        searchResultTableView.rowHeight = 40
    }
}

extension SearchViewController {
    static func dataSource() -> RxTableViewSectionedReloadDataSource<MultipleSectionModel> {
        return RxTableViewSectionedReloadDataSource<MultipleSectionModel>(
            configureCell: { dataSource, table, indexPath, _ in
                switch dataSource[indexPath] {
                case let .newFindingsSectionItem(title):
                    let cell: NewFindingsTableViewCell = table.dequeueReusableCell(withIdentifier: NewFindingsTableViewCell.identifier, for: indexPath) as! NewFindingsTableViewCell
                    cell.selectionStyle = .none
                    cell.appNameLabel.text = title
                    return cell
                case let .recommendSectionItem(recommendedApplication):
                    let cell = table.dequeueReusableCell(withIdentifier: RecommendTableViewCell.identifier, for: indexPath) as! RecommendTableViewCell
                    cell.selectionStyle = .none
                    cell.appImage.image = recommendedApplication.applicationImage
                    cell.appNameLabel.text = recommendedApplication.applicationName
                    cell.appDescriptionLabel.text = recommendedApplication.applicationDescription
                    return cell
                }
            },
            titleForHeaderInSection: { dataSource, index in
                let section = dataSource[index]
                return section.title
            }
        )
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 43
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,y: 0, width: view.bounds.width, height: 48))
        headerView.backgroundColor = .white
        let label =  UILabel()
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        if section == 0 {
            label.text = "새로운 발견"
        } else {
            label.text = "추천 앱과 게임"
        }
        label.textColor = .black
        label.font =  .systemFont(ofSize: 22, weight: .bold)
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 18).isActive = true
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(separator)
        separator.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 17).isActive = true
        separator.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -17).isActive = true
        separator.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
}
