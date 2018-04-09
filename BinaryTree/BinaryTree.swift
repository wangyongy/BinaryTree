//
//  BinaryTree.swift
//  BinaryTree
//
//  Created by wangyong on 2018/4/8.
//  Copyright © 2018年 ipanel. All rights reserved.
//

import UIKit

class BinaryTree: NSObject {

    var value = 0

    var leftTree: BinaryTree?

    var rightTree: BinaryTree?

    var isFirst: Bool?

    /*
     *  @param array:无序正整数NSNumber数组,数组中的第一个值为根节点
     *
     *  @return 有序二叉树,左<根<右
     */
    class func create(array:NSArray) -> BinaryTree? {

        if array.count == 0 {

            return nil
        }

        let treeModel = BinaryTree()

        for i in array {

            let value: Int = Int(truncating: i as! NSNumber)

            createBinaryTree(value: value, treeModel: treeModel)
        }

        return treeModel
    }

    class func createBinaryTree(value:Int , treeModel:BinaryTree) {

        if treeModel.value <= 0 {

            treeModel.value = value

            return
        }

        let midValue = treeModel.value

        if value < midValue {

            if (treeModel.leftTree == nil){

                treeModel.leftTree = BinaryTree()

                treeModel.leftTree?.value = value

                return

            }else{

                createBinaryTree(value: value, treeModel: treeModel.leftTree!)
            }

        }else{

            if (treeModel.rightTree == nil){

                treeModel.rightTree = BinaryTree()

                treeModel.rightTree?.value = value

                return

            }else{

                createBinaryTree(value: value, treeModel: treeModel.rightTree!)
            }
        }
    }

    //深度
    func depth() -> Int {

       return 1 + max((leftTree != nil ? leftTree!.depth() : 0), (rightTree != nil ? rightTree!.depth() : 0))
    }

    //所有节点数
    func length() -> Int {

        return 1 + (leftTree != nil ? leftTree!.length() : 0) + (rightTree != nil ? rightTree!.length() : 0)
    }

    //满二叉树所有节点数
    func maxLength() -> Int {

        var depth = self.depth()

        var maxLength = 0

        while depth > 0 {

            maxLength = (maxLength) + Int(pow(2.0,Double(depth - 1)))

            depth = depth - 1;
        }

        return maxLength
    }

    func reverse() {

        let tempRightTree = rightTree

        rightTree = leftTree

        leftTree = tempRightTree

        leftTree?.reverse()

        rightTree?.reverse()

    }
    /*
     *  打印详情
     */
    func printSelf(){

        print("length:\(length())    depth:\(depth())")

        print("先序遍历:");

        prePrint()

        print("\n非递归先序遍历:");

        prePrintWithoutRecursion()

        print("\n中序遍历:");

        midPrint()

        print("\n非递归中序遍历:");

        midPrintWithoutRecursion()

        print("\n后序遍历:");

        sufPrint()

        print("\n非递归后序遍历:");

        sufPrintWithoutRecursion()

        print("\n非递归后序遍历且不带isFirst参数:");

        sufPrintWithoutRecursionAndParam()

    }
    /*
     *  先序遍历
     */
    func prePrint() {

        print(" \(value) ", terminator: "")//不换行打印

        leftTree?.prePrint()

        rightTree?.prePrint()
    }
    /*
     *  中序遍历
     */
    func midPrint() {

        leftTree?.midPrint()

        print(" \(value) ", terminator: "")

        rightTree?.midPrint()
    }
    /*
     *  后序遍历
     */
    func sufPrint() {

        leftTree?.sufPrint()

        rightTree?.sufPrint()

        print(" \(value) ", terminator: "")
    }
    /*
     *  非递归先序遍历
     */
    func prePrintWithoutRecursion() {

        let treeArray = NSMutableArray()

        var tree: BinaryTree? = self

        while (tree != nil || treeArray.count > 0) {

            while tree != nil {

                print(" \(tree!.value) ", terminator: "")

                treeArray.add(tree!)

                tree = tree!.leftTree
            }

            if treeArray.count > 0 {

                tree = (treeArray.lastObject as! BinaryTree)

                tree = tree?.rightTree

                treeArray.removeLastObject()
            }
        }
    }
    /*
     *  非递归中序遍历
     */
    func midPrintWithoutRecursion() {

        let treeArray = NSMutableArray()

        var tree: BinaryTree? = self

        while (tree != nil || treeArray.count > 0) {

            while tree != nil {

                treeArray.add(tree!)

                tree = tree!.leftTree
            }

            if treeArray.count > 0 {

                tree = (treeArray.lastObject as! BinaryTree)

                print(" \(tree!.value) ", terminator: "")

                tree = tree?.rightTree

                treeArray.removeLastObject()
            }
        }
    }
    /*
     *  非递归后序遍历,加一个isFirst参数,根据书上逻辑改动
     */
    func sufPrintWithoutRecursion() {

        let treeArray = NSMutableArray()

        var tree: BinaryTree? = self

        while (tree != nil || treeArray.count > 0) {

            while tree != nil {

                treeArray.add(tree!)

                tree!.isFirst = true

                tree = tree!.leftTree
            }

            if treeArray.count > 0 {

                tree = (treeArray.lastObject as! BinaryTree)

                if tree!.isFirst! {

                    tree!.isFirst = false

                    tree = tree!.rightTree

                }else{

                    print(" \(tree!.value) ", terminator: "")

                    treeArray.removeLastObject()

                    tree = nil
                }
            }
        }
    }
    /*
     *  非递归后序遍历,不带isFirst参数
     */
    func sufPrintWithoutRecursionAndParam() {

        let treeArray = NSMutableArray()

        var curTree: BinaryTree?

        var preTree: BinaryTree?

        treeArray.add(self)

        while treeArray.count > 0 {

            curTree = (treeArray.lastObject as! BinaryTree)

            if ((curTree!.leftTree == nil && curTree!.rightTree == nil) || (preTree != nil && (preTree == curTree!.leftTree || preTree == curTree!.rightTree))){

                print(" \(curTree!.value) ", terminator: "")

                treeArray.removeLastObject()

                preTree = curTree!

            }else{

                if curTree!.rightTree != nil{

                    treeArray.add((curTree!.rightTree)!)
                }

                if curTree!.leftTree != nil{

                    treeArray.add((curTree!.leftTree)!)
                }
            }
        }
    }
}
