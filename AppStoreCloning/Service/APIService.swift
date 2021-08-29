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
  static var shared = APIService()
  lazy var requestObservable = RequestObservable(config: .default)
  func getSearchResult() throws -> Observable<SearchResult> {
    var url = URLComponents(string: "https://itunes.apple.com/search")!
    url.queryItems = [
        URLQueryItem(name: "term", value: "카카오톡"),
        URLQueryItem(name: "country", value: "kr"),
        URLQueryItem(name: "media", value: "software")
    ]
    print(url.url)
    var request = URLRequest(url: url.url!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    return requestObservable.callAPI(request: request)
  }
}
