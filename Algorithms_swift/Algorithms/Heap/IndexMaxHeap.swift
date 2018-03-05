//
//  MaxHeap.swift
//  Algorithms
//
//  Created by Chris on 2017/8/28.
//  Copyright © 2017年 Chris. All rights reserved.

//  最大索引堆：额外用索引数组储存数据数组的索引值，对索引数组进行堆组建，不改变数据数组。


//  最大索引堆能解决最大堆中出现的以下问题：
//  1. 针对大数据的元素，不断的交换位置会消耗资源
//  2. 将数组变成堆后，原数组的索引被打乱，要找到某个元素进行修改的话必须遍历数组才能做到

import Foundation

struct IndexMaxHeap<Item: Comparable> {
    
    private var data: [Item] = []
    private var indexes: [Int] = [] //堆索引，以数据数组为基础的堆结构，储存数据数组的索引
    private var reverse: [Int] = [] //数据数组索引在堆索引中的位置
    private var count = 0
    
    private func left(by k: Int) -> Int {
        return k * 2 + 1
    }
    
    private func right(by k: Int) -> Int{
        return k * 2 + 2
    }
    
    private func parent(by k: Int) -> Int{
        return (k - 1) / 2
    }
    
    private mutating func shiftUp(_ k: Int) {
        
        var k = k
        let i = indexes[k]
        let item = data[i]
        while k > 0 && data[indexes[parent(by: k)]] < item {
            
            let j = parent(by: k)
            indexes[k] = indexes[j]
            reverse[indexes[k]] = k
            k = j
        }
        indexes[k] = i
        reverse[i] = k
    }
    
    private mutating func shiftDown(_ k: Int){
        
        var k = k
        let i = indexes[k]
        let item = data[i]
        while (left(by: k) < count) {
            
            var j = left(by: k)
            if j + 1 < count && data[indexes[j+1]] > data[indexes[j]] {
                j = j + 1
            }
            
            if item >= data[indexes[j]] { break }
            
            indexes[k] = indexes[j]
            reverse[indexes[k]] = k
            k = j
        }
        indexes[k] = i
        reverse[i] = k
    }
    
    
    
    init() {
        
    }
    
    init(array: [Item]) {
        
        self.count = array.count
        self.data = array;
        self.indexes = Array(0..<array.count)
        
        //heapify过程：将数组转换为最大堆
        //找到第一个非叶子节点（(index-1)/2）开始不断往前(curIndex-1)逐步处理子树，使其满足最大堆性质。
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
        
        indexes.insert(count, at: count)
        reverse.insert(count, at: count)
        data.insert(item, at: count)
        count += 1
        
        shiftUp(count - 1)
    }
    
    //取出跟节点
    mutating func extractMax() -> Item {
        
        assert(count > 0)
        
        let res = data[indexes.first!]
        ( indexes[0], indexes[count - 1] ) = ( indexes[count - 1], indexes[0])
        reverse[indexes[0]] = 0
        reverse[indexes[count-1]] = -1
        count -= 1
        shiftDown(0)
//        indexes.removeLast()
        
        return res
    }
    
    mutating func extractMaxIndex() -> Int {
        
        assert(count > 0)
        
        let res = indexes.first!
        ( indexes[0], indexes[count - 1] ) = ( indexes[count - 1], indexes[0])
        reverse[indexes[0]] = 0
        reverse[indexes[count-1]] = -1
        count -= 1
        shiftDown(0)
        
        return res
    }
    
    func contain(_ index: Int) -> Bool {
        
        assert(index >= 0 && index < count)
        return reverse[index] != -1
    }
    
    func item(at index: Int) -> Item {
        
        assert(contain(index))
        return data[index]
    }
    
    mutating func setItem(at index: Int, item: Item) {
        
        assert(contain(index))
        
        data[index] = item
        
        //优化后使用reverse[index]
        shiftUp(reverse[index])
        shiftDown(reverse[index])
        
        //找到indexes[j] == index，j 表示 data[index] 在堆中的位置
//        for j in 0..<count {
//            
//            if indexes[j] == index {
//                shiftUp(j)
//                shiftDown(j)
//                return
//            }
//        }
    }
    
    
    static func test() {
        
        var maxHeap = IndexMaxHeap<Int>()
        let n = 63
        for _ in 0 ..< n {
            let item = Int(arc4random()) % 100
            maxHeap.insert(item)
        }
        //        maxHeap.printTree()
        print()
        print()
        while !maxHeap.isEmpty() {
            print(maxHeap.extractMax(), terminator: " ")
        }
        print()
    }
}



