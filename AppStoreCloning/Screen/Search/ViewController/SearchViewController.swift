//
//  SearchViewController.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/08/28.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    let searchViewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    let testLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.fetchSearchResult()
        setLayout()
        bindUI()
    }
    
    func bindUI() {
        searchViewModel.output.searchResult
            .map { "\($0.resultCount)\n\($0.results.description)" }
            .asDriver(onErrorJustReturn: "결과 없음")
            .drive(testLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setLayout() {
        testLabel.text = "결과:"
        view.addSubview(testLabel)
        let safeArea = view.safeAreaLayoutGuide
        let leadingConstraint = testLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16)
        let topConstarint = testLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.numberOfLines = 0
        leadingConstraint.isActive = true
        topConstarint.isActive = true
    }
}

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SearchViewController
    
    func makeUIViewController(context: Context) -> SearchViewController {
        return SearchViewController()
    }
    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}
