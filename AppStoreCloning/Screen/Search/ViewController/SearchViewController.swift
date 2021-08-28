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
        
        let service = APIService.shared
        do {
            try service.getSearchResult().subscribe(
                onNext: { result in
                    
                    self.response = result
                    //MARK: display in UITableView
                    if let response = self.response {
                        print(response)
                    }
                },
                onError: { error in
                    print(error.localizedDescription)
                },
                onCompleted: {
                    print("Completed event.")
                }).disposed(by: disposeBag)
        }
        catch{
        }
    }
    
}
