//
//  SparesGraph.swift
//  Algorithms
//
//  Created by Chris on 2017/9/28.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//稀疏图 - 邻接表
class SparesGraphW<T: Numeric & Comparable & CustomStringConvertible>:GraphProtocolW {
    
    private var n: Int
    private var m = 0
    private var directed: Bool
    private var graph: [[Edge<T>]]
    
    init(n: Int, directed: Bool) {
        self.n = n
        self.directed = directed
        graph = [[Edge<T>]]()
        for _ in 0 ..< n {
            graph.append([Edge<T>]())
        }
    }
    
    func V() -> Int {
        return n
    }
    
    func E() -> Int {
        return m
    }
    
    //此处不对平行边做处理，因为hasEdge是O(n)复杂度，如果每次addEdge都要检查hasEdge，addEdge也变成O(n)
    typealias Weight = T
    func addEdge(_ v: Int, _ w: Int, weight: T) {
        
        assert(v >= 0 && v < n)
        assert(w >= 0 && w < n)
        
        if !hasEdge(v, w) {
            m += 1
        }
        
        let edge = Edge(a: v, b: w, weight: weight)
        graph[v].append(edge)
        if v != w && !directed {
            graph[w].append(edge)
        }
    }
    
    func hasEdge(_ v: Int, _ w: Int) -> Bool {
        
        assert(v >= 0 && v < n)
        assert(w >= 0 && w < n)
        
        for edge in graph[v] {
            if edge.other(v) == w {
                return true
            }
        }
        return false
    }
    
    func show() {
        for i in 0 ..< n {
            print("\(i):", terminator: "\t")
            let adj = adjIterator(i)
            adj.begin()
            while let edge = adj.next() {
                print("(to:\(edge.other(i)), weight:\(edge.wt().description))", terminator: "\t")
            }
            print()
        }
    }
    
    typealias Iterator = SparesGraphW<T>.AdjacentIterator
    func adjIterator(_ v: Int) -> SparesGraphW<T>.AdjacentIterator {
        return SparesGraphW<T>.AdjacentIterator(graph: self, v: v)
    }
    
    //邻接点的迭代器
    class AdjacentIterator:WeightGraphIterator {
        
        private let graph: SparesGraphW
        private let v: Int
        private var index: Int
        
        init(graph: SparesGraphW, v: Int) {
            self.graph = graph
            self.v = v
            self.index = 0
        }
        
        func begin() {
            index = 0
        }
        
        func next() -> Edge<T>? {
            var res: Edge<T>? = nil
            if index < graph.graph[v].count {
                res = graph.graph[v][index]
                index += 1
            }
            return res
        }
    }
    
    
}


/// 测试邻接点迭代器
///   - n: 顶点数
///   - m: 边数
func testSparesGraphW(_ n: Int, _ m: Int) {
    let graph = SparesGraphW<Int>(n: n, directed: true)
    for _ in 0 ..< m {
        let a = Int(arc4random()) % n
        let b = Int(arc4random()) % n
        let wt = Int(arc4random()) % 100
        graph.addEdge(a, b, weight: wt)
    }
    graph.show()
//    for i in 0 ..< n {
//        print(" \(i): ")
//        let adjIteretor = graph.adjIterator(i)
//        adjIteretor.begin()
//        while let v = adjIteretor.next() {
//            print(v)
//        }
//        print()
//    }
}
