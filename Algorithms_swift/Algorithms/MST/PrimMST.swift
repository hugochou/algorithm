//
//  LazyPrimMST+.swift
//  Algorithms
//
//  Created by Chris on 2018/2/10.
//  Copyright © 2018年 Chris. All rights reserved.
//

import Foundation

class PrimMST<Graph:GraphProtocolW, Weight:Numeric & Comparable & CustomStringConvertible> {
    var graph: Graph
    var iMinHeap: IndexMinHeap<Weight> //最小索引堆，存放和每个节点相邻的可选的横切边相应的权值
    var edgeTo: [Edge<Weight>?] //存储和每个节点相邻的那个最短的横切边
    var marked: [Bool]
    var mst: [Edge<Weight>] = []
    var mstWeight: Weight?
    
    private func visit(_ v: Int) {
        assert(!marked[v])
        marked[v] = true
        
        //访问顶点 v 的所有领边
        let iterator = graph.adjIterator(v)
        iterator.begin()
        while let edge = iterator.next() as? Edge<Weight> {
            let w = edge.other(v)
            if !marked[w] {
                if edgeTo[w] == nil {
                    iMinHeap.insert(edge.wt(), at: w)
                    edgeTo[w] = edge
                }
                else if let temp = edgeTo[w], edge.wt() < temp.wt()  {
                    iMinHeap.change(edge.wt(), at: w)
                    edgeTo[w] = edge
                }
            }
        }
    }
    
    init(_ graph: Graph) {
        self.graph = graph
        marked = Array(repeatElement(false, count: graph.V()))
        edgeTo = Array(repeatElement(nil, count: graph.V()))
        iMinHeap =  IndexMinHeap<Weight>(capacity: graph.V())
        
        visit(0)
        while !iMinHeap.isEmpty() {
            let v = iMinHeap.extractMinIndex()
            assert( edgeTo[v] != nil )
            mst.append( edgeTo[v]! )
            visit(v)
        }
        
        mstWeight = mst.first?.wt()
        for i in 1..<mst.count {
            mstWeight = mstWeight! + mst[i].wt()
        }
    }
    
    func mstEdges() -> [Edge<Weight>] {
        return mst
    }
    
    func result() -> Weight {
        return mstWeight!
    }
    
    class func test() {
        
        let fileName1 = "testGW1.txt"
        let graph = SparesGraphW<Double>(n: 8, directed: false)
        ReadGraphW<SparesGraphW<Double>>(graph: graph, fileName: fileName1)
        
        let prim = PrimMST<SparesGraphW<Double>, Double>(graph)
        let mst = prim.mstEdges()
        for edge in mst {
            print(edge)
        }
        print(prim.result())
    }
}
