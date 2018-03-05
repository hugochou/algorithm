//
//  ShortestPath.swift
//  Algorithms
//
//  Created by Chris on 2017/10/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//通过广度优先遍历求出无权图的最短路径
class ShortestPath<Graph: GraphProtocol> {
    private var graph: Graph
    private var visited: [Bool]
    private var from: [Int]
    private var level: [Int] //与起点的层级距离
    private let s: Int //起始点
    
    init(graph: Graph, s: Int) {
        self.graph = graph
        self.s = s
        visited = [Bool](repeatElement(false, count: graph.V()))
        from = [Int](repeatElement(-1, count: graph.V()))
        level = [Int](repeatElement(-1, count: graph.V()))
        
        //广度优先遍历
        var queue = [Int]()
        queue.append(s)
        visited[s] = true
        level[s] = 0
        while queue.count > 0 {
            let v = queue.first!
            queue.removeFirst()
            let adj = graph.adjIterator(v)
            adj.begin()
            while let w = adj.next() {
                if !visited[w] {
                    queue.append(w)
                    visited[w] = true
                    from[w] = v
                    level[w] = level[v] + 1
                }
            }
        }
    }
    
    func hasPath(_ w: Int) -> Bool {
        assert( w >= 0 && w < graph.V())
        return visited[w]
    }
    
    func path(_ w: Int) -> [Int] {
        assert( w >= 0 && w < graph.V())
        
        var path = [Int]()
        var w = w
        while from[w] != -1 {
            path.append(w)
            w = from[w]
        }
        path.append(w)
        return path.reversed()
    }
    
    func showPath(_ w: Int) {
        assert( w >= 0 && w < graph.V())
        
        let path = self.path(w)
        for i in 0 ..< path.count {
            print(path[i], terminator: (i == path.count - 1 ? "\n" : "->"))
        }
    }
}
