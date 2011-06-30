//
//  HighScoreViewController.m
//  Zombies
//
//  Created by Ankit Tyagi on 6/20/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "HighScoreViewController.h"

@implementation HighScoreViewController

@synthesize delegate = _delegate;
@synthesize namesOfScores, actualScores, displayArray, highScoreData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        highScoreData = [HighScoreSingletonData sharedHighScore];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    namesOfScores.lineBreakMode = UILineBreakModeWordWrap;
    actualScores.lineBreakMode = UILineBreakModeWordWrap;
    namesOfScores.numberOfLines = 10;
    actualScores.numberOfLines = 10;
    [self showHighScores];
}

- (void)showHighScores {
    displayArray = [[highScoreData tree] getSortedHighScores];
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
