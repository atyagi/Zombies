//
//  MainViewController.m
//  Zombies
//
//  Gameplay view controller
//
//  Created by Ankit Tyagi on 6/9/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize scoreLabel, score, mainChar, menuButton, timeLeftLabel, gameOverButton, delegate;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)viewCollides:(UIView *)view1 withView:(UIView *)view2 {
    if(CGRectIntersectsRect(view1.frame, view2.frame))
    {
        return YES;
    }
    return NO;
}

#pragma mark MoveEnemy thread methods

- (void)backgroundMoveEnemy {
    [self performSelectorOnMainThread:@selector(moveEnemy) 
                           withObject:nil 
                        waitUntilDone:NO]; 
}

- (void)moveEnemy {
    @synchronized(self) {
        for (Enemy *iteratedEnemy in enemyList) {
            if (iteratedEnemy.myDirection == UP) [iteratedEnemy moveEnemyUp];
            else if (iteratedEnemy.myDirection == DOWN) [iteratedEnemy moveEnemyDown];
            else if (iteratedEnemy.myDirection == LEFT) [iteratedEnemy moveEnemyLeft];
            else [iteratedEnemy moveEnemyRight];
        }
    }
    if (!timeIsUp) {
        [NSTimer scheduledTimerWithTimeInterval:.04 
                                         target:self 
                                       selector:@selector(moveEnemy) 
                                       userInfo:nil 
                                        repeats:NO]; 
    }
    else {
        for (Enemy *iteratedEnemy in enemyList) {
            [iteratedEnemy removeFromSuperview];
        }
    }
}

#pragma mark Timer thread methods

- (void)backgroundDoTimeRemaining {
    [self performSelectorOnMainThread:@selector(runTimeRemaining) 
                           withObject:nil 
                        waitUntilDone:NO];
}

- (void)runTimeRemaining {
    @synchronized(self) {
        if (!gamePaused) {
            timeLeft = timeLeft - 1;
            if ((arc4random() % 60) > 57 && !bonusGiven) {
                bonusGiven = YES;
                bonusTimeRepeats = 0;
                [NSThread detachNewThreadSelector:@selector(backgroundMoveBonusTime) 
                                         toTarget:self
                                       withObject:nil];
            }
        }
        timeLeftLabel.text = [[NSString alloc] initWithFormat:@"%d", timeLeft];
    }
    if (timeLeft > 0) {
        [NSTimer scheduledTimerWithTimeInterval:1 
                                         target:self 
                                       selector:@selector(runTimeRemaining) 
                                       userInfo:nil 
                                        repeats:NO];
    }
    else {
        timeIsUp = YES;
    }
}

- (void)backgroundMoveBonusTime {
    bonusTime = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bonusTime.png"]];
    [bonusTime setAnimationDuration:1.0];
    [bonusTime setAnimationRepeatCount:10];
    bonusTime.center = CGPointMake((arc4random() % 320), (arc4random() % 480));
    [self.view addSubview:bonusTime];
    [self performSelectorOnMainThread:@selector(runMoveBonusTime) 
                           withObject:nil 
                        waitUntilDone:NO];
}

- (void)runMoveBonusTime {
    bonusTimeRepeats++;
    
    CGPoint pos = bonusTime.center;
    int direction = (arc4random() % 4) + 1;
    switch (direction) {
        case 1:
            pos.x = pos.x + 1;
            pos.y = pos.y + 1;
            break;
        case 2:
            pos.x = pos.x - 1;
            pos.y = pos.y + 1;
            break;
        case 3:
            pos.x = pos.x + 1;
            pos.y = pos.y - 1;
            break;
        case 4:
            pos.x = pos.x - 1;
            pos.y = pos.y - 1;
        default:
            pos.x = pos.x + 1;
            pos.y = pos.y + 1;
            break;
    }
    bonusTime.center = pos;
    
    if (![self viewCollides:mainChar withView:bonusTime]) {
        if (bonusTimeRepeats != 150) {
            [NSTimer scheduledTimerWithTimeInterval:.04 
                                             target:self 
                                           selector:@selector(runMoveBonusTime) 
                                           userInfo:nil 
                                            repeats:NO];
        }
        else {
            [bonusTime removeFromSuperview];
        }
    }
    else {
        timeLeft = timeLeft + 5;
        [bonusTime removeFromSuperview];
    }
    
}

- (CGPoint)moveToThisLocation:(CGPoint)location {
    if (mainChar.center.x < 0) 
        location.x = 319;
    else if (mainChar.center.x > 320)
        location.x = 1;
    else if (mainChar.center.y < 0)
        location.y = 479;
    else if (mainChar.center.y > 480)
        location.y = 1;
    else {
        location.x = location.x + x;
        location.y = location.y - y;
    }
    
    return location;
}

