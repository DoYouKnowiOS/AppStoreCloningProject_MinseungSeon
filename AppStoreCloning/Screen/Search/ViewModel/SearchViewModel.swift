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
    
    struct Input {
        let searchText = BehaviorRelay<String>(value: "")
        let searchNetworkResult = BehaviorRelay<SearchResult>(value: SearchResult(resultCount: 0, results: []))
    }
    struct Output {
        var searchResult: Observable<[String]>
        
        let sections: [MultipleSectionModel] = [
            .newFindingsSection(title: "새로운 발견",
                                items: [
                                    .newFindingsSectionItem(title: "벽돌깨기"),
                                    .newFindingsSectionItem(title: "전광판"),
                                    .newFindingsSectionItem(title: "네모로직"),
                                    .newFindingsSectionItem(title: "타이쿤")
                                ]),
            .recommendSection(title: "추천 앱과 게임",
                              items: [
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!")),
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!")),
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!")),
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!")),
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!")),
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!")),
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!")),
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!")),
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!")),
                                .recommendSectionItem(recommendedApplication: RecommendedApplication(applicationImage: UIImage(named: "applicationImage")!, applicationName: "Bonding: 모임을 즐겁게!", applicationDescription: "모임 시간부터 장소까지 책임지는 신개념 스케쥴링 앱!"))
                              ])
        ]
    }
    
    var input: Input
    var output: Output
    
    private let service = APIService()
    private var disposeBag = DisposeBag()
    
    init() {
        self.input = Input()
        
        let result = self.input.searchNetworkResult
            .map { result in
                result.results.map{ $0.trackName }
            }
        
        self.output = Output(searchResult: result)
        
        self.input.searchText
            .subscribe(onNext: { [weak self] in
                self?.fetchSearchResult(searchText: $0)
            }).disposed(by: disposeBag)
    }
    
    func fetchSearchResult(searchText: String) {
        do {
            try service.getSearchResult(term: searchText, country: "kr", media: "software").subscribe(
                onNext: { [weak self] in
                    self?.input.searchNetworkResult.accept($0)
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
