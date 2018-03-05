//
//  Student.swift
//  Algorithms
//
//  Created by Chris on 2017/8/22.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

struct Student: Comparable, CustomStringConvertible {
    var name: String
    var score: Int
    
    var description: String {
        return "\(name):\(score)"
    }
    
    static func ==(left: Student, right: Student) -> Bool {
        return left.score == right.score && left.name == right.name
    }
    
    static func <(left: Student, right: Student) -> Bool {
        if left.score == right.score {
            return left.name < right.name
        }
        return left.score < right.score
    }
}
