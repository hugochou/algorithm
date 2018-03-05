//
//  UnionFind2.swift
//  Algorithms
//
//  Created by Chris on 2017/9/28.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

struct UnionFind4 {
    var parent: [Int]
    var rank: [Int] //rank[i] 表示以 i 为根的树的高度（层数）
    var count: Int
    
    init(count: Int) {
        self.count = count
        self.parent = []
        self.rank = [Int](repeatElement(1, count: count))
        for i in 0 ..< count {
            self.parent.append(i)
        }
    }
    
    mutating func find(_ p: Int) -> Int {
        assert(p >= 0 && p < count)
        
        var i = p
        while parent[i] != i {
            parent[i] = parent[parent[i]]
            i = parent[i]
        }
        return i
        
        //使用递归将一棵树中的所有元素的父节点都指向该树的根，逻辑上比上面的路径压缩性能更优，但由于递归有额外的性能消耗，所以比上面运行稍慢
//        if p != parent[p] {
//            parent[p] = find(parent[p])
//        }
//        return parent[p]
    }
    
    mutating func isConnected(_ p: Int, _ q: Int) -> Bool {
        return find(p) == find(q)
    }
    
    mutating func union(_ p: Int, _ q: Int) {
        let pRoot = find(p)
        let qRoot = find(q)
        if pRoot == qRoot {return}
        
        if rank[pRoot] < rank[qRoot] {
            parent[pRoot] = qRoot
        }
        else if rank[qRoot] < rank[pRoot]{
            parent[qRoot] = pRoot
        }
        else {
            parent[pRoot] = qRoot
            rank[qRoot] += 1
        }
    }
}


func testUF4(_ n: Int) {
    var uf1 = UnionFind4(count: n)
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

