//
//  BinarySearchTree.swift
//  Algorithms
//
//  Created by Chris on 2017/9/12.
//  Copyright © 2017年 Chris. All rights reserved.
//

import Foundation

class BST<Key:Comparable, Value>{
    
    private class Node<Key:Comparable, Value> {
        
        var key: Key
        var value: Value
        var left: Node?
        var right: Node?
        var count = 1 //二分搜索树的节点总数
        var repeatCount = 1 //重复节点的个数（没实现，会影响 insert/remove/rank/select 等方法）
        
        init(key: Key, value: Value) {
            self.key = key
            self.value = value
        }
    }
    
    private var root: Node<Key, Value>?
    private var count = 0
    
    
    /// 以递归形式：向以 node 为根的二叉搜索树中，插入节点（key, value）
    /// - Returns: 返回插入新节点后的二叉搜索树的根
    private func _insert(node:Node<Key, Value>?, key:Key, value: Value) -> Node<Key, Value> {
        
        guard let node = node else {
            count += 1;
            return Node<Key, Value>(key:key, value:value)
        }
        
        if !contain(key: key) {
            node.count += 1
        }
        
        if key == node.key {
            node.value = value
        }
        else if key < node.key {
            node.left = _insert(node: node.left, key: key, value: value)
        }
        else {
            node.right = _insert(node: node.right, key: key, value: value)
        }
        return node
    }
    
    /// 非递归模式：向以 node 为根的二叉搜索树中，插入节点（key, value）
    /// - Returns: 返回插入新节点后的二叉搜索树的根
    func insert2(key:Key, value:Value) {
        
        let newNode = Node<Key, Value>(key:key, value:value)
        guard var node = root else {
            count = 1
            root = newNode
            return
        }
        
        while key != node.key {
            if key < node.key {
                if let left = node.left {
                    node = left
                }
                else {
                    node.left = newNode
                    node.count += 1
                    count += 1
                    return
                }
            }
            else {
                if let right = node.right {
                    node = right
                }
                else {
                    node.right = newNode
                    node.count += 1
                    count += 1
                    return
                }
            }
        }
        node.value = value
    }
    
    ///判断以 node 为根的二分搜索树里是否包含键为 key 的元素
    private func _contain(node: Node<Key, Value>?, key: Key) -> Bool {
        
        guard let node = node else {
            return false
        }
        
        if key == node.key {
            return true
        }
        else if key < node.key {
            return _contain(node: node.left, key: key)
        }
        else {
            return _contain(node: node.right, key: key)
        }
    }
    
    ///在以 node 为根的二分搜索树里搜索键为 key 的元素的值
    private func _search(node: Node<Key, Value>?, key: Key) -> Value? {
        guard let node = node else {
            return nil
        }
        
        if key == node.key {
            return node.value
        }
        else if key < node.key {
            return _search(node: node.left, key: key)
        }
        else {
            return _search(node: node.right, key: key)
        }
    }
    
    ///对以 node 为根的二分搜索树进行前序遍历
    private func _preOrder(node: Node<Key, Value>?) {
        guard let node = node else {
            return
        }
        
        print(node.key)
        _preOrder(node: node.left)
        _preOrder(node: node.right)
    }
    
    ///对以 node 为根的二分搜索树进行中序遍历
    private func _inOrder(node: Node<Key, Value>?) {
        guard let node = node else {
            return
        }
        
        _inOrder(node: node.left)
        print(node.key)
        _inOrder(node: node.right)
    }
    
    ///对以 node 为根的二分搜索树进行后序遍历
    private func _postOrder(node: Node<Key, Value>?) {
        guard let node = node else {
            return
        }
        
        _postOrder(node: node.left)
        _postOrder(node: node.right)
        print(node.key)
    }
    
    
    /// 从以 node 为根的二分搜索树中找出最大值的节点
    private func _minimum(node: Node<Key, Value>) -> Node<Key, Value> {
        
        if let left = node.left {
            return _minimum(node: left)
        }
        return node
    }
    
