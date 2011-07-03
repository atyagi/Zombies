//
//  HighScoreSingletonData.m
//  Zombies
//
//  Created by Ankit Tyagi on 6/26/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "HighScoreSingletonData.h"

@implementation HighScoreSingletonData

@synthesize tree;

static HighScoreSingletonData *sharedHighScore;

+ (HighScoreSingletonData*)sharedHighScore 
{
    @synchronized(self) 
    {
        if (!sharedHighScore) {
            NSString* filePath = [self saveFilePath];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
            if (fileExists)
            {
                NSMutableArray* dataToAddIn = [self loadHighScores];
                sharedHighScore = [[HighScoreSingletonData alloc] init];
                for (HighScoreData *newData in dataToAddIn) {
                    [[sharedHighScore tree] insert:newData];
                }
            }
            else {
                sharedHighScore = [[HighScoreSingletonData alloc] init];
                @autoreleasepool {
                    for (int i = 0; i < 10; i++) {
                        HighScoreData *data = [[HighScoreData alloc] initWithScore:0 andName:@"Player"];
                        [[sharedHighScore tree] insert:data];
                        
                    }
                }
            }
        }
        return sharedHighScore;
    }
}

+ (id)allocWithZone:(NSZone*)zone
{
    @synchronized(self) {
        if (sharedHighScore == nil) {
            sharedHighScore = [super allocWithZone:zone];
            return sharedHighScore;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone*)zone
{
    return self;
}

+ (NSString*)saveFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"highScoresList.data"];
    return path;
}

- (void)saveHighScores {
    NSMutableArray *saveArray = [tree getSortedHighScores];
    NSString *filePath = [HighScoreSingletonData saveFilePath];
    [NSKeyedArchiver archiveRootObject:saveArray toFile:filePath];
}

+ (NSMutableArray*)loadHighScores {
    NSString* filePath = [self saveFilePath];
    @try {
        NSMutableArray *loadArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        return loadArray;
    }
    @catch (NSException *exception) { }
}

- (id)init
{
    self = [super init];
    if (self) {
        tree = [[BinarySearchTree alloc] init];
    }
    
    return self;
}

@end
