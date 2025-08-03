//
//  PaginationModel.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//


import Foundation

public struct PaginationModel<T : Sendable>:Sendable {
    public var page: Int
    public var totalPages: Int
    public var list: [T]
    
    public var nextPage: Int {
        if page == 0 {
            return 1
        } else if page >= totalPages {
            return totalPages
        } else if page < totalPages {
            return page + 1
        } else if list.isEmpty {
            return page
        }
        
        return page
    }
    
    public init(page: Int, totalPages: Int, list: [T]) {
        self.page = page
        self.totalPages = totalPages
        self.list = list
    }
}