    private func _maximum(node: Node<Key, Value>) -> Node<Key, Value> {
        
        if let right = node.right {
            return _maximum(node: right)
        }
        
        return node
    }
    
    /// 删除以 node 为根的二分搜索树中的最小节点
    /// - Returns: 返回删除节点后新的二分搜索树的根
    private func _removeMin(node: Node<Key, Value>) -> Node<Key, Value>?{
        
        if node.left == nil {
            count -= 1
            node.count -= 1
            return node.right
        }
        
        return _removeMin(node: node.left!)
    }
    
    /// 删除以 node 为根的二分搜索树中的最大节点
    /// - Returns: 返回删除节点后新的二分搜索树的根
    private func _removeMax(node: Node<Key, Value>) -> Node<Key, Value>? {
        if node.right == nil {
            count -= 1
            node.count -= 1
            return node.left
        }
        return _removeMax(node: node.right!)
    }
    
    //前驱
    private func predecessor(node: Node<Key, Value>) -> Node<Key, Value>? {
        
        if let left = node.left {
            return _maximum(node: left)
        }
        return nil
    }
    
    //后继
    private func successor(node: Node<Key, Value>) -> Node<Key, Value>? {
        
        if let right = node.right {
            return _minimum(node: right)
        }
        
        return nil
    }
    
    
    /// 从以 node 为根的二分搜索树中删除键为 key 的节点
    ///
    /// - Parameters:
    ///   - node: 根
    ///   - key: 要删除的节点的键
    /// - Returns: 返回删除节点后新的二分搜索树的根
    private func _remove(node: Node<Key, Value>?, key: Key) -> Node<Key, Value>? {
        
        guard let node = node else {
            return nil
        }
        
        if contain(key: key) {
            node.count -= 1
        }
        
        if key < node.key {
            node.left = _remove(node: node.left, key: key)
            return node
        }
        else if key > node.key {
            node.right = _remove(node: node.right, key: key)
            return node
        }
        else { // key = node.key
            
            //Hubbard Deletion：以将被删除的节点的右节点的最小值节点作为后继节点（替代被删除节点）
            if let successor = self.successor(node: node) {
                successor.right = _removeMin(node: node.right!)
                successor.left = node.left
                return successor
            } else {
                //没有后继，则直接删除节点，用左子树的根替代被删除的节点
                count -= 1
                return node.left
            }
        }
        
    }
    
    private func _floor(node: Node<Key, Value>, key: Key) -> Node<Key, Value>? {
        
        if key < node.key {
            if let left = node.left {
                return _floor(node: left, key: key)
            }
            else {
                return nil
            }
        }
        if key > node.key, let right = node.right{
            return _floor(node: right, key: key)
        }
        return node
    }
    
    private func _ceil(node: Node<Key, Value>, key: Key) -> Node<Key, Value>? {
        
        if key < node.key, let left = node.left {
            return _ceil(node: left, key: key)
        }
        if key > node.key {
            if let right = node.right {
                return _ceil(node: right, key: key)
            }
            return nil
        }
        return node
    }
    
    //在以 node 为根的二分搜索树中检查键为 key 的节点的排名
    private func _rank(node: Node<Key, Value>?, key: Key) -> Int? {
        guard let node = node else {
            return nil
        }
        
        if key < node.key {
            return _rank(node: node.left, key: key)
        }
        else if key > node.key {
            if let rank = _rank(node: node.right, key: key) {
                return node.count + rank + 1
            }
            else {
                return nil
            }
        }
        else {
            if let left = node.left{
                return left.count + 1
            }
            return 1
        }
        
    }
    
