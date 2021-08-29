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
    var response: SearchResult?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testLabel = UILabel()
        testLabel.text = "결과:"

        view.addSubview(testLabel)
        let safeArea = view.safeAreaLayoutGuide
        let leadingConstraint = testLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16)
        
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        
        print("실행")
        let service = APIService.shared
        do {
            try service.getSearchResult().subscribe(
                onNext: { result in
                    self.response = result
                    //MARK: display
                    if let response = self.response {
                        print(response)
                        
                    }
                },
                onError: { error in
                    print(String(describing: error))
                },
                onCompleted: {
                    print("Completed event.")
                }).disposed(by: disposeBag)
        }
        catch{
        }
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
        Group {
            ViewControllerRepresentable()
            ViewControllerRepresentable()
        }
    }
}
