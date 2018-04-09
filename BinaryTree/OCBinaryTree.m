//
//  OCBinaryTree.m
//  BinaryTree
//
//  Created by wangyong on 2018/4/8.
//  Copyright © 2018年 ipanel. All rights reserved.
//

#import "OCBinaryTree.h"

@implementation OCBinaryTree

+ (instancetype)createWithArray:(NSArray *)array
{

    if (array.count <= 0) {

        return nil;
    }

    id rootModel = [[[self class] alloc] init];

    for (NSInteger i = 0; i < array.count; i++) {

        NSInteger value = [array[i] integerValue];

        [self createBinaryTree:value rootModel:rootModel];
    }

    return rootModel;
}

+ (void)createBinaryTree:(NSInteger)value rootModel:(OCBinaryTree *)model
{
    if (model.value <= 0) {

        model.value = value;

        return;
    }

    NSInteger midValue = model.value;

    if (value < midValue) {

        if (model.leftTree == nil || model.leftTree.value <= 0) {

            model.leftTree = [[[self class] alloc] init];

            model.leftTree.value = value;

            return;

        }else{

            [self createBinaryTree:value rootModel:model.leftTree];
        }

    }else{

        if (model.rightTree == nil || model.rightTree.value <= 0) {

            model.rightTree = [[[self class] alloc] init];

            model.rightTree.value = value;

            return;

        }else{

            [self createBinaryTree:value rootModel:model.rightTree];
        }
    }
}
#pragma mark -
- (void)print
{
    printf("\nlength:%zd    depth:%zd\n",self.length,self.depth);

    printf("先序遍历:\n");

    [self prePrint];

    printf("\n非递归先序遍历:\n");

    [self prePrintWithoutRecursion];

    printf("\n中序遍历:\n");

    [self midPrint];

    printf("\n非递归中序遍历\n");

    [self midPrintWithoutRecursion];

    printf("\n后序遍历\n");

    [self sufPrint];

    printf("\n非递归后序遍历:\n");

    [self sufPrintWithoutRecursion];

    printf("\n非递归后序遍历且不带isFirst参数:\n");

    [self sufPrintWithoutRecursionAndParam];
}
- (NSInteger)length
{
    return 1 + self.leftTree.length + self.rightTree.length;
}
- (NSInteger)depth
{
    return 1 + MAX(self.leftTree.depth, self.rightTree.depth);
}
- (void)reverse
{
    OCBinaryTree * right = self.rightTree;

    self.rightTree = self.leftTree;

    self.leftTree = right;

    [self.leftTree reverse];

    [self.rightTree reverse];
}
- (void)prePrint    //先序遍历
{
    printf(" %zd ",self.value);

    [self.leftTree prePrint];

    [self.rightTree prePrint];
}
- (void)midPrint   //中序遍历
{
    [self.leftTree midPrint];

    printf(" %zd ",self.value);

    [self.rightTree midPrint];
}
- (void)sufPrint   //后序遍历
{
    [self.leftTree sufPrint];

    [self.rightTree sufPrint];

    printf(" %zd ",self.value);
}
- (void)prePrintWithoutRecursion
{

    NSMutableArray <OCBinaryTree *>* treeArray = [NSMutableArray array];

    OCBinaryTree * tree = self;

    while (tree != nil || treeArray.count) {

        while (tree != nil) {

            printf(" %zd ",tree.value);

            [treeArray insertObject:tree atIndex:0];        //模仿栈的先进后出,后进先出

            tree = tree.leftTree;
        }

        if (treeArray.count) {

            tree = treeArray.firstObject.rightTree;

            [treeArray removeObjectAtIndex:0];
        }
    }
}
- (void)midPrintWithoutRecursion
{
    NSMutableArray <OCBinaryTree *>* treeArray = [NSMutableArray array];

    OCBinaryTree * tree = self;

    while (tree != nil || treeArray.count) {

        while (tree != nil) {

            [treeArray insertObject:tree atIndex:0];        //模仿栈的先进后出,后进先出

            tree = tree.leftTree;
        }

        if (treeArray.count) {

            tree = treeArray.firstObject;

            printf(" %zd ",tree.value);

            tree = tree.rightTree;

            [treeArray removeObjectAtIndex:0];
        }
    }
}
- (void)sufPrintWithoutRecursionAndParam
{
    NSMutableArray <OCBinaryTree *>* treeArray = [NSMutableArray array];

    OCBinaryTree * curTree = self;

    OCBinaryTree * preTree ;//前一次访问的结点

    [treeArray insertObject:self atIndex:0];

    while (treeArray.count) {

        curTree = treeArray.firstObject;

        if ((curTree.leftTree == nil && curTree.rightTree == nil) || (preTree != nil && (preTree == curTree.leftTree || preTree == curTree.rightTree))) {

            printf(" %zd ",curTree.value);

            [treeArray removeObjectAtIndex:0];

            preTree = curTree;
        }
        else
        {
            if (curTree.rightTree != nil) {

                [treeArray insertObject:curTree.rightTree atIndex:0];
            }

            if (curTree.leftTree != nil) {

                [treeArray insertObject:curTree.leftTree atIndex:0];
            }
        }
    }
}
- (void)sufPrintWithoutRecursion
{
    NSMutableArray <OCBinaryTree *>* treeArray = [NSMutableArray array];

    OCBinaryTree * tree = self;

    while (tree != nil || treeArray.count) {

        while (tree != nil) {

            [treeArray insertObject:tree atIndex:0];        //模仿栈的先进后出,后进先出

            tree = tree.leftTree;
        }

        if (treeArray.count) {

            tree = treeArray.firstObject;

            if (tree.isNotFirst) {

                printf(" %zd ",tree.value);

                [treeArray removeObjectAtIndex:0];

                tree = nil;

            }else{

                tree.isNotFirst = YES;

                tree = tree.rightTree;

            }
        }
    }
}
@end