    //在以 node 为根的二分搜索树中找出排名第 n 位的节点
    private func _select(node: Node<Key, Value>, n: Int) -> Node<Key, Value> {
        
        if n == 1 {
            return _minimum(node: node)
        }
        if n == node.count {
            return _maximum(node: node)
        }
        
        if let left = node.left {
            if n < left.count {
                return _select(node: left, n: n)
            }
            else {
                let llcount = left.left == nil ? 1 : left.left!.count
                return _select(node: node.right!, n: n - llcount)
                
            }
        }
        else {
            return _select(node: node.right!, n: n-1)
        }
    }
    
    ///元素个数
    func size() -> Int {
        return count
    }
    
    ///是否为空
    func isEmpty() -> Bool {
        return count == 0
    }
    
    ///向二分搜索树插入节点 (key, value)
    func insert(key: Key, value: Value) {
        
        root = _insert(node: root, key:key, value:value)
    }
    
    ///判断二分搜索树是否包含键为 key 的节点
    func contain(key: Key) -> Bool {
        return _contain(node: root, key: key)
    }
    
    ///搜索键为 key 的节点的值
    func search(key: Key) -> Value? {
        return _search(node: root, key: key)
    }
    
    ///前序遍历（深度优先遍历）
    func preOrder() {
        _preOrder(node: root)
    }
    
    ///中序遍历（深度优先遍历）
    func inOrder() {
        _inOrder(node: root)
    }
    
    ///后序遍历（深度优先遍历）
    func postOrder() {
        _postOrder(node: root)
    }
    
    ///层序遍历：广度优先遍历
    func levelOrder() {
        guard let root = self.root else {
            return
        }
        
        var queue = Array<Node<Key, Value>>()//先进先出队列，存储当前节点的左右子节点
        queue.append(root)
        while queue.count > 0 {
            
            let node = queue.first!
            queue.removeFirst()
            print(node.key)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
    
    ///递归模式：找出最小值
    func minimum() -> Key? {
        
        guard let root = root else {
            return nil
        }
        return _minimum(node: root).key
    }
    ///非递归模式：找出最小值
    func minimum2() -> Key? {
        
        guard var node = root else {
            return nil
        }
        
        while node.left != nil {
            node = node.left!
        }
        
        return node.key
    }
    
    func maximum() -> Key? {
        guard let node = root else {
            return nil
        }
        
        return _maximum(node: node).key
    }
    
    ///非递归模式：找出最大值
    func maximum2() -> Key? {
        
        guard var node = root else {
            return nil
        }
        
        while node.right != nil {
            node = node.right!
        }
        return node.key
    }
    
    ///从二分搜索树中删除最小值的节点
    func removeMin() {
        
        if root != nil {
            root = _removeMin(node:root!)
        }
    }
    
    ///从二分搜索树中删除最大值的节点
    func removeMax() {
        if root != nil {
            root = _removeMax(node: root!)
        }
    }
    
    /// 从二分搜索树种删除健为 key 的节点
    func remove(key: Key) {
        if root != nil {
            root = _remove(node: root!, key: key)
        }
    }
    
    
    //找出小于或等于键为 key 的节点值的最大节点
    func floor(key: Key) -> Value? {
        guard let node = root else {
            return nil
        }
        return _floor(node: node, key: key)?.value
    }
    
    //找出大于或者等于键为 key 的节点值的最小节点
    func ceil(key:Key) -> Value? {
        guard let node = root else {
            return nil
        }
        return _ceil(node: node, key: key)?.value
    }
    
    //检查键为 key 的节点的排名
    func rank(key: Key) -> Int? {
        return _rank(node: root, key: key);
    }
    
    //找出排序第 n 的节点键
    func select(_ n: Int) -> Key? {
        guard let node = root else {
            return nil
        }
        return _select(node: node, n: n).key
    }
    
    
    static func test() {
        let bst = BST<Int, Int>()
        for _ in 0..<100 {
            bst.insert(key:  Int(arc4random() % 20), value: Int(arc4random() % 100))
        }
    }
}
