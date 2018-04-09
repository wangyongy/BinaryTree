//
//  ViewController.swift
//  BinaryTree
//
//  Created by wangyong on 2018/4/8.
//  Copyright © 2018年 ipanel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tree : BinaryTree?
    var ocTree : OCBinaryTree?

    override func viewDidLoad() {
        super.viewDidLoad()

        createBinaryTree()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func createBinaryTree() {

        let dic = NSMutableDictionary()

        for _ in 0...20 {

            let num = NSNumber.init(value: arc4random()%20 + 1)

            dic.setValue(num, forKey: String.init(format: "%@", num as CVarArg))
        }

        print(dic.allValues)

        tree = BinaryTree.create(array: dic.allValues as NSArray)

        tree?.printSelf()

        tree?.reverse()

        print("\n\n==========反转二叉树==========");
        
        tree?.printSelf()

        print("\n\n====================OC=======================");

        ocTree = OCBinaryTree.create(with: dic.allValues)

        ocTree?.print()

        ocTree?.reverse()

        print("\n\n==========反转二叉树==========");

        ocTree?.print()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        print("reset")

        createBinaryTree()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

