//
//  UnionFind.swift
//  Algorithms
//
//  Created by Chris on 2017/9/28.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation
struct UnionFind {
    var id: [Int] //索引表示元素，值表示连接关系（两元素的值相等，表示这两个元素是连接的）
    var count: Int
    
    init(count: Int) {
        self.count = count
        self.id = Array<Int>(repeatElement(0, count: count))
        for (i,_) in self.id.enumerated() {
            self.id[i] = i
        }
    }
    
    func find(_ p: Int) -> Int {
        assert(p >= 0 && p < count)
        return id[p]
    }
    
    func isConnected(_ p: Int, _ q: Int) -> Bool {
        return find(p) == find(q)
    }
    
    //时间级别 O(n)
    mutating func union(_ p: Int, _ q: Int) {
        let pID = find(p)
        let qID = find(q)
        
        if pID == qID { return }
        
        for (i, _) in id.enumerated() {
            if id[i] == pID {
                id[i] = qID
            }
        }
    }
}

func testUF1(_ n: Int) {
    var uf1 = UnionFind(count: n)
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
