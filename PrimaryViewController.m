    //
//  PrimaryViewController.m
//  JCD Portfolio
//
//  Created by John Duggins on 8/14/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import "PrimaryViewController.h"


@implementation PrimaryViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.view.backgroundColor = UIColor.blueColor;
	//self.view.alpha = 0.35f;
	/*self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin+UIViewAutoresizingFlexibleRightMargin+UIViewAutoresizingFlexibleTopMargin+UIViewAutoresizingFlexibleBottomMargin+UIViewAutoresizingFlexibleWidth+UIViewAutoresizingFlexibleHeight;*/
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth+UIViewAutoresizingFlexibleHeight;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (BOOL) isVersion4 {
	NSString* ver = [[UIDevice currentDevice] systemVersion];
	float version = 4.0;
	
	if ([ver length]>=3) version = [[ver substringToIndex:3] floatValue];
	
	return (version >= 4.0 && version < 5.0);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
