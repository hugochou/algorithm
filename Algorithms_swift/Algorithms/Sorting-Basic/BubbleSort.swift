//
//  BubbleSort.swift
//  Algorithms
//
//  Created by Chris on 2017/8/23.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//冒泡排序
func bubbleSort<T: Comparable>(_ array: inout [T]){
    
    let n = array.count
    for i in 0 ..< n {
        
        for j in 1 ..< n - i {
            
            if array[i] > array[j] {
                ( array[i], array[j] ) = ( array[j], array[i] )
            }
        }
    }
}

//当数据近乎有序的情况下，改进版的冒泡算法会比标准版节约时间
func bubbleSortPlus<T: Comparable>(_ array: inout [T]){
    
    var n = array.count
    var swapped: Bool!
    repeat {
        
        swapped = false
        for i in 1 ..< n {
            
            if array[i-1] > array[i] {
                
                ( array[i-1], array[i] ) = ( array[i], array[i-1] )
                swapped = true
            }
        }
        n -= 1
        
    } while swapped
}
