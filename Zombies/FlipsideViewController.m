//
//  FlipsideViewController.m
//  AccelerometerWithSettings
//
//  Created by Ankit Tyagi on 6/9/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize speed;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [speed setSelectedSegmentIndex:[defaults integerForKey:@"speedIndex"]];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:speed.selectedSegmentIndex forKey:@"speedIndex"];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:speed.selectedSegmentIndex forKey:@"speedIndex"];
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
    [defaults setInteger:speed.selectedSegmentIndex forKey:@"speedIndex"];
}

- (IBAction)speedChanged:(id)sender 
{
    NSUserDefaults *speedAmount = [NSUserDefaults standardUserDefaults];
    if (speed.selectedSegmentIndex == 0) [speedAmount setFloat:3.0 forKey:@"intSpeed"];
    if (speed.selectedSegmentIndex == 1) [speedAmount setFloat:10.0 forKey:@"intSpeed"];
    if (speed.selectedSegmentIndex == 2) [speedAmount setFloat:17.0 forKey:@"intSpeed"];
}


@end
