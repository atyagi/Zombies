//
//  HighScoreInputViewController.h
//  Zombies
//
//  Created by Ankit Tyagi on 6/27/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreSingletonData.h"
#import "GameCenterManager.h"
#import <GameKit/GameKit.h>

@class HighScoreInputViewController;

@protocol HighScoreInputViewControllerDelegate

- (void)highScoreWasEntered:(HighScoreInputViewController*)controller;

@end

@interface HighScoreInputViewController : UIViewController 
<UITextFieldDelegate, GKLeaderboardViewControllerDelegate, GameCenterManagerDelegate>
{
    int64_t newScore;
    HighScoreSingletonData *highScoresData;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UITextField *nameInput;
    IBOutlet UIButton *submitButton;
    
    NSString* currentLeaderBoard;    
}

@property (weak) IBOutlet id <HighScoreInputViewControllerDelegate> delegate;
@property (strong) IBOutlet UILabel *scoreLabel;
@property (strong) IBOutlet UITextField *nameInput;
@property (strong) IBOutlet UIButton *submitButton;
@property int64_t newScore;
@property (nonatomic, strong) NSString* currentLeaderBoard;

- (IBAction)makeKeyboardGoAway:(id)sender;
- (IBAction)storeScore:(id)sender;
- (IBAction)goBack:(id)sender;
- (void)showLeaderboard;

@end
