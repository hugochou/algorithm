//
//  GraphProtocol.swift
//  Algorithms
//
//  Created by Chris on 2017/10/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation


protocol GraphProtocolW {
    associatedtype Iterator:WeightGraphIterator
    associatedtype Weight //此处不要加类型约束，以便在 ReadGraphW 中进行类型转换
    
    func V() -> Int //获取顶点数
    func E() -> Int //获取边数
    func addEdge(_ v: Int, _ w: Int, weight: Weight)
    func hasEdge(_ v: Int, _ w: Int) -> Bool
    func adjIterator(_ v: Int) -> Iterator
}



protocol WeightGraphIterator {
    associatedtype Weight: Numeric,Comparable,CustomStringConvertible
    func begin()
    func next() -> Edge<Weight>?
}

protocol Calculable {
    init() 
    static func + (l: Self, r: Self) -> Self
    static func - (l: Self, r: Self) -> Self
    static func * (l: Self, r: Self) -> Self
    static func / (l: Self, r: Self) -> Self
//    static func += (l: inout Self, r: Self) -> Self
//    static func -= (l: inout Self, r: Self) -> Self
//    static func *= (l: inout Self, r: Self) -> Self
//    static func /= (l: inout Self, r: Self) -> Self
}

extension Double : Calculable {}
extension Float  : Calculable {}
extension Int    : Calculable {}

