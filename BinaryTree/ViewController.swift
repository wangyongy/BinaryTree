//
//  ViewController.swift
//  BinaryTree
//
//  Created by wangyong on 2018/4/8.
//  Copyright © 2018年 ipanel. All rights reserved.
//

import UIKit

func Screen_width()->CGFloat{

    return UIScreen.main.bounds.size.width//屏幕宽度
}

func Screen_height()->CGFloat{

    return UIScreen.main.bounds.size.height//屏幕高度
}

func statusBarHeight()->CGFloat{

    return UIApplication.shared.statusBarFrame.height//状态栏高度
}
class ViewController: UIViewController {

    var swiftTree : BinaryTree?

    var ocTree : OCBinaryTree?

    let treeView = BinaryTreeView(frame: CGRect(x: 0, y: statusBarHeight(), width: Screen_width(), height: Screen_height() - statusBarHeight()))

    override func viewDidLoad() {

        super.viewDidLoad()

        createBinaryTree()

        view.backgroundColor = UIColor.white

        treeView.backgroundColor = UIColor.white

        view.addSubview(treeView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func createBinaryTree() {

        let dic = NSMutableDictionary()

        let maxNumber: UInt32 = 15

        for _ in 0...maxNumber {

            let num = NSNumber.init(value: arc4random()%maxNumber + 1)

            dic.setValue(num, forKey: String.init(format: "%@", num as CVarArg))
        }

        swiftTree = BinaryTree.create(array: dic.allValues as NSArray)

        swiftTree?.printSelf()

        showBinaryTree(tree: swiftTree!)    //在反转前将其绘制到屏幕上

        swiftTree?.reverse()

        print("\n\n==========反转二叉树==========");
        
        swiftTree?.printSelf()

        print("\n\n====================OC=======================");

        ocTree = OCBinaryTree.create(with: dic.allValues)

        ocTree?.print()

        ocTree?.reverse()

        print("\n\n==========反转二叉树==========");

        ocTree?.print()
    }
    /*
     * 把OCBinaryTree转化成BinaryTree
     */
    func convertTree(tree:OCBinaryTree) -> BinaryTree {

        let binaryTree = BinaryTree()

        binaryTree.value = tree.value

        binaryTree.leftTree = tree.left != nil ? convertTree(tree: tree.left) : nil

        binaryTree.rightTree = tree.right != nil ? convertTree(tree: tree.right) : nil

        return binaryTree
    }

    func showBinaryTree(tree:BinaryTree) {

        treeView.showTreeView(tree: tree)
    }

    // MARK:action
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        print("reset")

        createBinaryTree()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

