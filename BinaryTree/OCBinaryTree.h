//
//  OCBinaryTree.h
//  BinaryTree
//
//  Created by wangyong on 2018/4/8.
//  Copyright © 2018年 ipanel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCBinaryTree : NSObject

@property (nonatomic, assign) NSInteger value;

@property (nonatomic, strong) OCBinaryTree * leftTree;

@property (nonatomic, strong) OCBinaryTree * rightTree;

@property (nonatomic, assign) BOOL isNotFirst;

- (NSInteger)depth;    //深度

- (NSInteger)length;   //所有节点的个数

- (NSInteger)maxLength;//满二叉树所有节点数

- (void)print;       //打印基本信息

- (void)BFSPrint;    //广度优先遍历:Breadth First Search

- (void)prePrint;    //先序遍历

- (void)midPrint;    //中序遍历

- (void)sufPrint;    //后序遍历

- (void)prePrintWithoutRecursion;           //非递归先序遍历

- (void)midPrintWithoutRecursion;           //非递归中序遍历

- (void)sufPrintWithoutRecursion;           //非递归后序遍历

- (void)sufPrintWithoutRecursionAndParam;   //非递归后序遍历不带isFirst参数

- (void)reverse;     //反转二叉树

+ (instancetype)createWithArray:(NSArray *)array;
@end
