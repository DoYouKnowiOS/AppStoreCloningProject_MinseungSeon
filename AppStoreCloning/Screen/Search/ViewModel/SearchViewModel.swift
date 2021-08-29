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
    
    private let service = APIService()
    private var disposeBag = DisposeBag()
    
    init() {
        self.input = Input()
        self.output = Output()
    }
    
    func fetchSearchResult() {
        do {
            try service.getSearchResult(term: "카카오톡", country: "kr", media: "software").subscribe(
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
        catch { print("catch error") }
    }
    
}
