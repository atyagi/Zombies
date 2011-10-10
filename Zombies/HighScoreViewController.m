//
//  HighScoreViewController.m
//  Zombies
//
//  Created by Ankit Tyagi on 6/20/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "HighScoreViewController.h"
#import "AppSpecificValues.h"

@implementation HighScoreViewController

@synthesize delegate = _delegate;
@synthesize namesOfScores, actualScores, displayArray, datesOfScores;
@synthesize currentLeaderBoard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        highScoreData = [HighScoreSingletonData sharedHighScoreData];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)done:(id)sender {
    [self.delegate highScoreViewDidFinish:self];
}

- (IBAction)resetHighScores:(id)sender {
    [highScoreData.tree removeAll];
    namesOfScores.text = nil;
    actualScores.text = nil;
    for (int i = 0; i < 10; i++) {
        HighScoreData *data = [[HighScoreData alloc] initWithScore:0 andName:@"Player"];
        [[highScoreData tree] insert:data];
    }
    [self showHighScores];
}

#pragma mark - Game Center Methods

- (IBAction)viewLeaderboard:(id)sender {
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.category = self.currentLeaderBoard;
        leaderboardController.timeScope = GKLeaderboardTimeScopeWeek;
        leaderboardController.leaderboardDelegate = self;
        [self presentModalViewController: leaderboardController animated: YES];
    }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
    [self dismissModalViewControllerAnimated: YES];
}

- (void) processGameCenterAuth: (NSError*) error {
	if(error == NULL) {
		[[GameCenterManager sharedGameCenterManager] reloadHighScoresForCategory: self.currentLeaderBoard];
        NSLog(@"Game Center was authorized");
	}
	else
		NSLog(@"Game Center was not authorized");
}

- (void) reloadScoresComplete: (GKLeaderboard*) leaderBoard error: (NSError*) error;
{
	if(error == NULL)
	{
        NSLog(@"Scores were reloaded correctly");
		if([leaderBoard.scores count] >0)
		{
			NSLog(@"And the score count is more than 0!");
		}
	}
	else
        NSLog(@"Scores were not reloaded properly");
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    namesOfScores.lineBreakMode = UILineBreakModeWordWrap;
    actualScores.lineBreakMode = UILineBreakModeWordWrap;
    namesOfScores.font = [UIFont fontWithName:@"Helvetica" size:16];
    actualScores.font = [UIFont fontWithName:@"Helvetica" size:16];
    namesOfScores.numberOfLines = 10;
    actualScores.numberOfLines = 10;
    [self showHighScores];
    
    [super viewDidLoad];
    
    self.currentLeaderBoard = kLeaderboardID;
    
    //If Game Center is available and...
    if ([GameCenterManager isGameCenterAvailable]) {
        [[GameCenterManager sharedGameCenterManager] setDelegate:self];
        //Local player is not authenticated
        if (! [GKLocalPlayer localPlayer].isAuthenticated)
        {
            [[GameCenterManager sharedGameCenterManager] authenticateLocalUser];
        }
    }
}

- (void)showHighScores {
    displayArray = [[highScoreData tree] getSortedHighScores];
    @autoreleasepool {
        int i = 1;
        NSString *nameString = [[NSString alloc] init];
        NSString *scoreString = [[NSString alloc] init];
        for (HighScoreData *highScores in displayArray) {
            nameString = [nameString stringByAppendingFormat:@"%d. ", i];
            nameString = [nameString stringByAppendingFormat:highScores.name];
            nameString = [nameString stringByAppendingFormat:@"\n"];
            scoreString = [scoreString stringByAppendingFormat:@"%d", highScores.score];
            scoreString = [scoreString stringByAppendingFormat:@"\n"];
            i = i + 1;
        }
        namesOfScores.text = nameString;
        actualScores.text = scoreString;
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

- (IBAction)retrieveTopTenScores:(id)sender
{
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
    if (leaderboardRequest != nil)
    {
        leaderboardRequest.playerScope = GKLeaderboardPlayerScopeGlobal;
        leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
        leaderboardRequest.range = NSMakeRange(1,10);
        [leaderboardRequest loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
            if (error != nil)
            {
                // handle the error.
            }
            if (scores != nil)
            {
                NSLog(@"Scores exist in the leaderboard");
                for (GKScore *score in scores) {
                    NSLog([NSString stringWithFormat:@"Name: %@", score.playerID]);
                    NSLog([NSString stringWithFormat:@"Score: %qi", score.value]);
                }
            }
        }];
    }
}

@end
