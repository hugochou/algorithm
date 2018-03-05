//
//  HeapSort.swift
//  Algorithms
//
//  Created by Chris on 2017/9/6.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

//将数组元素逐一插入堆中，然后排序
func heapSort1<T: Comparable>(_ array: inout [T]) {
    
    var maxheap = MaxHeap<T>()
    
    for item in array {
        maxheap.insert(item)
    }
    
    for i in stride(from: array.count - 1, through: 0, by: -1) {
        array[i] = maxheap.extractMax()
    }
}

//直接使用 heapify 过程将数组变成最大堆，然后排序
func heapSort2<T: Comparable>(_ array: inout [T]) {
    var maxheap = MaxHeap<T>(array:array)
    
    for i in stride(from: array.count - 1, through: 0, by: -1) {
        array[i] = maxheap.extractMax()
    }
}

//原地排序，不需额外开辟空间储存数组
func heapSort<T: Comparable>(_ array: inout [T]) {
    
    //转换成最大堆
    for i in stride(from: (array.count - 1) / 2, through: 0, by: -1) {
        _shiftDown(array: &array, index: i, count: array.count)
    }
    
    //排序：将根节点与最后节点交换，然后对array[0..<count-1]第一个元素做shiftDown操作，将array[0..<count-1]变为最大堆，重复这些操作
    for i in stride(from: array.count - 1, to: 0, by: -1) {
        (array[i], array[0]) = (array[0], array[i]);
        _shiftDown(array: &array, index: 0, count: i);
    }
}

private func _shiftDown<T: Comparable>(array: inout [T], index: Int, count: Int){
    
    var i = index
    let item = array[i]
    
    while i * 2 + 1 < count {
        
        //取左右节点中较大的一个
        var j = i * 2 + 1 //做节点所有
        if j + 1 < count && array[j] < array[j+1] {
            j = j + 1
        }
        
        if item >= array[j] { break }
        
        //子节点更大则交换
        array[i] = array[j]
        i = j
    }
    array[i] = item
}

func heapSort1Test(){
    
    let n = 100_000
    
    //测试1 一般性测试
    print("Test for random array, size = \(n), random range [0, \(n)]")
    var array = generateRandomArray(n: n, rangeL: 0, rangeR: n)
    var array1 = array
    var array2 = array
    
    testSort(name: "Heap Sort1", caseArray: &array, sort: heapSort1)
    testSort(name: "Heap Sort1", caseArray: &array1, sort: heapSort2)
    testSort(name: "Heap Sort1", caseArray: &array2, sort: heapSort)
}
