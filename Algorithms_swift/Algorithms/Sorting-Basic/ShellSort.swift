//
//  ShellSort.swift
//  Algorithms
//
//  Created by Chris on 2017/8/23.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation


/// 希尔排序
/// 介绍：http://www.cnblogs.com/jingmoxukong/p/4303279.html
func shellSort<T: Comparable>(_ array: inout [T]) {
    
    let n = array.count
    
    // 计算增量序列: 1, 4, 13, 40, 121, 364, 1093...
    var h = 1;
    while h < n / 3 {
        h = 3 * h + 1
    }
    
    while h >= 1  {
        
        //把元素下标距离为 h 的分为一组，对每组进行插入排序
        for i in h ..< n {
            
            // 对 arr[i], arr[i-h], arr[i-2*h], arr[i-3*h]... 使用插入排序
            let tempItem = array[i]
            var tempIndex = i
            for j in stride(from: i - h, through: 0, by: -h) {
                
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
        
        //减小增量
        h /= 3
    }
}
