//
//  APIService.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/08/28.
//

import Foundation
import RxCocoa
import RxSwift

class APIService {
  lazy var requestObservable = RequestObservable(config: .default)
    
    func getSearchResult(term: String, country: String, media: String) throws -> Observable<SearchResult> {
    var url = URLComponents(string: "https://itunes.apple.com/search")!
    url.queryItems = [
        URLQueryItem(name: "term", value: term),
        URLQueryItem(name: "country", value: country),
        URLQueryItem(name: "media", value: media)
    ]
    var request = URLRequest(url: url.url!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    return requestObservable.callAPI(request: request)
  }
}
