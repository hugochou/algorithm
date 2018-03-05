//
//  ReadGraph.swift
//  Algorithms
//
//  Created by Chris on 2017/10/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

class ReadGraph<Graph:GraphProtocol> {
    
    private let filePath = "/Users/Chris/workspace/Swift/Algorithms/Algorithms/"
    
    init(graph: Graph, fileName: String) {
        let file = URL(fileURLWithPath: filePath + fileName)
        if let data = try? String(contentsOf: file, encoding: .utf8) {
            let line = data.components(separatedBy: .newlines)
            guard line.count >= 2 else {
                return
            }
            
            for i in 1 ..< line.count {
                let tempLine = line[i].components(separatedBy: " ")
                if let v = Int(tempLine[0]), let w = Int(tempLine[1]) {
//                    print(v,w)
                    graph.addEdge(v, w)
                }
            }
        }
    }
}
