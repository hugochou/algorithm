//
//  MaxHeap.swift
//  Algorithms
//
//  Created by Chris on 2017/8/28.
//  Copyright © 2017年 Chris. All rights reserved.

//  最大堆：任意父节点的值大于其子节点的值
//  堆：多用于动态数据的维护

//  堆排序的算法复杂度：
//  将n个元素逐一的插入堆中，算法复杂度是O(nlogn)
//  heapify的过程，算法复杂度是O(n)

import Foundation

struct MaxHeap<Item: Comparable> {
    
    private var data: [Item] = []//从零开始
    private var count = 0
    
    private func left(by index: Int) -> Int {
        return index * 2 + 1
    }
    
    private func right(by index: Int) -> Int{
        return index * 2 + 2
    }
    
    private func parent(by index: Int) -> Int{
        return (index - 1) / 2
    }
    
    private mutating func shiftUp(_ k: Int) {
        
        var k = k
        let item = data[k]
        while k > 0 && data[parent(by: k)] < item {
            
            let j = parent(by: k)
            data[k] = data[j]
            k = j
        }
        data[k] = item
    }
    
    private mutating func shiftDown(_ k: Int){
        
        var k = k
        let item = data[k]
        while (left(by: k) < count) {
            
            var j = left(by: k)
            if j + 1 < count && data[j+1] > data[j] {
                j = j + 1
            }
            
            if item >= data[j] { break }
            
            data[k] = data[j]
            k = j
        }
        data[k] = item
    }
    
    
    
    init() {
        
    }
    
    init(array: [Item]) {
        
        self.count = array.count
        self.data = array;
        
        //heapify过程：将数组转换为最大堆
        //找到第一个非叶子节点（(count-1)/2）开始不断往前(curIndex-1)逐步处理子树，使其满足最大堆性质。
        for i in stride(from: (array.count-1) / 2, through: 0, by: -1) {
            self.shiftDown(i)
        }
    }
    
    
    func getData() -> [Item] {
        return data
    }
    
    func size() -> Int{
        return count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    //新增节点
    mutating func insert(_ item: Item) {
        
        data.insert(item, at: count)
        count += 1
        
        shiftUp(count - 1)
    }
    
    //取出跟节点
    mutating func extractMax() -> Item {
        
        assert(count > 0)
        
        let res = data.first
        ( data[0], data[count - 1] ) = ( data[count - 1], data[0])
        count -= 1
        shiftDown(0)
//        data.removeLast()
        
        return res!
    }
    
    
    static func test() {
        
        var maxHeap = MaxHeap<Int>()
        let n = 63
        for _ in 0 ..< n {
            let item = Int(arc4random()) % 100
            maxHeap.insert(item)
        }
        maxHeap.printTree()
        print()
        print()
        while !maxHeap.isEmpty() {
            print(maxHeap.extractMax(), terminator: " ")
        }
        print()
    }
}



