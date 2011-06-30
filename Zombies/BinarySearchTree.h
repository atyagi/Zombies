//
//  BinarySearchTree.h
//  BinarySearchTree
//
//  Created by Ankit Tyagi on 6/21/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSTNode.h"

@interface BinarySearchTree : NSObject {
    BSTNode *root;
    int count;
}

@property int count;

-(void)insert:(HighScoreData*)value;
-(BOOL)search:(HighScoreData*)value;
-(void)remove:(HighScoreData*)value;
-(BOOL)belongsInHighScores:(int)value;

-(void)printInOrder;
-(void)printInOrder:(BSTNode*)node;
-(void)printPreOrder;
-(void)printPreOrder:(BSTNode*)node;
-(void)printPostOrder;
-(void)printPostOrder:(BSTNode*)node;
-(void)printReverseOrder;
-(void)printReverseOrder:(BSTNode*)node;

-(NSMutableArray*)getSortedHighScores;
-(void)getSortedHighScores:(BSTNode*)node inArray:(NSMutableArray*)array;

@end