#pragma mark UIAccelerometerDelegate methods

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    if (!timeIsUp) {
        //Defaults if NSUserDefaults aren't declared
        float direction = 1;
        float sensitivity = 10.0f;
        
        //Get values needed for setting movement from NSUserDefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults floatForKey:@"sensitivityKey"] != 0.0f) 
            sensitivity = [defaults floatForKey:@"sensitivityKey"];
        
        if ([defaults integerForKey:@"directionKey"] == 1) 
            direction = -1;
        else if ([defaults integerForKey:@"directionKey"] == 0)
            direction = 1;
        
        double calibrationX = [defaults doubleForKey:@"calibrationXKey"];
        double offsetX = calibrationX * (sensitivity * (direction * -1));
        
        double calibrationY = [defaults doubleForKey:@"calibrationYKey"];
        double offsetY = calibrationY * (sensitivity * (direction * -1));
        
        //Sets new x and y values based on accelerometer and
        //settings from settings view
        x = (acceleration.x * direction * sensitivity) + offsetX;
        y = (acceleration.y * direction * sensitivity) + offsetY;
        
        //Start animation
        [UIView beginAnimations:nil context:NULL];
        
        //Moves main character and sets it to the new location
        mainChar.center = [self moveToThisLocation:mainChar.center];
        
        [UIView commitAnimations];
        
        @synchronized(self) {
            //Collision check
            for (Enemy *iteratedEnemy in enemyList) {
                if ([self viewCollides:mainChar withView:iteratedEnemy]) {
                    score = score + 1;
                    [iteratedEnemy removeFromSuperview];
                    
                    CGPoint currentPos;
                    
                    if (iteratedEnemy.myDirection == UP) {
                        iteratedEnemy.myDirection = LEFT;
                        currentPos = CGPointMake(300, (arc4random() % 300 + 20));
                    }
                    else if (iteratedEnemy.myDirection == LEFT) {
                        iteratedEnemy.myDirection = DOWN;
                        currentPos = CGPointMake((arc4random() % 300) + 20, 10);
                    }
                    else if (iteratedEnemy.myDirection == DOWN) {
                        iteratedEnemy.myDirection = RIGHT;
                        currentPos = CGPointMake(10, (arc4random() % 300 + 20));
                    }
                    else { 
                        iteratedEnemy.myDirection = UP;
                        currentPos = CGPointMake((arc4random() % 300) + 20, 460);
                    }
                    
                    iteratedEnemy.center = currentPos;
                    [self.view addSubview:iteratedEnemy];
                }
            }
        }
    
        scoreLabel.text = [[NSString alloc] initWithFormat:@"Score: %d", score];
        
    }
    else {
        UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
        accel.delegate = nil;
        menuButton.hidden = YES;
        HighScoreSingletonData *highScores = [HighScoreSingletonData sharedHighScore];
        if ([highScores.tree belongsInHighScores:score]) {
            HighScoreInputViewController *highScoreInputViewController = [[HighScoreInputViewController alloc] initWithNibName:@"HighScoreInputViewController" bundle:nil];
            highScoreInputViewController.delegate = self;
            highScoreInputViewController.newScore = score;
            highScoreInputViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentModalViewController:highScoreInputViewController animated:YES];
            
        }
        else {
            [mainChar removeFromSuperview];
            gameOverButton.hidden = NO;
        }
    }
}

- (IBAction)gameOver:(id)sender {
    [self.delegate mainViewDidFinish:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/30.0f;
    
    enemyList = [[NSMutableArray alloc] init];
    @autoreleasepool {
        for (int i = 0; i < 7; i++)
        {
            Enemy *newEnemy = [[Enemy alloc] initWithImage:[UIImage imageNamed:@"person.png"]];
            newEnemy.center = CGPointMake((arc4random() % 300) + 20, 419);
            newEnemy.myDirection = UP;
            [enemyList addObject:newEnemy];
            [self.view addSubview:newEnemy];
        }
    }
    
    [NSThread detachNewThreadSelector:@selector(backgroundMoveEnemy) 
                             toTarget:self 
                           withObject:nil];
    
    [NSThread detachNewThreadSelector:@selector(backgroundDoTimeRemaining) 
                             toTarget:self 
                           withObject:nil];
    
    score = 0;
    timeLeft = 60;
    timeIsUp = NO;
    
    defaultMainCharPosition = mainChar.center;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    mainChar.center = defaultMainCharPosition;
    gamePaused = NO;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    gamePaused = YES;
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Actions 

- (IBAction)showMenu:(id)sender {
    [self gameOver:sender];
}

- (IBAction)showSettings:(id)sender {
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = nil;
    gamePaused = YES;
    FlipsideViewController *settingsView = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    settingsView.delegate = self;
    settingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:settingsView animated:YES];
}

#pragma mark HighScoreInputDelegate Methods

- (void)highScoreWasEntered:(HighScoreInputViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
    [mainChar removeFromSuperview];
    gameOverButton.hidden = NO;
}

#pragma mark FlipsideViewControllerDelegate methods

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    gamePaused = NO;
}



@end
