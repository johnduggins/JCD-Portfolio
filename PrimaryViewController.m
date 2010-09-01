    //
//  PrimaryViewController.m
//  JCD Portfolio
//
//  Created by John Duggins on 8/14/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import "PrimaryViewController.h"


@implementation PrimaryViewController

+(void) initalize {
	blueValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"blueBGColor"] floatValue];
	greenValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"greenBGColor"] floatValue];
	redValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"redBGColor"] floatValue];
	alphaValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"alphaBGColor"] floatValue];
}

- (id) init {
	self = [super init];
	blueValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"blueBGColor"] floatValue];
	greenValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"greenBGColor"] floatValue];
	redValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"redBGColor"] floatValue];
	alphaValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"alphaBGColor"] floatValue];
	
	return self;
}

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
	//self.view.backgroundColor = UIColor.blueColor;
	/*self.view.backgroundColor = [UIColor colorWithRed:[PrimaryViewController redValue]
												green:[PrimaryViewController greenValue]
												 blue:[PrimaryViewController blueValue]
												alpha:[PrimaryViewController alphaValue]];*/
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

- (void) viewWillAppear:(BOOL)animated {
	self.view.backgroundColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:alphaValue];
	//NSLog(@"colors are %f, %f, %f and %f",redValue, greenValue, blueValue, alphaValue);
}

+ (void) setRedValue:(CGFloat)red {
	redValue = red;
	//NSLog(@"redValue is %f",redValue);
}

+ (CGFloat) redValue {
	return redValue;	
}

+ (void) setGreenValue:(CGFloat)green {
	greenValue = green;	
	//NSLog(@"greenValue is %f",greenValue);
}

+ (CGFloat) greenValue {
	return greenValue;	
}

+ (void) setBlueValue:(CGFloat)blue {
	blueValue = blue;
	//NSLog(@"blueValue is %f",blueValue);
}

+ (CGFloat) blueValue {
	return blueValue;
}

+ (void) setAlphaValue:(CGFloat)alpha {
	alphaValue = alpha;
	//NSLog(@"alphaValue is %f",alphaValue);
}

+ (CGFloat) alphaValue {
	return alphaValue;	
}

- (BOOL) isVersion4 {
	NSString* ver = [[UIDevice currentDevice] systemVersion];
	float version = 4.0;
	
	if ([ver length]>=3) version = [[ver substringToIndex:3] floatValue];
	
	NSLog(@"This version is %@", ver);
	
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
