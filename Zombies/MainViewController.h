//
//  MainViewController.h
//  AccelerometerWithSettings
//
//  Created by Ankit Tyagi on 6/9/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "Enemy.h"
#import <CoreMotion/CMMotionManager.h>

@class MainViewController;

@protocol MainViewControllerDelegate

-(void)mainViewDidFinish:(MainViewController*)controller;

@end

@interface MainViewController : UIViewController 
<UIAccelerometerDelegate> 
{
    IBOutlet UIButton *gameOverButton;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UIImageView *mainChar;
    IBOutlet UILabel *timeLeftLabel;
    int score;
    float speedRatio;
    double x;
    double y;
    CGPoint standardPosition;
    CMMotionManager *motionManager;
    NSMutableArray *enemyList;
    int timeLeft;
    BOOL timeIsUp;
}

- (void)backgroundMoveEnemy;
- (BOOL)viewCollides:(UIView*)view1 withView:(UIView*)view2;
- (IBAction)gameOver:(id)sender;

@property (weak, nonatomic) IBOutlet id <MainViewControllerDelegate> delegate;
@property (strong) UILabel *scoreLabel;
@property (strong) UIButton *gameOverButton;
@property (strong) UILabel *timeLeftLabel;
@property (strong) UIImageView *mainChar;
@property (strong) NSMutableArray *enemyList;
@property float speedRatio;
@property int score;
@property int timeLeft;
@property double x;
@property double y;
@property BOOL timeIsUp;

@end
