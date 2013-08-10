//
//  DDProgressViewViewController.m
//  DDProgressView
//
//  Created by Damien DeVille on 3/13/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import "DDProgressViewViewController.h"
#import "DDProgressView.h"

@implementation DDProgressViewViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning] ;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
	// set a timer that updates the progress
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 0.03f target: self selector: @selector(updateProgress) userInfo: nil repeats: YES] ;
	[timer fire] ;
}

- (void)viewDidLoad
{
    testProgress = 0.0f ;
    progressDir = 1 ;
    
    [super viewDidLoad] ;
    
	[self.view setBackgroundColor: [UIColor blackColor]] ;
	
	self.progressView = [[DDProgressView alloc] initWithFrame: CGRectMake(20.0f, 140.0f, self.view.bounds.size.width-40.0f, 0.0f)] ;
    self.progressView.innerColor = [UIColor lightGrayColor] ;
    self.progressView.outerColor = [UIColor grayColor] ;
	[self.view addSubview: self.progressView] ;
    
    self.progressView2 = [[DDProgressView alloc] initWithFrame: CGRectMake(20.0f, 180.0f, self.view.bounds.size.width-40.0f, 0.0f)] ;
    self.progressView2.emptyColor = [UIColor darkGrayColor] ;
    self.progressView2.innerColor = [UIColor lightGrayColor] ;
    self.progressView2.outerColor = [UIColor clearColor] ;
    [self.view addSubview: self.progressView2] ;
}

- (void)updateProgress
{
	testProgress += (0.01f * progressDir) ;
	[self.progressView setProgress: testProgress] ;
    [self.progressView2 setProgress: testProgress] ;
    
    if (testProgress > 1 || testProgress < 0)
        progressDir *= -1 ;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
