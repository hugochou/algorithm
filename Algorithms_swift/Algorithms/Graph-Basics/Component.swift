//
//  Component.swift
//  Algorithms
//
//  Created by Chris on 2017/10/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//使用深度优先遍历算法查看图中有多少联通分量
class Component<Graph:GraphProtocol> {
    
    private var graph:Graph
    private var ccount: Int = 0 //联通分量的数量
    private var visited:[Bool] //顶点是否已访问
    private var id: [Int] //相连的两个顶点，id值相等
    
    //深度优先遍历
    private func deepFirstSearch(_ v: Int) {
        visited[v] = true
        let adjIterator = graph.adjIterator(v)
        adjIterator.begin()
        while let i = adjIterator.next() {
            id[i] = ccount
            if !visited[i] {
                deepFirstSearch(i)
            }
        }
        
    }
    
    var count: Int {
        return ccount;
    }
    
    init(graph: Graph) {
        self.graph = graph
        visited = [Bool](repeatElement(false, count: graph.V()))
        id = [Int](repeatElement(0, count: graph.V()))
        
        for i in 0 ..< graph.V() {
            if !visited[i] {
                deepFirstSearch(i)
                ccount += 1
            }
        }
    }
    
    func isConnect(_ v:Int, _ w: Int) -> Bool {
        assert(v >= 0 && v < graph.V())
        assert(w >= 0 && w < graph.V())
        
        return id[v] == id[w]
    }
}
