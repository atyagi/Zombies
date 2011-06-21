//
//  Enemy.m
//  Zombies
//
//  Created by Ankit Tyagi on 6/15/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

@synthesize myDirection;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)moveEnemyUp {
    CGPoint pos = self.center;
    if (pos.y < 1)
        pos.y = 479;
    else
        pos.y = pos.y - ((arc4random() % 5) + 2);
    self.center = pos;
}

-(void)moveEnemyDown {
    CGPoint pos = self.center;
    if (pos.y > 479)
        pos.y = 1;
    else
        pos.y = pos.y + ((arc4random() % 5) + 2);
    self.center = pos;
}

-(void)moveEnemyLeft {
    CGPoint pos = self.center;
    if (pos.x < 1)
        pos.x = 319;
    else
        pos.x = pos.x - ((arc4random() % 5) + 2);
    self.center = pos;
}

-(void)moveEnemyRight {
    CGPoint pos = self.center;
    if (pos.x > 319)
        pos.x = 1;
    else
        pos.x = pos.x + ((arc4random() % 5) + 2);
    self.center = pos;
}

@end
