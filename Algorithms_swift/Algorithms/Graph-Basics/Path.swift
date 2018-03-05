//
//  Path.swift
//  Algorithms
//
//  Created by Chris on 2017/10/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//使用深度优先遍历算法查找图中两点之间的一条路径
class Path<Graph: GraphProtocol> {
    private var graph: Graph
    private var visited: [Bool]
    private var from: [Int]
    
    //深度优先遍历
    private func deepFirstSearch(_ v: Int) {
        visited[v] = true
        let adjIterator = graph.adjIterator(v)
        adjIterator.begin()
        while let i = adjIterator.next() {
            if !visited[i] {
                from[i] = v
                deepFirstSearch(i)
            }
        }
        
    }
    
    init(graph: Graph, v: Int) {
        self.graph = graph
        visited = [Bool](repeatElement(false, count: graph.V()))
        from = [Int](repeatElement(-1, count: graph.V()))
        deepFirstSearch(v)
    }
    
    func hasPath(_ w: Int) -> Bool {
        assert( w >= 0 && w < graph.V())
        return visited[w]
    }
    
    func path(_ w: Int) -> [Int] {
        assert(w >= 0 && w < graph.V())
        
        var stack = [Int]()
        var w = w
        while from[w] != -1 {
            stack.append(w)
            w = from[w]
        }
        stack.append(w)
        return stack.reversed()
    }
    
    func showPath(_ w: Int) {
        assert(w >= 0 && w < graph.V())
        
        let path = self.path(w)
        for i in 0 ..< path.count {
            print(path[i], terminator: (i == path.count - 1 ? "\n" : "->"))
        }
        print()
    }
    
}
