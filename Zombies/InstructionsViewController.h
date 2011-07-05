//
//  InstructionsViewController.h
//  Zombies
//
//  Created by Developer on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InstructionsViewController;

@protocol InstructionsViewControllerDelegate 

- (void)instructionsViewFinished:(InstructionsViewController*)controller;

@end

@interface InstructionsViewController : UIViewController 
<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    
    BOOL pageControlIsChangingPage;
}

@property (weak) IBOutlet id <InstructionsViewControllerDelegate> delegate;
@property (strong) IBOutlet UIScrollView *scrollView;
@property (strong) IBOutlet UIPageControl *pageControl;

- (IBAction)done:(id)sender;
- (IBAction)changePage:(id)sender;
- (void)setupPage;

@end
