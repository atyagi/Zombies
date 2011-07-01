//
//  FlipsideViewController.m
//  Zombies
//
//  Settings view controller
//
//  Created by Ankit Tyagi on 6/9/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize speed, direction;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:[speed value] forKey:@"sensitivityKey"];
    [defaults setInteger:[direction selectedSegmentIndex] forKey:@"directionKey"];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:[speed value] forKey:@"sensitivityKey"];
    [defaults setInteger:[direction selectedSegmentIndex] forKey:@"directionKey"];
}

- (IBAction)speedChanged:(id)sender 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:[speed value] forKey:@"sensitivityKey"];
}

- (IBAction)directionChanged:(id)sender 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[direction selectedSegmentIndex] forKey:@"directionKey"];
}

- (IBAction)changeTiltCalibration:(id)sender
{
    TiltCalibrationViewController *tiltCalibration = [[TiltCalibrationViewController alloc] initWithNibName:@"TiltCalibrationViewController" bundle:nil];
    tiltCalibration.delegate = self;
    tiltCalibration.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:tiltCalibration animated:YES];
}

#pragma mark - TiltCalibrationViewControllerDelegate methods

- (void)tiltCalibrated:(TiltCalibrationViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
}

@end
