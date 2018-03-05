//
//  InsertionSort.swift
//  Algorithms
//
//  Created by Chris on 2017/8/23.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//插入排序：对于近乎有序的数据进行插入排序会很快，因为由某个位置开始前面的数据已有序，所以内层循环会判断到某个位置就不再需要再循环比较
//如果针对已有序的数据进行插入排序，耗时将是O(n)。因为只需要执行外层循环

func insertionSort<T: Comparable>(_ array: inout [T]) {
    
    let n = array.count
    for i in 1 ..< n {
        
        //寻找元素 array[i] 适合的插入位置
        for j in stride(from: i, to: 0, by: -1) {
            
            //直接使用 if 判断比在 for 循环中使用 where 判断快百倍（Swift 3）测试
            if array[j] < array[j-1] {
                (array[j], array[j-1]) = (array[j-1], array[j])
            }
            else {
                break
            }
        }
        
    }
}

//改进：将每次比较后的交换（一次交换 = 三次赋值），改为赋值
func insertionSortPlus<T: Comparable>(_ array: inout [T]) {
    
    let n = array.count
    for i in 1 ..< n {
        
        //寻找元素 array[i] 适合的插入位置
        let tempItem = array[i]
        var tempIndex = i //保存元素 array[i] 应该插入的位置
        for j in stride(from: i - 1, through: 0, by: -1) {
            
            if array[j] > tempItem {
                array[tempIndex] = array[j]
                tempIndex = j
            }
            else {
                break
            }
        }
        
        array[tempIndex] = tempItem
    }
}

///对 array[l..<r] 进行插入排序
func insertionSort<T: Comparable>(_ array: inout [T], l: Int, r: Int){
    
    if r - l <= 1 { return }
    
    for i in l+1 ..< r {
        
        let tempItem = array[i]
        var tempIndex = i
        for j in stride(from: i - 1, through: l, by: -1){
            
            if array[j] > tempItem {
                array[tempIndex] = array[j]
                tempIndex = j
            }
            else {
                break
            }
        }
        
        array[tempIndex] = tempItem
    }
}
