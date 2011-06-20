//
//  Enemy.h
//  AccelerometerWithSettings
//
//  Created by Ankit Tyagi on 6/15/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Enemy : UIImageView {
    enum Direction {
        LEFT, RIGHT, DOWN, UP
    };
    enum Direction myDirection;
    
}

@property enum Direction myDirection;

-(void)moveEnemyUp;
-(void)moveEnemyDown;
-(void)moveEnemyLeft;
-(void)moveEnemyRight;

@end
