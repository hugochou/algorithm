//
//  MaxHeapHelper.swift
//  Algorithms
//
//  Created by Chris on 2017/8/30.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

extension MaxHeap {
    private func putNumberInLine(num: Int, line: String, indexCurLevel: Int, curTreeWidth: Int, isLeft: Bool) -> String {
        
        var line = line
        
        let subTreeWidth = (curTreeWidth - 1) / 2
        let offset = indexCurLevel * (curTreeWidth + 1) + subTreeWidth
        assert(offset + 1 < line.characters.count)
        let offsetIndex = line.index(line.startIndex, offsetBy: offset)
        
        if num >= 10 {
            
            line = line.substring(to: offsetIndex) + String(num) + line.substring(from: line.index(offsetIndex, offsetBy: 2))
        }
        else {
            if isLeft {
                line = line.substring(to: offsetIndex) + String(num) + line.substring(from: line.index(after: offsetIndex))
            }
            else {
                line = line.substring(to: line.index(after: offsetIndex)) + String(num) + line.substring(from: line.index(offsetIndex, offsetBy: 2))
            }
        }
        
        return line
    }
    
    private func putBranchInLine(line: String, indexCurLevel: Int, curTreeWidth: Int) -> String{
        
        var line = line
        
        let subTreeWidth = (curTreeWidth - 1) / 2
        let subSubTreeWidth = (subTreeWidth - 1) / 2
        let offsetLeft = indexCurLevel * (curTreeWidth+1) + subSubTreeWidth
        assert(offsetLeft + 1 < line.characters.count)
        let offsetLeftIndex = line.index(line.startIndex, offsetBy: offsetLeft)
        
        let offsetRight = indexCurLevel * (curTreeWidth+1) + subTreeWidth + 1 + subSubTreeWidth
        assert(offsetRight < line.characters.count)
        let offsetRightIndex = line.index(line.startIndex, offsetBy: offsetRight)
        
        line = line.substring(to: line.index(after: offsetLeftIndex)) + "/" + line.substring(from: line.index(offsetLeftIndex, offsetBy: 2));
        line = line.substring(to: offsetRightIndex) + "\\" + line.substring(from: line.index(after: offsetRightIndex));
        
        return line
    }
    
    func printTree() {
        
        if size() >= 100 {
            print("This print function can only work for less than 100 integer")
        }
        
        print("The max heap size is: \(size())")
        print("Data in the max heap: ")
        
        let data = getData()
        for i in 0 ..< size() {
            
            guard let di = data[i] as? Int else {
                return
            }
            assert(di >= 0 && di < 100)
            print(di, terminator: " ")
        }
        print()
        
        var n = size()
        var maxLevel = 0
        var numberPerLevel = 1
        while n > 0 {
            maxLevel += 1
            n -= numberPerLevel
            numberPerLevel *= 2
        }
        
        let maxLevelNumber = Int(pow(2.0, Double(maxLevel - 1)))
        var curTreeMaxLevelNumber = maxLevelNumber
        var index = 0
        for level in 0 ..< maxLevel {
            
            var line1 = String(repeating: " ", count: maxLevelNumber * 3 - 1)
            let curLevelNumber = min(size() - Int(pow(2.0, Double(level))) + 1, Int(pow(2.0, Double(level))))
            var isLeft = true
            for indexCurLevel in 0 ..< curLevelNumber {
                
                line1 = putNumberInLine(num: data[index] as! Int, line: line1, indexCurLevel: indexCurLevel, curTreeWidth: curTreeMaxLevelNumber*3-1, isLeft: isLeft)
                isLeft = !isLeft
                index += 1
            }
            print(line1)
            
            if level == maxLevel - 1 {
                break
            }
            
            var line2 = String(repeating: " ", count: maxLevelNumber * 3 - 1)
            for indexCurLevel in 0 ..< curLevelNumber {
                
                line2 = putBranchInLine(line: line2, indexCurLevel: indexCurLevel, curTreeWidth: curTreeMaxLevelNumber*3-1)
            }
            print(line2)
            
            curTreeMaxLevelNumber /= 2
        }
    }
}
