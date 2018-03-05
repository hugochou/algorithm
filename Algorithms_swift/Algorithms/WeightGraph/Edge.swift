//
//  Edge.swift
//  Algorithms
//
//  Created by Chris on 2017/10/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//有权图的边
struct Edge<T: Numeric & Comparable & CustomStringConvertible>:Comparable {
    private let a: Int!
    private let b: Int!
    private let weight: T
    
    init(a: Int, b: Int, weight: T) {
        self.a = a
        self.b = b
        self.weight = weight
    }
    
//    init() {
//        a = -1
//        b = -1
//        weight = nil
//    }
    
    func v() -> Int {
        return a
    }
    
    func w() -> Int {
        return b
    }
    
    func wt() -> T {
        return weight
    }
    
    func other(_ x: Int) -> Int {
        assert( x == a || x == b)
        return x == a ? b:a
    }
    
    func description() -> String {
        let wt = weight.description
        return "\(a)-\(b): \(wt)"
    }
    
    static public func < (left: Edge, right: Edge) -> Bool {
        return left.wt() < right.wt()
    }
    
    static public func == (left: Edge, right: Edge) -> Bool {
        return left.wt() == right.wt()
    }
}
