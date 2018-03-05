//
//  IndexMinHeap.swift
//  Algorithms
//
//  Created by Chris on 2018/2/10.
//  Copyright © 2018年 Chris. All rights reserved.
//

import Foundation

struct IndexMinHeap<Item: Comparable> {
    
    private var data = [Item?]() //数据
    private var indexes = [Int]() //索引堆
    private var reverse = [Int]() //返回某个数据在索引堆的位置，例如：reverse[i] 表示 data[i] 在 indexes 中的索引
    private var count = 0
    private let capacity: Int
    
    private mutating func shiftUp(_ i: Int) {
        var i = i
        let k = indexes[i]
        
        while i > 0 && data[k]! < data[indexes[(i-1)/2]]! {
            indexes[i] = indexes[(i-1)/2]
            reverse[indexes[i]] = i
            i = (i-1)/2
        }
        indexes[i] = k
        reverse[k] = i
    }
    
    private mutating func shiftDown(_ i: Int) {
        var i = i
        let k = indexes[i]
        
        while i*2+1 < count && data[indexes[i*2+1]]! < data[k]! {
            var j = i*2+1
            if i*2+2 < count && data[indexes[i*2+2]]! < data[indexes[j]]! {
                j = i*2+2
            }
            indexes[i] = indexes[j]
            reverse[indexes[i]] = i
            i = j
        }
        indexes[i] = k
        reverse[k] = i
    }
    
    init(capacity: Int) {
        self.capacity = capacity
        data = Array(repeatElement(nil, count: capacity))
        indexes = Array(repeatElement(-1, count: capacity))
        reverse = Array(repeatElement(-1, count: capacity))
    }
    
    func getData() -> [Item?] {
        return data
    }
    
    func size() -> Int {
        return count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    mutating func insert(_ item: Item) {
        indexes.insert(count, at: count)
        reverse.insert(count, at: count)
        data.insert(item, at: count)
        count += 1
        
        shiftUp(count - 1)
    }
    
    mutating func insert(_ item: Item, at index: Int) {
        assert(index >= 0 && index < capacity)
        
        indexes[count] = index
        reverse[index] = count
        data[index] = item
        count += 1
        shiftUp(count - 1)
    }
    
    mutating func extractMin() -> Item {
        assert(count > 0)
        
        let res = data[indexes.first!]!
        (indexes[0], indexes[count-1]) = (indexes[count-1], indexes[0])
        reverse[indexes[0]] = 0
        reverse[indexes[count-1]] = -1
        count -= 1
        shiftDown(0)
        
        return res
    }
    
    mutating func extractMinIndex() -> Int {
        assert(count > 0)
        
        let res = indexes.first!
        (indexes[0], indexes[count-1]) = (indexes[count-1], indexes[0])
        reverse[indexes[0]] = 0
        reverse[indexes[count-1]] = -1
        count -= 1
        
        shiftDown(0)
        return res
    }
    
    func contain(_ index: Int) -> Bool {
        assert(index >= 0 && index < capacity)
        
        return reverse[index] != -1
    }
    
    func item(at index: Int) -> Item {
        assert(contain(index))
        return data[index]!
    }
    
    mutating func change(_ item: Item, at index: Int) {
        assert(contain(index))
        
        data[index] = item
        shiftUp(reverse[index])
        shiftDown(reverse[index])
    }
}
