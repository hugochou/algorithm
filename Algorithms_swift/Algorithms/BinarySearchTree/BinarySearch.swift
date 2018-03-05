//
//  BinarySearch.swift
//  Algorithms
//
//  Created by Chris on 2017/9/11.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation


func binarySearch<T: Comparable>(_ array: [T], target: T) -> Int {
    
    //在 array[l..<r] 里查找 target
    var l = 0, r = array.count
    while l < r {
        
        // l+r 有可能会越界，所以用下面的方法取代 (l+r) / 2
        let mid = l + (r-l) / 2
        if array[mid] == target {
            return mid
        }
        
        if array[mid] < target {
            //在 array[l..<mid] 之间查找 targe
            r = mid
        }
        else {
            //在 array[mid+1..<r] 之间查找 target
            l = mid + 1
        }
    }
    
    return -1
}

func binarySearch2<T: Comparable>(_ array: [T], target: T) -> Int {
    return _binarySearch2(array, target: target, l: 0, r: array.count)
}

private func _binarySearch2<T: Comparable>(_ array: [T], target: T, l: Int, r: Int) -> Int {
    
    if l >= r { return -1 }
    
    let mid = l + (r - l) / 2
    if array[mid] == target {
        return mid
    }
    
    if array[mid] < target {
        return _binarySearch2(array, target: target, l: l, r: mid)
    }
    else {
        return _binarySearch2(array, target: target, l: mid + 1, r: r)
    }
}

private func _floorBinarySearch<T: Comparable>(_ array: [T], target: T, l: Int, r: Int) -> Int {
    
    if r - l == 1 {
        if array[r] == target {
            return r
        }
        return l
    }
    
    let mid = l + (r-l) / 2
    let midValue = array[mid]
    if target <= midValue {
        return _floorBinarySearch(array, target: target, l: l, r: mid)
    } else {
        return _floorBinarySearch(array, target: target, l: mid, r: r)
    }
}

func floorBinarySearch<T: Comparable>(_ array: [T], target: T) -> Int{
    
    assert(array.count > 0)
    
    return _floorBinarySearch(array, target: target, l: 0, r: array.count)
    
//    if array.last! <= target {return array.count - 1}
//    
//    var l = 0, r = array.count
//    while l < r && array[r-1] >= target {
//        
//        let mid = l + (r - l) / 2
//        if target <= array[mid] {
//            r = mid
//        }
//        else {
//            l = mid + 1
//        }
//        
//    }
//    return array[r] == target ? r : r - 1;
}


private func _ceilBinarySearch<T: Comparable>(_ array: [T], target: T, l: Int, r: Int) -> Int{
    if r - l == 1 {
        if array[l] == target {
            return l
        }
        return r
    }
    
    let mid = l + (r - l) / 2
    let midValue = array[mid]
    if target < midValue {
        return _ceilBinarySearch(array, target: target, l: l, r: mid)
    }
    else {
        return _ceilBinarySearch(array, target: target, l: mid, r: r)
    }
}

func ceilBinarySearch<T: Comparable>(_ array: [T], target: T) -> Int{
    
    assert(array.count > 0)
    
    return _ceilBinarySearch(array, target: target, l: 0, r: array.count)
    
//    if array.first! >= target {return 0}
//    
//    var l = 0, r = array.count
//    while l < r && array[l] <= target {
//        
//        let mid = l + (r - l) / 2
//        if target < array[mid] {
//            r = mid
//        }
//        else {
//            l = mid+1
//        }
//        
//    }
//    return array[l-1] == target ? l-1 : l;
}


func floorBinarySearchTest()
{
    let n = 30
    
    //测试1 一般性测试
    print("Test for random array, size = \(n), random range [0, \(n)]")
    var array1 = generateRandomArray(n: n, rangeL: 0, rangeR: n)
    
    testSort(name: "Merge Sort", caseArray: &array1, sort: quickSort)
    
    print(array1);
    print(floorBinarySearch(array1, target: 25))
}
