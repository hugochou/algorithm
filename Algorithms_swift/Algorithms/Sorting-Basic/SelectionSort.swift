//
//  SelectionSort.swift
//  Algorithms
//
//  Created by Chris on 2017/8/22.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

    
//选择排序
func selectionSort<T: Comparable>(_ array: inout [T]) {
    
    let n = array.count
    for i in 0 ..< n {
        
        //寻找 [i, n) 区间里的最小值
        var tempIndex = i
        for j in i + 1 ..< n {
            if array[j] < array[tempIndex] {
                tempIndex = j
            }
        }
        
        ( array[i], array[tempIndex] ) = ( array[tempIndex], array[i] )
    }
}

func testSelectionSort() {
    
    var students = [
        Student(name:"A", score:78),
        Student(name:"B", score:88),
        Student(name:"C", score:78),
        Student(name:"D", score:68)
    ]
    selectionSort(&students)
    print(students)
}




