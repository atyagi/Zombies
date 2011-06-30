//
//  BSTNode.m
//  BinarySearchTree
//
//  Created by Ankit Tyagi on 6/21/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "BSTNode.h"

@implementation BSTNode

@synthesize left, right, data;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithData:(HighScoreData*)passedData
{
    self = [super init];
    if (self) {
        data = passedData;
        left = nil;
        right = nil;
    }
    return self;
}

@end
