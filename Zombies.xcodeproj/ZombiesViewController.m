//
//  ZombiesViewController.m
//  Zombies
//
//  Main menu view controller.
//
//  Created by Ankit Tyagi on 6/20/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "ZombiesViewController.h"

@implementation ZombiesViewController

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

- (IBAction)playGame:(id)sender {
    MainViewController *playGameController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    playGameController.delegate = self;
    playGameController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:playGameController animated:YES];
}

- (IBAction)viewHighScores:(id)sender {
    HighScoreViewController *highScoresViewController = [[HighScoreViewController alloc] initWithNibName:@"HighScoreViewController" bundle:nil];
    highScoresViewController.delegate = self;
    highScoresViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:highScoresViewController animated:YES];
}

- (IBAction)viewSettings:(id)sender {
    FlipsideViewController *settingsView = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    settingsView.delegate = self;
    settingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:settingsView animated:YES];

}

- (IBAction)viewInstructions:(id)sender {
    InstructionsViewController *instructionsView = [[InstructionsViewController alloc] initWithNibName:@"InstructionsViewController" bundle:nil];
    instructionsView.delegate = self;
    instructionsView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:instructionsView animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - MainViewControllerDelegate

- (void)mainViewDidFinish:(MainViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - FlipsideViewControllerDelegate

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - HighScoreViewControllerDelegate

- (void)highScoreViewDidFinish:(HighScoreViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - InstructionsViewControllerDelegate

- (void)instructionsViewFinished:(InstructionsViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
}

@end
