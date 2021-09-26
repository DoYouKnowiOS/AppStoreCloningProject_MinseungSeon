//
//  MultipleSectionModel.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/09/26.
//

import Foundation
import RxDataSources

enum MultipleSectionModel {
    case newFindingsSection(title: String, items: [SectionItem])
    case recommendSection(title: String, items: [SectionItem])
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch self {
        case .newFindingsSection(title: _, items: let items):
            return items.map { $0 }
        case .recommendSection(title: _, items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: MultipleSectionModel, items: [SectionItem]) {
        switch original {
        case let .newFindingsSection(title: title, items: _):
            self = .newFindingsSection(title: title, items: items)
        case let .recommendSection(title: title, items: _):
            self = .recommendSection(title: title, items: items)
        }
    }
}

extension MultipleSectionModel {
    var title: String {
        switch self {
        case .recommendSection(title: let title, items: _):
            return title
        case .newFindingsSection(title: let title, items: _):
            return title
        }
    }
}
