//
//  Selection.swift
//  Algorithms
//
//  Created by Chris on 2017/8/25.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

// 求出数组里第k小的数
func selection<T: Comparable>(_ array: inout [T], k: Int) -> T{
    
    assert(k >= 0 && k < array.count)
    
    return _selection(array: &array, l: 0, r: array.count, k: k)
}

private func _selection<T: Comparable>(array: inout [T], l: Int, r: Int, k: Int) -> T {
    
    if r - l <= 1 { return array[l] }
    
    let p = _partition(array: &array, l: l, r: r, k: k)
    
    if p == k {
        return array[p]
    }
    else if k > p {
        return _selection(array: &array, l: p + 1, r: r, k: k)
    }
    else {
        return _selection(array: &array, l: l, r: p, k: k)
    }
    
}

private func _partition<T: Comparable>(array: inout [T], l: Int, r: Int, k: Int) -> Int {
    
    let temp = Int(arc4random()) % (r - l) + l
    ( array[l], array[temp] ) = ( array[temp], array[l] )
    
    let v = array[l]
    
    // array[l+1..<i] < v; array[j+1..<r] > v
    var i = l+1, j = r - 1
    while true {
        
        while i < r && array[i] < v { i += 1 }
        while j > l && array[j] > v { j -= 1 }
        
        if i > j { break }
        
        ( array[i], array[j] ) = ( array[j], array[i] )
        i += 1
        j -= 1
    }
    
    ( array[l], array[j] ) = ( array[j], array[l] )
    
    return j
}


func selectionTest() {
    
    let n = 100
    
    var array = generateOrderedArray(n)
    shuffleArray(&array)
    
    for i in 0..<n {
        
        let num = selection(&array, k: i)
        if num != i {
            break
        }
        print("test i:\(i) num:\(num) complete")
    }
}
