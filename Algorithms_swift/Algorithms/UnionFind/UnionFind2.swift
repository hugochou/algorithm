//
//  UnionFind2.swift
//  Algorithms
//
//  Created by Chris on 2017/9/28.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

struct UnionFind2 {
    var parent: [Int]
    var count: Int
    
    init(count: Int) {
        self.count = count
        self.parent = []
        for i in 0 ..< count {
            self.parent.append(i)
        }
    }
    
    func find(_ p: Int) -> Int {
        assert(p >= 0 && p < count)
        var i = p
        while parent[i] != i {
            i = parent[i]
        }
        return i
    }
    
    func isConnected(_ p: Int, _ q: Int) -> Bool {
        return find(p) == find(q)
    }
    
    mutating func union(_ p: Int, _ q: Int) {
        let pRoot = find(p)
        let qRoot = find(q)
        if pRoot == qRoot {return}
        
        parent[qRoot] = pRoot
    }
}


func testUF2(_ n: Int) {
    var uf1 = UnionFind2(count: n)
    let start = Date().timeIntervalSince1970
    
    for _ in 0 ..< n {
        let a = Int(arc4random()) % n
        let b = Int(arc4random()) % n
        uf1.union(a, b)
    }
    
    for _ in 0 ..< n {
        let a = Int(arc4random()) % n
        let b = Int(arc4random()) % n
        _ = uf1.isConnected(a, b)
    }
    let end = Date().timeIntervalSince1970
    print("UF1, \(2*n) ops, \(end - start) s")
}

