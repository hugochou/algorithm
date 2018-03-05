//
//  BellmanFord.swift
//  Algorithms
//
//  Created by Chris on 2018/2/22.
//  Copyright © 2018年 Chris. All rights reserved.
//

import Foundation

class BellmanFord<Graph: GraphProtocolW, Weight: Numeric & Comparable & CustomStringConvertible> {
    private var graph: Graph
    private var s: Int
    private var marked: [Bool]
    private var distTo: [Weight]
    private var from: [Edge<Weight>?]
    private var hasNegativeCycle: Bool = false
    
    private func detectNegativeCycle() -> Bool {
        
        // Relaxation
        for i in 0 ..< graph.V() {
            
            let it = graph.adjIterator(i)
            it.begin()
            while let edge = it.next() as? Edge<Weight> {
                let j = edge.other(i)
                if from[j] == nil || distTo[i] + edge.wt() < distTo[j] {
                    return true
                }
            }
        }
        
        return false
    }
    
    init(_ graph: Graph, start: Int) {
        self.graph = graph
        s = start
        marked = Array(repeatElement(false, count: graph.V()))
        distTo = Array(repeatElement(0.0 as! Weight, count: graph.V()))
        from = Array(repeatElement(nil, count: graph.V()))
        
        // Bellman-Ford：对所有点进行 V-1 次松弛操作
        for _ in 1 ..< graph.V() {
            
            // Relaxation：对所有点进行 1 次松弛操作
            for i in 0 ..< graph.V() {
                
                let it = graph.adjIterator(i)
                it.begin()
                while let edge = it.next() as? Edge<Weight> {
                    let j = edge.other(i)
                    if from[j] == nil || distTo[i] + edge.wt() < distTo[j] {
                        from[j] = edge
                        distTo[j] = distTo[i] + edge.wt()
                    }
                }
            }
        }
        
        hasNegativeCycle = detectNegativeCycle()
    }
    
    func negativeCycle() -> Bool {
        return hasNegativeCycle
    }
    
    func shortestPathWeight(to w: Int) -> Weight {
        assert(w >= 0 && w < graph.V())
        assert(!hasNegativeCycle)
        return distTo[w]
    }
    
    func hasPath(to w: Int) -> Bool {
        assert(!hasNegativeCycle)
        return from[w] != nil
    }
    
    func shortestPath(to w: Int) -> [Edge<Weight>] {
        
        assert(w >= 0 && w < graph.V() && from[w] != nil)
        assert(!hasNegativeCycle)
        
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
        assert(!hasNegativeCycle)
        
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
        
        let fileName1 = "testG2.txt"
        let graph = SparesGraphW<Double>(n: 5, directed: true)
        ReadGraphW<SparesGraphW<Double>>(graph: graph, fileName: fileName1)
        
        let bellmanFord = BellmanFord<SparesGraphW<Double>, Double>(graph, start: 0)
        if bellmanFord.negativeCycle() {
            print("The graph contain negative cycle.")
        }
        else {
            for i in 1 ..< graph.V() {
                print("Shortest Path to \(i) : \(bellmanFord.shortestPathWeight(to: i))")
                bellmanFord.showPath(to: i)
                print("---------------------------------")
            }
        }
    }
}
