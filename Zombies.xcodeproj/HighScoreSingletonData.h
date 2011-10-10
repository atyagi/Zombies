//
//  HighScoreSingletonData.h
//  Zombies
//
//  Created by Ankit Tyagi on 6/26/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSException.h>
#import <Foundation/FoundationErrors.h>
#import "BinarySearchTree.h"

@interface HighScoreSingletonData : NSObject {
    BinarySearchTree *tree;
}

@property (strong) BinarySearchTree *tree;

+(HighScoreSingletonData*)sharedHighScoreData;
+(NSString*)saveFilePath;
-(void)saveHighScores;
+(NSMutableArray*)loadHighScores;

@end
