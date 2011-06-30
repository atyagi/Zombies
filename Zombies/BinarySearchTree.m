//
//  BinarySearchTree.m
//  BinarySearchTree
//
//  Created by Ankit Tyagi on 6/21/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "BinarySearchTree.h"

@implementation BinarySearchTree

@synthesize count;

- (id)init {
    self = [super init];
    if (self) {
        count = 0;
        root = nil;
    }
    
    return self;
}

- (id)initWithRoot:(id)passedRoot {
    self = [super init];
    if (self) {
        count = 0;
        root = passedRoot;
    }
    
    return self;
}

- (void)insert:(HighScoreData*)value {
    //insert a new value into the tree
	BSTNode* newNode = [[BSTNode alloc] initWithData:value];
	BSTNode* current = root;
    if (count < 10) {
        if (root == nil)
        {
            root = newNode;
        }
        else
        {
            while (current.right != nil || current.left != nil)
            {
                if (current.right == nil && value.score >= current.data.score)
                {
                    current.right = newNode;
                    break;
                }
                else if (current.left == nil && value.score < current.data.score)
                {
                    current.left = newNode;
                    break;
                }
                else if(value.score >= current.data.score)
                    current = current.right;
                else
                    current = current.left; 
            }
            if (value.score >= current.data.score)
                current.right = newNode;
            else
                current.left = newNode;
        }
        count = count + 1;
        return;
    }
    else {
        while (current.left != nil) {
            //if (value.score <= current.data.score) {
            //    return;
            //}
            current = current.left;
        }
        [self remove:current.data];
        [self insert:value];
        return;
    }
}

- (BOOL)belongsInHighScores:(int)value {
    BSTNode* current = root;
    while (current.left != nil) {
        if (value <= current.data.score) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)search:(HighScoreData*)value {
    BSTNode *current = root;
	while(current != nil)
	{
		if(current.data == value) 
			return true; 
		else if(value.score < current.data.score)
			current = current.left; 
		else
			current = current.right;
	}
	return false;  
}

- (void)remove:(HighScoreData*)value {
    BSTNode *current = root;
	BSTNode *parent = nil;
	while(current != nil)
	{
		if (current.data == value)
		{
			if (current.right == nil && current.left == nil)
			{
				if (value < parent.data)
					parent.left = nil;
				else
					parent.right = nil;
				current = nil;
				break;
			}
			else if (current.right == nil || current.left == nil)
			{
				if (current.right != nil)
				{
					if (parent.right == current)
						parent.right = current.right;
					else
						parent.left = current.right;
				}
				else if (current.left != nil)
				{
					if (parent.right == current)
						parent.right = current.left;
					else 
						parent.left = current.left;
				}
				current = nil;
				break;
			}
			else { }
		}
		else if (value < current.data)
		{
			parent = current;
			current = current.left;
		}
		else
		{
			parent = current;
			current = current.right;
		}
	}
    count = count - 1;
	return;
}

/*
 Returns the array in greatest to smallest
 */
- (NSMutableArray*)getSortedHighScores {
    @synchronized(self) {
        NSMutableArray *arrayInOrder = [[NSMutableArray alloc] initWithCapacity:10];
        [self getSortedHighScores:root inArray:arrayInOrder];
        return arrayInOrder;
    }
}

- (void)getSortedHighScores:(BSTNode *)node inArray:(NSMutableArray *)array {
    if (node == nil)
        return;
    [self getSortedHighScores:node.right inArray:array];
    [array addObject:node.data];
    [self getSortedHighScores:node.left inArray:array];
}

- (void)printInOrder
{
    [self printInOrder:root];
}

- (void)printInOrder:(BSTNode*)node
{
	if (node == nil)
		return;
    [self printInOrder:node.left];
	//NSLog([NSString stringWithFormat:@"%@, ", [node.data scoreString]]);
	[self printInOrder:node.right];
}

- (void)printPreOrder
{
    [self printPreOrder:root];
}

- (void)printPreOrder:(BSTNode*)node
{
	if (node == nil)
		return;
    //NSLog([NSString stringWithFormat:@"%@, ", [node.data scoreString]]);
	[self printPreOrder:node.left];
	[self printPreOrder:node.right];
}


- (void)printPostOrder
{
    [self printPostOrder];
}

- (void)printPostOrder:(BSTNode*)node
{
    if (node == nil)
        return;
    [self printPostOrder:node.left];
    [self printPostOrder:node.right];
    //NSLog([NSString stringWithFormat:@"%@, ", [node.data scoreString]]);
}

- (void)printReverseOrder
{
    [self printReverseOrder:root];
}

- (void)printReverseOrder:(BSTNode*) node
{
    if (node == nil)
        return;
    [self printReverseOrder:node.right];
    //NSLog([NSString stringWithFormat:@"%@, ", [node.data scoreString]]);
    [self printReverseOrder:node.left];
}

@end
