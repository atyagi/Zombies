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
    double x;
    double y;
    CGPoint defaultMainCharPosition;
    NSMutableArray *enemyList;
    int timeLeft;
    BOOL timeIsUp;
    BOOL gamePaused;
}

- (void)backgroundMoveEnemy;
- (void)backgroundDoTimeRemaining;
- (void)backgroundMoveBonusTime;
- (CGPoint)moveToThisLocation:(CGPoint)location;
- (void)runTimeRemaining;
- (void)runMoveBonusTime;
- (BOOL)viewCollides:(UIView*)view1 withView:(UIView*)view2;
- (IBAction)gameOver:(id)sender;
- (IBAction)showMenu:(id)sender;
- (IBAction)showSettings:(id)sender;

@property (weak, nonatomic) IBOutlet id <MainViewControllerDelegate> delegate;
@property (strong) UIButton *gameOverButton;
@property (strong) UILabel *scoreLabel;
@property (strong) UIImageView *mainChar;
@property (strong) UILabel *timeLeftLabel;
@property (strong) UIButton *menuButton;
@property int score;
@property double x;
@property double y;
@property (strong) NSMutableArray *enemyList;
@property int timeLeft;
@property BOOL timeIsUp;
@property BOOL gamePaused;

@end
