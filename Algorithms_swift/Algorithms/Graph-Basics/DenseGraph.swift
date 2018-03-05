//
//  DenseGraph.swift
//  Algorithms
//
//  Created by Chris on 2017/9/28.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//稠密图 - 邻接矩阵
class DenseGraph:GraphProtocol {
    private var n: Int //顶点数
    private var m = 0 //边数
    private var directed: Bool
    private var graph: [[Bool]]
    
    init(n: Int, directed: Bool) {
        self.n = n
        self.directed = directed
        graph = [[Bool]]()
        for _ in 0 ..< n {
            graph.append([Bool](repeatElement(false, count: n)))
        }
    }
    
    func V() -> Int {
        return n
    }
    
    func E() -> Int {
        return m
    }
    
    func addEdge(_ v: Int, _ w: Int) {
        
        assert(v >= 0 && v < n)
        assert(w >= 0 && w < n)
        
        //忽略平行边
        if hasEdge(v, w) {
            return
        }
        
        graph[v][w] = true
        if !directed {
            graph[w][v] = true
        }
        
        m += 1
    }
    
    func hasEdge(_ v: Int, _ w: Int) -> Bool {
        
        assert(v >= 0 && v < n)
        assert(w >= 0 && w < n)
        
        return graph[v][w]
    }
    
    func show() {
        print("   ", terminator: "")
        for i in 0 ..< n {
            print(String(format:"%02d", i), terminator: " ")
        }
        print()
        for i in 0 ..< n {
            print(String(format:"%02d", i), terminator: " ")
            for j in 0 ..< n {
                print(hasEdge(i, j) ? " 1": " 0", terminator: " ")
            }
            print()
        }
    }
    
    typealias Iterator = DenseGraph.AdjacentIterator
    func adjIterator(_ v: Int) -> DenseGraph.AdjacentIterator {
        return DenseGraph.AdjacentIterator(graph: self, v: v)
    }
    
    //邻接点迭代器
    class AdjacentIterator:GraphIterator {
        
        private let graph: DenseGraph
        private let v: Int
        private var index = 0
        
        init(graph: DenseGraph, v: Int) {
            self.graph = graph
            self.v = v
        }
        
        func begin(){
            index = 0
        }
        
        func next() -> Int? {
            
            for i in index ..< graph.V(){
                if graph.graph[v][i] {
                    index = i + 1
                    return i
                }
            }
            
            return nil
        }
    }
}


/// 测试邻接点迭代器
///   - n: 顶点数
///   - m: 边数
func testDenseGraph(_ n: Int, _ m: Int) {
    let graph = DenseGraph(n: n, directed: false)
    for _ in 0 ..< m {
        let a = Int(arc4random()) % n
        let b = Int(arc4random()) % n
        graph.addEdge(a, b)
    }
    for i in 0 ..< n {
        print(" \(i): ", terminator: "")
        let adjIteretor = graph.adjIterator(i)
        adjIteretor.begin()
        while let v = adjIteretor.next() {
            print(v, terminator: " ")
        }
        print("")
    }
}
