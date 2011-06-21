//
//  HighScoreViewController.h
//  Zombies
//
//  Created by Developer on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HighScoreViewController;

@protocol HighScoreViewControllerDelegate 

- (void)highScoreViewDidFinish:(HighScoreViewController*)controller;

@end

@interface HighScoreViewController : UIViewController {
}

@property (weak, nonatomic) IBOutlet id <HighScoreViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
