//
//  HighScoreInputViewController.h
//  Zombies
//
//  Created by Ankit Tyagi on 6/27/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreSingletonData.h"

@class HighScoreInputViewController;

@protocol HighScoreInputViewControllerDelegate

- (void)highScoreWasEntered:(HighScoreInputViewController*)controller;

@end

@interface HighScoreInputViewController : UIViewController 
<UITextFieldDelegate>
{
    int newScore;
    HighScoreSingletonData *highScoresData;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UITextField *nameInput;
}

@property (weak) IBOutlet id <HighScoreInputViewControllerDelegate> delegate;
@property (strong) IBOutlet UILabel *scoreLabel;
@property (strong) IBOutlet UITextField *nameInput;
@property int newScore;

- (IBAction)makeKeyboardGoAway:(id)sender;
- (IBAction)storeScore:(id)sender;

@end
