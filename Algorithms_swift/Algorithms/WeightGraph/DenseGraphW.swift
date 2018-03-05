//
//  DenseGraph.swift
//  Algorithms
//
//  Created by Chris on 2017/9/28.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//有权稠密图 - 邻接矩阵
class DenseGraphW<T: Numeric & Comparable & CustomStringConvertible>:GraphProtocolW {
    private var n: Int //顶点数
    private var m = 0 //边数
    private var directed: Bool
    private var graph: [[Edge<T>?]]
    
    init(n: Int, directed: Bool) {
        self.n = n
        self.directed = directed
        graph = [[Edge<T>]]()
        for _ in 0 ..< n {
            graph.append([Edge<T>?](repeatElement(nil, count: n)))
        }
    }
    
    func V() -> Int {
        return n
    }
    
    func E() -> Int {
        return m
    }
    
    typealias Weight = T
    func addEdge(_ v: Int, _ w: Int, weight: T) {
        
        assert(v >= 0 && v < n)
        assert(w >= 0 && w < n)
        
        if !hasEdge(v, w) {
            m += 1
        }
        
        let edge = Edge<T>(a: v, b: w, weight: weight)
        graph[v][w] = edge

        if !directed{
            graph[w][v] = edge
        }
    }
    
    func hasEdge(_ v: Int, _ w: Int) -> Bool {
        
        assert(v >= 0 && v < n)
        assert(w >= 0 && w < n)
        
        return graph[v][w]!.v() != -1
    }
    
    func show() {
        print("\t", terminator: "")
        for i in 0 ..< n {
            print(i, terminator: "\t\t")
        }
        print()
        for i in 0 ..< n {
            print(i, terminator: "\t")
            for j in 0 ..< n {
                let wt = graph[i][j]!.wt().description
                print(wt, terminator: wt.count < 4 ? "\t\t":"\t")
            }
            print()
        }
    }
    
    typealias Iterator = DenseGraphW<T>.AdjacentIterator
    func adjIterator(_ v: Int) -> DenseGraphW<T>.AdjacentIterator {
        return DenseGraphW<T>.AdjacentIterator(graph: self, v: v)
    }
    
    //邻接点迭代器
    class AdjacentIterator:WeightGraphIterator {
        
        private let graph: DenseGraphW
        private let v: Int
        private var index = 0
        
        init(graph: DenseGraphW, v: Int) {
            self.graph = graph
            self.v = v
        }
        
        func begin(){
            index = 0
        }
        
        func next() -> Edge<T>? {

            while index < graph.V() && !graph.hasEdge(v, index) {
                index += 1
            }
            let res = index < graph.V() ? graph.graph[v][index] : nil
            index += 1
            return res
        }
    }
}


/// 测试邻接点迭代器
///   - n: 顶点数
///   - m: 边数
func testDenseGraphW(_ n: Int, _ m: Int) {
    let graph = DenseGraphW<Int>(n: n, directed: false)
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
