//
//  MinHeap.swift
//  Algorithms
//
//  Created by Chris on 2017/10/11.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

struct MinHeap<T:Comparable> {
    private var count = 0
    private var data = [T]()
    
    private mutating func shiftUp(_ i: Int) {
        var i = i
        let item = data[i]
        
        while i > 0 && item < data[(i-1)/2] {
            data[i] = data[(i-1)/2]
            i = (i-1)/2
        }
        data[i] = item
    }
    
    private mutating func shiftDown(_ i: Int) {
        var i = i
        let item = data[i]
        
        while i*2+1 < count {
            var j = i*2+1
            if i*2+2 < count && data[i*2+2] < data[j] {
                j = i*2+2
            }
            data[i] = data[j]
            i = j
        }
        data[i] = item
    }
    
    init() {
        
    }
    
    init(array: [T]) {
        count = array.count
        data = array
        
        var i = (count - 1) / 2
        while i >= 0 {
            shiftDown(i)
            i -= 1
        }
    }
    
    func getData() -> [T] {
        return data
    }
    
    func size() -> Int {
        return count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    mutating func insert(_ e: T) {
        data.insert(e, at: count)
        count += 1
        
        shiftUp(count-1)
    }
    
    mutating func extractMin() -> T? {
        guard count > 0 else {
            return nil
        }
        
        let res = data.first
        (data[0], data[count - 1]) = (data[count - 1], data[0])
        count -= 1
        
        shiftDown(0)
        
        return res
    }
}
