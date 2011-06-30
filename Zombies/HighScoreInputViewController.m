//
//  HighScoreInputViewController.m
//  Zombies
//
//  Created by Ankit Tyagi on 6/27/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "HighScoreInputViewController.h"

@implementation HighScoreInputViewController

@synthesize nameInput, scoreLabel, delegate, newScore;

- (IBAction)makeKeyboardGoAway:(id)sender
{
	[nameInput resignFirstResponder];
}

- (IBAction)storeScore:(id)sender {
    [nameInput resignFirstResponder];
    NSString *newName = [nameInput text];
    HighScoreData *newData = [[HighScoreData alloc] initWithScore:newScore andName:newName];
    [highScoresData.tree insert:newData];
    [highScoresData saveHighScores];
    [delegate highScoreWasEntered:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        highScoresData = [HighScoreSingletonData sharedHighScore];
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
    scoreLabel.text = [NSString stringWithFormat:@"%d", newScore];
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

@end
