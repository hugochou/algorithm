//
//  LazyPrimMST.swift
//  Algorithms
//
//  Created by Chris on 2017/12/29.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

class LazyPrimMST<Graph:GraphProtocolW, Weight:Numeric & Comparable & CustomStringConvertible> {
    private var graph:Graph
    private var marked:[Bool] //图中顶点是否已被访问
    private var mst:[Edge<Weight>] = [] //最小生成树的边
    private var minHeap:MinHeap<Edge<Weight>> //最小堆：保存已访问顶点相连的边
    private var mstWeight:Weight? //最小生成树权值之和
    
    private func visit(_ i: Int) {
        assert(!marked[i])
        
        marked[i] = true
        
        let iterator = graph.adjIterator(i)
        iterator.begin()
        while let edge = iterator.next() as? Edge<Weight> {
            if !marked[edge.other(i)] {
                minHeap.insert(edge)
            }
        }
    }
    
    init(_ graph:Graph) {
        self.graph = graph
        marked = Array(repeating: false, count: graph.V())
        minHeap = MinHeap<Edge<Weight>>()
        
        //Lazy Prim
        self.visit(0)
        while !minHeap.isEmpty() {
            if let edge = minHeap.extractMin() {
                //两个顶点在同一侧，表示非横切边
                if marked[edge.v()] == marked[edge.w()] { continue }
                
                mst.append(edge)
                if !marked[edge.v()] {
                    visit(edge.v())
                }
                else {
                    visit(edge.w())
                }
            }
        }
        
        mstWeight = mst[0].wt()
        for i in 1 ..< mst.count {
            mstWeight! = mstWeight! + mst[i].wt()
        }
    }
    
    func mstEdges() -> [Edge<Weight>] {
        return mst
    }
    
    func result() -> Weight? {
        return mstWeight;
    }
    
    class func test() {
        
        let fileName1 = "testGW1.txt"
        let graph = SparesGraphW<Double>(n: 8, directed: false)
        ReadGraphW<SparesGraphW<Double>>(graph: graph, fileName: fileName1)
        
        let prim = LazyPrimMST<SparesGraphW<Double>, Double>(graph)
        let mst = prim.mstEdges()
        for edge in mst {
            print(edge)
        }
        print(prim.result())
    }
}
