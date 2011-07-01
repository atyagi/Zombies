//
//  TiltCalibrationViewController.h
//  Zombies
//
//  Created by Ankit Tyagi on 7/1/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TiltCalibrationViewController;

@protocol TiltCalibrationViewControllerDelegate

- (void)tiltCalibrated:(TiltCalibrationViewController *)controller;

@end

@interface TiltCalibrationViewController : UIViewController 
<UIAccelerometerDelegate>
{
    double calibrationX;
    double calibrationY;
}

@property (weak) IBOutlet id <TiltCalibrationViewControllerDelegate> delegate;
@property double calibrationX;
@property double calibrationY;

- (IBAction)done:(id)sender;

@end
