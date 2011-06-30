//
//  HighScoreData.m
//  Zombies
//
//  Created by Ankit Tyagi on 6/22/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "HighScoreData.h"

@implementation HighScoreData

@synthesize score, name;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithScore:(int)passedScore andName:(NSString*)passedName
{
    self = [super init];
    if (self) {
        score = passedScore;
        name = passedName;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) return nil;
    score = [aDecoder decodeInt32ForKey:@"scoreKey"];
    name = [aDecoder decodeObjectForKey:@"nameKey"];
    return self;
}

- (NSString*)scoreString {
    return [NSString stringWithFormat:@"%@: %d", name, score];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:versionNumber forKey:@"versionKey"];
    [aCoder encodeInt32:score forKey:@"scoreKey"];
    [aCoder encodeObject:name forKey:@"nameKey"];
}

@end
