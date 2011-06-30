//
//  HighScoreData.h
//  Zombies
//
//  Created by Ankit Tyagi on 6/22/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HighScoreData;

const static double versionNumber = 1.0;

@interface HighScoreData : NSObject 
<NSCoding>
{
    NSString *name;
    int score;
}

@property int score;
@property (strong) NSString *name;

- (id)initWithScore:(int)passedScore andName:(NSString*)passedName;
- (NSString*)scoreString;

@end
