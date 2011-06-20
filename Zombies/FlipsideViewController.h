//
//  FlipsideViewController.h
//  AccelerometerWithSettings
//
//  Created by Ankit Tyagi on 6/9/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController
{
    IBOutlet UISegmentedControl *speed;
}

@property (weak, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UISegmentedControl *speed;

- (IBAction)done:(id)sender;
- (IBAction)speedChanged:(id)sender;

@end
