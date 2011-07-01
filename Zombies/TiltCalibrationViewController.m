//
//  TiltCalibrationViewController.m
//  Zombies
//
//  Created by Ankit Tyagi on 7/1/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "TiltCalibrationViewController.h"

@implementation TiltCalibrationViewController

@synthesize delegate;
@synthesize calibrationX, calibrationY;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/30.0f;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    accel.delegate = nil;
    [defaults setDouble:calibrationY forKey:@"calibrationYKey"];
    [defaults setDouble:calibrationX forKey:@"calibrationXKey"];
    [self.delegate tiltCalibrated:self];
}

#pragma mark - UIAccelerometerDelegate methods

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    calibrationX = acceleration.x;
    calibrationY = acceleration.y;
}

@end
