//
//  QuickSort.swift
//  Algorithms
//
//  Created by Chris on 2017/8/24.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

// 快速排序
func quickSort<T: Comparable>(_ array: inout [T]){
    
    _quickSort(array: &array, l: 0, r: array.count)
}

/// 对 array[l..<r] 进行快速排序
private func _quickSort<T: Comparable>(array: inout [T], l: Int, r: Int){
    
//    if r - l <= 1 { return }
    //优化：对于小规模数组, 使用插入排序
    if r - l <= 15 {
        insertionSort(&array, l: l, r: r)
        return
    }
    
    let p = _partition(array: &array, l: l, r: r)
    
    _quickSort(array: &array, l: l, r: p)
    _quickSort(array: &array, l: p + 1, r: r)
}

/// 对 array[l..<r] 进行 partition 操作：以第一个元素A作为参照，比A小放在A的左边，比A大放A的在右边
/// - Returns: p，使得 array[l..<p] < array[p]；array[p+1..<r] > array[p]
private func _partition<T: Comparable>(array: inout [T], l: Int, r: Int) -> Int{
    
    // 优化：对于近乎有序的数据，快速排序的时间会退化为O(n^2)级别，改进的方式是随机选取标定点
    // 随机在arr[l...r]的范围中, 选择一个数值作为标定点pivot
    let pivot = Int(arc4random()) % (r - l) + l
    ( array[l], array[pivot] ) = ( array[pivot], array[l] )
    
    let v = array[l]
    
    // array[l..<j] < array[j]; array[j+1..<i] > array[j]
    var j = l //分界点
    for i in l+1 ..< r { //i 表示当前访问的位置
        
        if array[i] < v {
            ( array[i], array[j+1] ) = ( array[j+1], array[i] )
            j += 1
        }
    }
    ( array[l], array[j] ) = ( array[j], array[l] )
    
    return j
}



// 针对存在大量重复元素的数据，快速排序也可能会退化到O(n^2)级别，改进方式是使用双路快速排序法
// 双路快速排序算法也是一个O(nlogn)复杂度的算法
func quickSort2<T: Comparable>(_ array: inout [T]){
    _quickSort2(array: &array, l: 0, r: array.count)
}

private func _quickSort2<T: Comparable>(array: inout [T], l: Int, r: Int){
    
    if r - l <= 15 {
        insertionSort(&array, l: l, r: r)
        return
    }
    
    let p = _partition2(array: &array, l: l, r: r)
    
    _quickSort2(array: &array, l: l, r: p)
    _quickSort2(array: &array, l: p+1, r: r)
    
}

// 双路快速排序的partition
// 返回p, 使得arr[l...p] < arr[p] ; arr[p+1...r] > arr[p]
private func _partition2<T: Comparable>(array: inout [T], l: Int, r: Int) -> Int{
    
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



// ============ 三路快速排序法 ===================
// 三路快速排序算法也是一个O(nlogn)复杂度的算法
func quickSort3<T: Comparable>(_ array: inout [T]){
    
    _quickSort3(array: &array, l: 0, r: array.count)
}

private func _quickSort3<T: Comparable>(array: inout [T], l: Int, r: Int) {
    
    if r - l <= 15 {
        insertionSort(&array, l: l, r: r)
        return
    }
    
    let (lt, gt) = _partition3(array: &array, l: l, r: r)
    
    _quickSort3(array: &array, l: l, r: lt)
    _quickSort3(array: &array, l: gt, r: r)
    
}

private func _partition3<T: Comparable>(array: inout [T], l: Int, r: Int) -> (Int, Int){
    
    let temp = Int(arc4random()) % (r - l) + l
    ( array[l], array[temp] ) = ( array[temp], array[l] )
    
    let v = array[l]
    
    var lt = l      // array[l+1...lt] < v
    var gt = r      // array[gt..<r] > v
    var i  = l + 1  // array[lt+1..<i] = v
    
    while i < gt {
        if array[i] < v {
            
            ( array[i], array[lt+1] ) = ( array[lt+1], array[i] )
            lt += 1
            i += 1
        }
        else if array[i] > v {
            
            ( array[i], array[gt-1] ) = ( array[gt-1 ], array[i] )
            gt -= 1
        }
        else {
            i += 1
        }
    }
    
    ( array[l], array[lt] ) = ( array[lt], array[l] )
    
    return (lt, gt)
}


func quickSortTest(){
    
    let n = 1_000_000
    
    //测试1 一般性测试
    print("Test for random array, size = \(n), random range [0, \(n)]")
    var array1 = generateRandomArray(n: n, rangeL: 0, rangeR: n)
    var array2 = array1
    var array3 = array1
    
    testSort(name: "Merge Sort", caseArray: &array1, sort: quickSort)
    testSort(name: "Quick Sort 2", caseArray: &array2, sort: quickSort2)
    testSort(name: "Quick Sort 3", caseArray: &array3, sort: quickSort3)
    
    //测试2 测试近乎有序数组
    let swapTimes = 100
    print("Test for random nearly ordered array, size = \(n), random range [0, \(n)], swap times = \(swapTimes)")
    array1 = generateNearlyOrderedArray(n: n, swapTimes: swapTimes)
    array2 = array1
    array3 = array1
    
    testSort(name: "Merge Sort", caseArray: &array1, sort: quickSort)
    testSort(name: "Quick Sort 2", caseArray: &array2, sort: quickSort2)
    testSort(name: "Quick Sort 3", caseArray: &array3, sort: quickSort3)
    
    
    //测试3 测试包含大量相同元素的数组
    print("Test for random array with large samll elements, size = \(n), random range [0, \(n)]")
    array1 = generateRandomArray(n: n, rangeL: 0, rangeR: 10)
    array2 = array1
    array3 = array1

    testSort(name: "Merge Sort", caseArray: &array1, sort: quickSort)
    testSort(name: "Quick Sort 2", caseArray: &array2, sort: quickSort2)
    testSort(name: "Quick Sort 3", caseArray: &array3, sort: quickSort3)

}









