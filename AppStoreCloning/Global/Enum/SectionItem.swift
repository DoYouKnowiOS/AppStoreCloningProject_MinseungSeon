//
//  SectionItem.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/09/26.
//

import Foundation

enum SectionItem {
    case newFindingsSectionItem(title: String)
    case recommendSectionItem(recommendedApplication: RecommendedApplication)
}

extension SectionItem {
    var title: String {
        switch self {
        case .recommendSectionItem(recommendedApplication: let recommendedApplication):
            return recommendedApplication.applicationName
        case .newFindingsSectionItem(title: let title):
            return title
        }
    }
}
