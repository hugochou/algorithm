//
//  MergeSort.swift
//  Algorithms
//
//  Created by Chris on 2017/8/23.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

// 归并排序
func mergeSort<T: Comparable>(_ array: inout [T]) {
    
    _mergeSort(array: &array, l: 0, r: array.count)
}

/// 递归使用归并排序，对 array[l..<r] 的范围进行排序
private func _mergeSort<T: Comparable>(array: inout [T], l: Int, r: Int) {
    
//    if r - l <= 1 { return }
    
    // 优化2：对于小数组, 使用插入排序优化
    if r - l <= 15 {
        insertionSort(&array, l: l, r: r)
        return
    }
    
    let mid = (l + r) / 2 // l + r 可能溢出的错误
    _mergeSort(array: &array, l: l, r: mid)
    _mergeSort(array: &array, l: mid, r: r)
    
    // 优化1： 对于arr[mid-1] <= arr[mid]的情况,不进行merge
    // 对于近乎有序的数组非常有效,但是对于一般情况,有一定的性能损失
    if array[mid - 1] > array[mid] {
        _merge(array: &array, l: l, mid: mid, r: r)
    }
}

/// 将 array[l..<mid] 和 array[mid..<r] 两部分进行归并
private func _merge<T: Comparable>(array: inout [T], l: Int, mid: Int, r: Int){
    
    var temp: [T] = array
    let n = r - l
    
    // 初始化，i指向左半部分的起始索引位置l；j指向右半部分起始索引位置mid
    var i = l, j = mid
    for k in 0 ..< n {
        
        if i >= mid { // 如果左半部分元素已经全部处理完毕
            array[k+l] = temp[j]
            j += 1
        }
        else if j >= r { // 如果右半部分元素已经全部处理完毕
            array[k+l] = temp[i]
            i += 1
        }
        else if temp[i] > temp[j] { //左半部分所指元素 > 右半部分所指元素
            array[k+l] = temp[j]
            j += 1
        }
        else { // 左半部分所指元素 <= 右半部分所指元素
            array[k+l] = temp[i]
            i += 1
        }
    }
}


// Merge Sort是一个O(nlogn)复杂度的算法
// 可以在1秒之内轻松处理100万数量级的数据(C++/Java, 但Swift测试百万级别需要200多秒！需设置：Optimization Level -> Fast, Whole Module Optimization)
// 注意：不要轻易尝试使用SelectionSort, InsertionSort或者BubbleSort处理100万级的数据
// 否则，你就见识了O(n^2)的算法和O(nlogn)算法的本质差异：）
func mergeSortTest() {
    
    let n = 100_000
    
    //测试1 一般性测试
    print("Test for random array, size = \(n), random range [0, \(n)]")
    var array = generateRandomArray(n: n, rangeL: 0, rangeR: n)
    
    testSort(name: "Merge Sort", caseArray: &array, sort: mergeSort)
}
