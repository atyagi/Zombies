//
//  ZombiesViewController.h
//  Zombies
//
//  Main menu view controller.
//
//  Created by Ankit Tyagi on 6/20/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "FlipsideViewController.h"
#import "HighScoreViewController.h"
#import "InstructionsViewController.h"

@interface ZombiesViewController : UIViewController 
<MainViewControllerDelegate, FlipsideViewControllerDelegate, HighScoreViewControllerDelegate, InstructionsViewControllerDelegate>
{
    
}

-(IBAction)playGame:(id)sender;
-(IBAction)viewSettings:(id)sender;
-(IBAction)viewHighScores:(id)sender;
-(IBAction)viewInstructions:(id)sender;

@end
