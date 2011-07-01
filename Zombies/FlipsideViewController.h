//
//  FlipsideViewController.h
//  Zombies
//
//  Settings view controller
//
//  Created by Ankit Tyagi on 6/9/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiltCalibrationViewController.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;

@end

@interface FlipsideViewController : UIViewController 
<TiltCalibrationViewControllerDelegate>
{
    IBOutlet UISlider *speed;
    IBOutlet UISegmentedControl *direction;
}

@property (weak, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, strong) IBOutlet UISlider *speed;
@property (nonatomic, strong) IBOutlet UISegmentedControl *direction;

- (IBAction)done:(id)sender;
- (IBAction)speedChanged:(id)sender;
- (IBAction)directionChanged:(id)sender;
- (IBAction)changeTiltCalibration:(id)sender;

@end
