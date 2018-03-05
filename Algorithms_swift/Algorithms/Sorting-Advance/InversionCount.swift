//
//  InversionCount.swift
//  Algorithms
//
//  Created by Chris on 2017/8/25.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation


// 计算逆序对总数
func inversionCount<T: Comparable>(_ array: inout [T]) -> Int {
    return _mergeSort(array: &array, l: 0, r: array.count)
}

private func _mergeSort<T: Comparable>(array: inout [T], l: Int, r: Int) -> Int{
    
    if r - l <= 1 { return 0 }
    
    let mid = (l + r) / 2
    let a = _mergeSort(array: &array, l: l, r: mid)
    let b = _mergeSort(array: &array, l: mid, r: r)
    
    return a + b + _merge(array: &array, l: l, mid: mid, r: r)
}

private func _merge<T: Comparable>(array: inout [T], l: Int, mid: Int, r: Int) -> Int {
    
    let aux = Array(array[l ..< r])
    
    var count = 0
    var i = l, j = mid
    for k in l ..< r {
        
        if i >= mid {
            array[k] = aux[j-l]
            j += 1
        }
        else if j >= r {
            array[k] = aux[i-l]
            i += 1
        }
        else if aux[i-l] > aux[j-l] {
            array[k] = aux[j-l]
            j += 1
            // 此时, 因为右半部分k所指的元素小
            // 这个元素和左半部分的所有未处理的元素都构成了逆序数对
            // 左半部分此时未处理的元素个数为 mid - i
            count += mid - i
        }
        else {
            array[k] = aux[i-l]
            i += 1
        }
    }
    
    return count
}


func inversionCountTest() {
    
    let n = 100_000
    
    //测试1 一般性测试
    var array = generateRandomArray(n: n, rangeL: 0, rangeR: n)
    print("Test Inversion Count for Random Array, n = \(n) :\(inversionCount(&array))")
    
    // 测试2: 测试完全有序的数组
    // 结果应该为0
    array = generateOrderedArray(n)
    print("Test Inversion Count for Ordered Array, n = \(n) :\(inversionCount(&array))")
    
    // 测试3: 测试完全逆序的数组
    // 结果应改为 N*(N-1)/2
    array = generateInversedArray(n)
    print("Test Inversion Count for Inversed Array, n = \(n) :\(inversionCount(&array))")
}
