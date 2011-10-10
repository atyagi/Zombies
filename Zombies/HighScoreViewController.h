//
//  HighScoreViewController.h
//  Zombies
//
//  Created by Ankit Tyagi on 6/20/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreSingletonData.h"
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"

@class HighScoreViewController;

@protocol HighScoreViewControllerDelegate 

- (void)highScoreViewDidFinish:(HighScoreViewController*)controller;

@end

@class GameCenterManager;

@interface HighScoreViewController : UIViewController 
<GKLeaderboardViewControllerDelegate, GameCenterManagerDelegate>
{
    IBOutlet UILabel *namesOfScores;
    IBOutlet UILabel *actualScores;
    IBOutlet UILabel *datesOfScores;
    HighScoreSingletonData *highScoreData;
    NSMutableArray *displayArray;
    
    NSString* currentLeaderBoard;
}

@property (weak) IBOutlet id <HighScoreViewControllerDelegate> delegate;
@property (strong) IBOutlet UILabel *namesOfScores;
@property (strong) IBOutlet UILabel *actualScores;
@property (strong) IBOutlet UILabel *datesOfScores;
@property (strong) NSMutableArray *displayArray;
@property (nonatomic, strong) NSString* currentLeaderBoard;

- (IBAction)done:(id)sender;
- (IBAction)resetHighScores:(id)sender;
- (IBAction)viewLeaderboard:(id)sender;
- (void)showHighScores;
- (IBAction)retrieveTopTenScores:(id)sender;

@end
