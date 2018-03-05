//
//  KruskMST.swift
//  Algorithms
//
//  Created by Chris on 2018/2/21.
//  Copyright © 2018年 Chris. All rights reserved.
//

import Foundation

class KruskMST<Graph:GraphProtocolW, Weight:Numeric & Comparable & CustomStringConvertible> {
    private var mst:[Edge<Weight>] = []
    private var mstWeight:Weight?
    
    init(_ graph:Graph) {
        
        //使用最小堆对所有边排序
        var minHeap = MinHeap<Edge<Weight>>()
        for i in 0..<graph.V() {
            let it = graph.adjIterator(i)
            it.begin()
            while let edge = it.next() as? Edge<Weight> {
                if i < edge.other(i) {
                    minHeap.insert(edge)
                }
            }
        }
        
        //使用并查集筛选出最小边
        var uf = UnionFind4(count: graph.V())
        while !minHeap.isEmpty() && mst.count < graph.V() - 1{
            
            if let edge = minHeap.extractMin(), !uf.isConnected(edge.v(), edge.w()) {
                mst.append(edge)
                uf.union(edge.v(), edge.w())
            }
        }
        
        mstWeight = mst[0].wt()
        for i in 1 ..< mst.count {
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
        
        let krusk = KruskMST<SparesGraphW<Double>, Double>(graph)
        let mst = krusk.mstEdges()
        for edge in mst {
            print(edge)
        }
        print(krusk.result())
    }
}
