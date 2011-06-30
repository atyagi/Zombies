//
//  HighScoreViewController.h
//  Zombies
//
//  Created by Ankit Tyagi on 6/20/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreSingletonData.h"

@class HighScoreViewController;

@protocol HighScoreViewControllerDelegate 

- (void)highScoreViewDidFinish:(HighScoreViewController*)controller;

@end

@interface HighScoreViewController : UIViewController {
    IBOutlet UILabel *namesOfScores;
    IBOutlet UILabel *actualScores;
    HighScoreSingletonData *highScoreData;
    NSMutableArray *displayArray;
}

@property (weak) IBOutlet id <HighScoreViewControllerDelegate> delegate;
@property (strong) IBOutlet UILabel *namesOfScores;
@property (strong) IBOutlet UILabel *actualScores;
@property (strong) HighScoreSingletonData *highScoreData;
@property (strong) NSMutableArray *displayArray;

- (IBAction)done:(id)sender;

@end

