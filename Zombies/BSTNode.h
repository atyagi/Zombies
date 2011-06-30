//
//  BSTNode.h
//  BinarySearchTree
//
//  Created by Ankit Tyagi on 6/21/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HighScoreData.h"

@class BSTNode;

@interface BSTNode : NSObject {
    HighScoreData *data;
    BSTNode *left;
    BSTNode *right;
}

@property (strong) BSTNode *left;
@property (strong) BSTNode *right;
@property (strong) HighScoreData *data;

- (id)initWithData:(id)passedData;

@end
