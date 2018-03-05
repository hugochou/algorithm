//
//  ReadGraph.swift
//  Algorithms
//
//  Created by Chris on 2017/10/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

class ReadGraphW<Graph:GraphProtocolW> {
    
    private let filePath = "/Users/Chris/workspace/Swift/Algorithms/Algorithms/WeightGraph/"
    
    init(graph: Graph, fileName: String) {
        let file = URL(fileURLWithPath: filePath + fileName)
        if let data = try? String(contentsOf: file, encoding: .utf8) {
            let line = data.components(separatedBy: .newlines)
            guard line.count >= 2 else {
                return
            }
            
            for i in 1 ..< line.count {
                let tempLine = line[i].components(separatedBy: " ")
                //将读取出来的权重转换为 double 类型再转为 Graph.Weight，这样才能被 graph.addEdge 调用
                var wt: Graph.Weight!
                if let v = Int(tempLine[0]), let w = Int(tempLine[1]), let wt = Double(tempLine[2]) as? Graph.Weight {
                    graph.addEdge(v, w, weight: wt)
                }
            }
        }
    }
    
    static func testDenseGraph() {
        
        let fileName1 = "testGW1.txt"
        let g1 = DenseGraphW<Double>(n: 8, directed: false)
        _ = ReadGraphW<DenseGraphW<Double>>(graph: g1, fileName: fileName1)
        g1.show()
    }
    
    static func testSparesGraph() {
        
        let fileName1 = "testGW1.txt"
        let g1 = SparesGraphW<Double>(n: 8, directed: false)
        _ = ReadGraphW<SparesGraphW<Double>>(graph: g1, fileName: fileName1)
        g1.show()
    }
}
