
//  SortTestHelper.swift
//  Algorithms
//
//  Created by Chris on 2017/8/22.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation
import QuartzCore

func generateRandomArray(n: Int, rangeL: Int, rangeR: Int) -> [Int] {
    
    assert(rangeL < rangeR)
    
    var array: [Int] = []
    
    for _ in 0 ..< n {
        array.append(Int(arc4random()) % (rangeR - rangeL + 1) + rangeL)
    }
    
    return array
}

func generateNearlyOrderedArray(n: Int, swapTimes: Int) -> [Int]{
    
    var array: [Int] = []
    
    for i in 0 ..< n {
        array.append(i)
    }
    
    for _ in 0 ..< swapTimes {
        let i = Int(arc4random()) % n
        let j = Int(arc4random()) % n
        ( array[i], array[j] ) = ( array[j], array[i])
    }
    
    return array
}

func generateOrderedArray(_ n: Int) -> [Int] {
    
    var array: [Int] = []
    
    for i in 0 ..< n {
        array.append(i)
    }
    
    return array
}

func generateInversedArray(_ n: Int) -> [Int] {
    
    var array: [Int] = []
    
    for i in stride(from: n - 1, through: 0, by: -1) {
        array.append(i)
    }
    
    return array
}

func shuffleArray(_ array: inout [Int]) {
    
    let n = array.count
    for i in 0 ..< n {
        
        let j = Int(arc4random()) % (n - i) + i
        (array[i], array[j]) = (array[j], array[i])
    }
}

func isSorted<T: Comparable>(_ array: [T]) -> Bool {
    for i in 0 ..< array.count - 1 {
        if array[i] > array[i + 1] {
            print(i)
            return false
        }
    }
    return true
}

func testSort<T: Comparable>(name: String, caseArray: inout [T], sort:(inout [T]) -> ()) {
    
    let startTime = CACurrentMediaTime()
    sort(&caseArray)
    let endTime = CACurrentMediaTime()
    
    assert(isSorted(caseArray))
    
    print("\(name) : \(endTime - startTime) s")
}
