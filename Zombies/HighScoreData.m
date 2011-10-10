//
//  HighScoreData.m
//  Zombies
//
//  Created by Ankit Tyagi on 6/22/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "HighScoreData.h"

@implementation HighScoreData

@synthesize score, name, dateEarned;

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
        dateEarned = [NSDate date];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) return nil;
    score = [aDecoder decodeInt32ForKey:@"scoreKey"];
    name = [aDecoder decodeObjectForKey:@"nameKey"];
    dateEarned = [aDecoder decodeObjectForKey:@"dateKey"];
    return self;
}

- (NSString*)scoreString {
    return [NSString stringWithFormat:@"%@: %d on %@", name, score, dateEarned];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:versionNumber forKey:@"versionKey"];
    [aCoder encodeInt32:score forKey:@"scoreKey"];
    [aCoder encodeObject:name forKey:@"nameKey"];
    [aCoder encodeObject:dateEarned forKey:@"dateKey"];
}

@end
