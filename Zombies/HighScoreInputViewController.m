//
//  HighScoreInputViewController.m
//  Zombies
//
//  Created by Ankit Tyagi on 6/27/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "HighScoreInputViewController.h"
#import "AppSpecificValues.h"

@implementation HighScoreInputViewController

@synthesize nameInput, scoreLabel, delegate, newScore, currentLeaderBoard, submitButton;

#pragma mark - IBActions

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
    
    [[GameCenterManager sharedGameCenterManager] reportScore: self.newScore forCategory: self.currentLeaderBoard];
    
    submitButton.enabled = NO;
    
    [self showLeaderboard];
}

- (void)showLeaderboard {
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.category = self.currentLeaderBoard;
        leaderboardController.timeScope = GKLeaderboardTimeScopeWeek;
        leaderboardController.leaderboardDelegate = self;
        [self presentModalViewController: leaderboardController animated: YES];
    }
}

- (IBAction)goBack:(id)sender {
    [delegate highScoreWasEntered:self];
}

#pragma mark - GKLeaderboardDelegate methods

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
    [self dismissModalViewControllerAnimated: YES];
}

#pragma mark - GameCenterManagerDelegate methods

- (void) scoreReported: (NSError*) error;
{
	if(error == NULL)
	{
		[[GameCenterManager sharedGameCenterManager] reloadHighScoresForCategory: self.currentLeaderBoard];
        NSLog(@"Score reported successfully");
	}
    else 
        NSLog(@"Score was not reported");
}

- (void) reloadScoresComplete: (GKLeaderboard*) leaderBoard error: (NSError*) error;
{
	if(error == NULL)
	{
        NSLog(@"Scores were reloaded correctly");
		if([leaderBoard.scores count] > 0)
		{
			NSLog(@"Scores are greater than zero.");
            //NSLog([NSString stringWithFormat:@"Score count is %@", [leaderBoard.scores count]]);
		}
	}
	else
        NSLog(@"Scores were not reloaded properly");
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self storeScore:textField];
    }
    else {
        [textField resignFirstResponder];
    }
	return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        highScoresData = [HighScoreSingletonData sharedHighScoreData];
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
    submitButton.enabled = YES;
    
    self.currentLeaderBoard = kLeaderboardID;
    
    //If Game Center is available and...
    if ([GameCenterManager isGameCenterAvailable]) {
        [[GameCenterManager sharedGameCenterManager] setDelegate:self];
        //if the player is not authenticated
        if (! [GKLocalPlayer localPlayer].isAuthenticated)
        {
            [[GameCenterManager sharedGameCenterManager] authenticateLocalUser];
        }
        else 
            NSLog(@"Player is already authenticated");
    }
    else {
        NSLog(@"Game Center isn't available on this device");
    }
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
