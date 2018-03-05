//
//  MergeSortBU.swift
//  Algorithms
//
//  Created by Chris on 2017/8/25.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation


// Merge Sort Bottom -> Up 优化
func mergeSortBU<T: Comparable>(_ array: inout [T]){
    
    let n = array.count
    var sz = 8
    while sz <= n {
        
        var i = 0
        while i + sz < n{
            
            // 优化2：对于小数组, 使用插入排序优化
            if sz == 8 {
                insertionSort(&array, l: i, r: min(i+sz+sz, n))
            }
            else {
                // 优化1： 对于arr[mid-1] <= arr[mid]的情况,不进行merge
                if array[i+sz-1] > array[i+sz] {
                    _merge(array: &array, l: i, mid: i + sz, r: min(i+sz+sz, n))
                }
            }
            i += sz + sz
        }
        
        sz += sz
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

// Merge Sort BU 也是一个O(nlogn)复杂度的算法，虽然只使用两重for循环
// 所以，Merge Sort BU也可以在1秒之内轻松处理100万数量级的数据
// 注意：不要轻易根据循环层数来判断算法的复杂度，Merge Sort BU就是一个反例
// 关于这部分陷阱，推荐看我的《玩转算法面试》课程，第二章：《面试中的复杂度分析》：）
func mergeSortBUTest() {
    
    let n = 10_000
    
    //测试1 一般性测试
    print("Test for random array, size = \(n), random range [0, \(n)]")
    var array1 = generateRandomArray(n: n, rangeL: 0, rangeR: n)
    var array2 = array1
    var array3 = array1
    
    testSort(name: "Insertion Sort", caseArray: &array1, sort: insertionSort)
    testSort(name: "Merge Sort", caseArray: &array2, sort: mergeSort)
    testSort(name: "Merge Sort BU", caseArray: &array3, sort: mergeSortBU)
}
