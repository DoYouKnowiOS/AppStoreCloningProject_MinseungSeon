//
//  SearchViewModel.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/08/29.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModelType {
    struct Input {}
    struct Output {
        let searchResult = BehaviorRelay<SearchResult>(value: SearchResult(resultCount: 0, results: []))
    }
    
    var input: Input
    var output: Output
    
    let service = APIService.shared
    var disposeBag = DisposeBag()
    
    init() {
        self.input = Input()
        self.output = Output()
    }
    
    func fetchSearchResult() {
        do {
            try service.getSearchResult().subscribe(
                onNext: { [weak self] in
                    self?.output.searchResult.accept($0)
                },
                onError: { error in
                    print(String(describing: error))
                },
                onCompleted: {
                    print("Completed event.")
                }).disposed(by: disposeBag)
        }
        catch { }
    }
    
}
