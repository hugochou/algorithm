//
//  Dijkstra.swift
//  Algorithms
//
//  Created by Chris on 2018/2/22.
//  Copyright © 2018年 Chris. All rights reserved.
//  对没有负权边的图查找最短路径算法

import Foundation
class Dijkstra<Graph:GraphProtocolW, Weight: Numeric & Comparable & CustomStringConvertible>{
    private var graph: Graph
    private var s: Int = 0 //起点
    private var distTo: [Weight] //从起点到每一个顶点最短路径值
    private var marked:[Bool]
    private var from:[Edge<Weight>?] //最短路径树中每一个节点是从哪个节点过来的
    private var indexMinHeap: IndexMinHeap<Weight>
    
    init(_ graph:Graph, start: Int) {
        s = start
        self.graph = graph
        
        distTo = Array(repeatElement((0.0 as! Weight), count: graph.V()))
        marked = Array(repeatElement(false, count: graph.V()))
        from = Array(repeatElement(nil, count: graph.V()))
        indexMinHeap = IndexMinHeap<Weight>(capacity: graph.V())
        
        // Dijkstra
        distTo[s] = (0.0 as! Weight)
        marked[s] = true
        indexMinHeap.insert(distTo[s], at: s)
        while !indexMinHeap.isEmpty() {
            let v = indexMinHeap.extractMinIndex()
            marked[v] = true
            
            let it = graph.adjIterator(v); it.begin()
            while let edge = it.next() as? Edge<Weight> {
                let w = edge.other(v)
                if !marked[w] {
                    // Relaxation (松弛操作)
                    if from[w] == nil || distTo[v] + edge.wt() < distTo[w] {
                        distTo[w] = distTo[v] + edge.wt()
                        from[w] = edge
                        if indexMinHeap.contain(w) {
                            indexMinHeap.change(distTo[w], at: w)
                        }
                        else {
                            indexMinHeap.insert(distTo[w], at: w)
                        }
                    }
                }
            }
            
        }
    }
    
    func shortestPathWeight( to w: Int ) -> Weight? {
        return distTo[w]
    }
    
    func hasPath( to w: Int ) -> Bool {
        return from[w] != nil
    }
    
    func shortestPath(to w: Int) -> [Edge<Weight>] {
        
        assert(w >= 0 && w < graph.V() && from[w] != nil)
        
        var w = w
        var stack: [Edge<Weight>] = []
        while let edge = from[w], w != s {
            stack.append(edge)
            w = edge.other(w)
        }
        
        return stack.reversed()
    }
    
    func showPath(to w: Int) {
        assert(w >= 0 && w < graph.V())
        
        let path = shortestPath(to: w)
        var v = 0
        print("0", terminator:" -> ")
        for i in 0 ..< path.count {
            let edge = path[i]
            print(edge.other(v), terminator: (i == path.count - 1 ? "\n" : " -> "))
            v = edge.other(v)
        }
    }
    
    class func test() {
        
        let fileName1 = "testG1.txt"
        let graph = SparesGraphW<Double>(n: 5, directed: true)
        ReadGraphW<SparesGraphW<Double>>(graph: graph, fileName: fileName1)
        
        let dijkstra = Dijkstra<SparesGraphW<Double>, Double>(graph, start: 0)
        for i in 1 ..< graph.V() {
            print("Shortest Path to \(i) : \(dijkstra.shortestPathWeight(to: i))")
            dijkstra.showPath(to: i)
            print("---------------------------------")
        }
    }
}
