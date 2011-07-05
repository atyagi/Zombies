//
//  InstructionsViewController.m
//  Zombies
//
//  Created by Ankit Tyagi on 7/4/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import "InstructionsViewController.h"

@implementation InstructionsViewController

@synthesize delegate;
@synthesize pageControl, scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (IBAction)done:(id)sender {
    [self.delegate instructionsViewFinished:self];
}

- (void)setupPage {
    scrollView.delegate = self;
    
    [self.scrollView setBackgroundColor:[UIColor blackColor]];
    [scrollView setCanCancelContentTouches:NO];
    
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    
	int nimages = 1;
	CGFloat cx = 0;
	for (int i = 0; i < 3; i++) {
		NSString *imageName = [NSString stringWithFormat:@"instructions%d.png", nimages];
		UIImage *image = [UIImage imageNamed:imageName];
		if (image == nil) {
			break;
		}
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		CGRect rect = imageView.frame;
		rect.size.height = (image.size.height / 2);
		rect.size.width = (image.size.width / 2);
		rect.origin.x = 0 + cx;
		rect.origin.y = 44;
        
		imageView.frame = rect;
        
		[scrollView addSubview:imageView];
        
		cx += scrollView.frame.size.width;
        nimages++;
	}
	
	self.pageControl.numberOfPages = 3;
	[scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
}

- (IBAction)changePage:(id)sender {
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrollView scrollRectToVisible:frame animated:YES];
    
    pageControlIsChangingPage = YES;
}

#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)passedScrollView {
    if (pageControlIsChangingPage) {
        return;
    }
    
    CGFloat pageWidth = passedScrollView.frame.size.width;
    int page = floor((passedScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)passedScrollView {
    pageControlIsChangingPage = NO;
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
    [self setupPage];
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
