//
//  ViewModelType.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/08/29.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
