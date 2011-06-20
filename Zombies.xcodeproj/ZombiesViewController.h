//
//  ZombiesViewController.h
//  Zombies
//
//  Created by Developer on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "FlipsideViewController.h"

@interface ZombiesViewController : UIViewController 
<MainViewControllerDelegate, FlipsideViewControllerDelegate>
{
    
}

-(IBAction)playGame:(id)sender;
-(IBAction)viewSettings:(id)sender;
-(IBAction)viewHighScores:(id)sender;


@end
