//
//  Enemy.m
//  AccelerometerWithSettings
//
//  Created by Ankit Tyagi on 6/15/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

@synthesize myDirection, directionChanged;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)resetDirection:(CGPoint)currentPosition {
    if (myDirection == UP) currentPosition = CGPointMake((arc4random() % 300) + 20, 420);
    else if (myDirection == DOWN) currentPosition = CGPointMake((arc4random() % 300) + 20, 10);
    else if (myDirection == LEFT) currentPosition = CGPointMake(315, (arc4random() % 300 + 20));
    else currentPosition = CGPointMake(10, (arc4random() % 300 + 20));
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
