//
//  BinaryTreeView.swift
//  BinaryTree
//
//  Created by wangyong on 2018/4/9.
//  Copyright © 2018年 ipanel. All rights reserved.
//

import UIKit

var numberKey = 102
var heightKey = 103

extension BinaryTree{

    //在满二叉树下从左到右的编号，即满二叉树中序遍历下的序号,以树根为参照,比如3层满二叉树，树根结点number为4，故不可用递归
    var number: Int {
        set {
            objc_setAssociatedObject(self, &numberKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let num = objc_getAssociatedObject(self, &numberKey) as? Int {
                return num
            }
            return 0
        }
    }
    //在二叉树下该结点的层级,最上层结点为depth
    var height: Int {
        set {
            objc_setAssociatedObject(self, &heightKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let h = objc_getAssociatedObject(self, &heightKey) as? Int {
                return h
            }
            return 0
        }
    }

    func setValues() {

        let treeArray = NSMutableArray()

        self.number = (self.maxLength() + 1)/2

        self.height = self.depth()

        var tree: BinaryTree? = self

        while (tree != nil || treeArray.count > 0) {

            while tree != nil {

                treeArray.add(tree!)

                if tree!.leftTree != nil {

                    tree!.leftTree!.height = tree!.height - 1

                    tree!.leftTree!.number = tree!.number - Int(pow(2.0, CGFloat(tree!.height - 2)))
                }

                tree = tree!.leftTree
            }

            if treeArray.count > 0 {

                tree = (treeArray.lastObject as! BinaryTree)

                if tree!.rightTree != nil {

                    tree!.rightTree!.height = tree!.height - 1

                    tree!.rightTree!.number = tree!.number + Int(pow(2.0, CGFloat(tree!.height - 2)))
                }

                tree = tree!.rightTree

                treeArray.removeLastObject()
            }
        }
    }
}

class BinaryTreeView: UIView {

    var binaryTree: BinaryTree?

    var radius: CGFloat = 10.0

    var viewHeight: CGFloat?

    var eachWidth: CGFloat?

    var eachHeight: CGFloat?

    let path = UIBezierPath()

    //MARK:
    func showTreeView(tree: BinaryTree) {

        binaryTree = tree

        self.layer.sublayers = nil

        path.removeAllPoints()

        binaryTree!.setValues()

        viewHeight = self.frame.height

        eachWidth = (viewHeight! - radius*2)/CGFloat(tree.maxLength())

        eachHeight = (Screen_width() - radius*2)/CGFloat(tree.depth())

//        radius = min(10, (viewHeight! - radius*2)/CGFloat(pow(2, CGFloat(tree.depth())))) //层级过多，节点过多时，可能会有重叠问题

        path.lineWidth = 1

        let lineLayer = CAShapeLayer()

        lineLayer.strokeColor = UIColor.black.cgColor

        lineLayer.lineWidth = 1

        addLineViewSuf(tree: tree)

        lineLayer.path = path.cgPath

        self.layer.addSublayer(lineLayer)

        /*
         *  用动画演示遍历。因为画线时有些结点会访问两次，所以此处动画有些不标准，只是大概模拟
         */

        let animation = CABasicAnimation(keyPath: "strokeEnd")

        animation.fromValue = 0

        animation.toValue = 1

        animation.duration = 5.0

        lineLayer.add(animation, forKey: "")

        addCircleViews(tree: tree)
    }
    /*
     *  先序遍历
     */
    func addLineView(tree: BinaryTree) {

        let selfPoint = getPoint(tree: tree)

        if tree.leftTree != nil {

            addLine(point1: selfPoint, toPoint2: getPoint(tree: tree.leftTree!))

            self.addLineView(tree: tree.leftTree!)
        }

        if tree.rightTree != nil {

            addLine(point1: selfPoint, toPoint2: getPoint(tree: tree.rightTree!))

            self.addLineView(tree: tree.rightTree!)
        }
    }
    /*
     *  中序遍历
     */
    func addLineViewMid(tree: BinaryTree) {

        let selfPoint = getPoint(tree: tree)

        if tree.leftTree != nil {

            self.addLineViewMid(tree: tree.leftTree!)

            addLine(point1: getPoint(tree: tree.leftTree!), toPoint2: selfPoint)
        }

        if tree.rightTree != nil {

            self.addLineViewMid(tree: tree.rightTree!)

            addLine(point1: selfPoint, toPoint2: getPoint(tree: tree.rightTree!))
        }
    }
    /*
     *  后序遍历
     */
    func addLineViewSuf(tree: BinaryTree) {

        let selfPoint = getPoint(tree: tree)

        if tree.leftTree != nil {

            self.addLineViewSuf(tree: tree.leftTree!)

            addLine(point1: getPoint(tree: tree.leftTree!), toPoint2: selfPoint)
        }

        if tree.rightTree != nil {

            self.addLineViewSuf(tree: tree.rightTree!)

            addLine(point1: getPoint(tree: tree.rightTree!), toPoint2: selfPoint)
        }
    }
    func addLine(point1:CGPoint,toPoint2 point2:CGPoint) {

        path.move(to: point1)

        path.addLine(to: point2)
    }
    func addCircleViews(tree: BinaryTree) {

        addCircleView(tree: tree)

        if tree.leftTree != nil {

            addCircleViews(tree: tree.leftTree!)
        }

        if tree.rightTree != nil {

            addCircleViews(tree: tree.rightTree!)
        }
    }
    func addCircleView(tree: BinaryTree) {

        let point = getPoint(tree: tree)

        let label = UILabel(frame: CGRect(x: point.x - radius, y: point.y - radius, width: radius*2, height: radius*2))

        label.backgroundColor = UIColor.white

        label.textColor = UIColor.gray

        label.font = UIFont.systemFont(ofSize: 13)

        label.textAlignment = NSTextAlignment.center

        label.text = String.init(format: "%zd", tree.value)

        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2.0)

        label.layer.cornerRadius = radius

        label.layer.borderColor = UIColor.black.cgColor

        label.layer.borderWidth = 1

        addSubview(label)
    }
    func getPoint(tree: BinaryTree) -> CGPoint {

        let pointY = CGFloat(tree.number)*eachWidth!

        let pointX = CGFloat(tree.height)*eachHeight!

        return CGPoint(x: pointX, y: pointY)
    }
}
