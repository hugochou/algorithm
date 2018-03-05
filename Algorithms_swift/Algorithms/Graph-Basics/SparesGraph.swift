//
//  SparesGraph.swift
//  Algorithms
//
//  Created by Chris on 2017/9/28.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//稀疏图 - 邻接表
class SparesGraph:GraphProtocol {
    
    private var n: Int
    private var m = 0
    private var directed: Bool
    private var graph: [[Int]]
    
    init(n: Int, directed: Bool) {
        self.n = n
        self.directed = directed
        graph = [[Int]]()
        for _ in 0 ..< n {
            graph.append([Int]())
        }
    }
    
    func V() -> Int {
        return n
    }
    
    func E() -> Int {
        return m
    }
    
    //此处不对平行边做处理，因为hasEdge是O(n)复杂度，如果每次addEdge都要检查hasEdge，addEdge也变成O(n)
    func addEdge(_ v: Int, _ w: Int) {
        
        assert(v >= 0 && v < n)
        assert(w >= 0 && w < n)
        
        graph[v].append(w)
        if v != w && !directed {
            graph[w].append(v)
        }
    }
    
    func hasEdge(_ v: Int, _ w: Int) -> Bool {
        
        assert(v >= 0 && v < n)
        assert(w >= 0 && w < n)
        
        return graph[v].contains(w)
    }
    
    func show() {
        for i in 0 ..< n {
            print("\(i): ", terminator: "")
            for n in graph[i] {
                print("\(n)", terminator: " ")
            }
            print()
        }
    }
    
    typealias Iterator = SparesGraph.AdjacentIterator
    func adjIterator(_ v: Int) -> SparesGraph.AdjacentIterator {
        return SparesGraph.AdjacentIterator(graph: self, v: v)
    }
    
    //邻接点的迭代器
    class AdjacentIterator:GraphIterator {
        
        private let graph: SparesGraph
        private let v: Int
        private var index: Int
        
        init(graph: SparesGraph, v: Int) {
            self.graph = graph
            self.v = v
            self.index = 0
        }
        
        func begin() {
            index = 0
        }
        
        func next() -> Int? {
            var res: Int? = nil
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
func testSparesGraph(_ n: Int, _ m: Int) {
    let graph = SparesGraph(n: n, directed: false)
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
