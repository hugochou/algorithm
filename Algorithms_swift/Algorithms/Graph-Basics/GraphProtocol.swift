//
//  GraphProtocol.swift
//  Algorithms
//
//  Created by Chris on 2017/10/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation


protocol GraphProtocol {
    associatedtype Iterator:GraphIterator
    
    func V() -> Int
    func E() -> Int
    func addEdge(_ v: Int, _ w: Int)
    func hasEdge(_ v: Int, _ w: Int) -> Bool
    func adjIterator(_ v: Int) -> Iterator
}

protocol GraphIterator {
    func begin()
    func next() -> Int?
}
