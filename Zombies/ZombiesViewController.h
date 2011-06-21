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

@interface ZombiesViewController : UIViewController 
<MainViewControllerDelegate, FlipsideViewControllerDelegate, HighScoreViewControllerDelegate>
{
    
}

-(IBAction)playGame:(id)sender;
-(IBAction)viewSettings:(id)sender;
-(IBAction)viewHighScores:(id)sender;


@end
