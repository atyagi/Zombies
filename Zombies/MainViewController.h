//
//  MainViewController.h
//  Zombies
//
//  Gameplay view controller
//
//  Created by Ankit Tyagi on 6/9/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "Enemy.h"
#import "HighScoreSingletonData.h"
#import "HighScoreInputViewController.h"
#import "FlipsideViewController.h"

@class MainViewController;

@protocol MainViewControllerDelegate

-(void)mainViewDidFinish:(MainViewController*)controller;

@end

@interface MainViewController : UIViewController 
<UIAccelerometerDelegate, HighScoreInputViewControllerDelegate, FlipsideViewControllerDelegate> 
{
    IBOutlet UIButton *gameOverButton;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UIImageView *mainChar;
    IBOutlet UILabel *timeLeftLabel;
    IBOutlet UIButton *menuButton;
    int score;
    float sensitivity;
    double x;
    double y;
    CGPoint standardPosition;
    NSMutableArray *enemyList;
    int timeLeft;
    BOOL timeIsUp;
    BOOL gamePaused;
    
    IBOutlet UILabel *xAccel;
    IBOutlet UILabel *yAccel;
    IBOutlet UILabel *zAccel;
}

- (void)backgroundMoveEnemy;
- (BOOL)viewCollides:(UIView*)view1 withView:(UIView*)view2;
- (IBAction)gameOver:(id)sender;
- (IBAction)showMenu:(id)sender;
- (IBAction)showSettings:(id)sender;

@property (weak, nonatomic) IBOutlet id <MainViewControllerDelegate> delegate;
@property (strong) UILabel *scoreLabel;
@property (strong) UIButton *gameOverButton;
@property (strong) UIButton *menuButton;
@property (strong) UILabel *timeLeftLabel;
@property (strong) UIImageView *mainChar;
@property (strong) NSMutableArray *enemyList;
@property float sensitivity;
@property int score;
@property int timeLeft;
@property double x;
@property double y;
@property BOOL timeIsUp;
@property BOOL gamePaused;

@property (strong) UILabel *xAccel;
@property (strong) UILabel *yAccel;
@property (strong) UILabel *zAccel;

@end
