//
//  GPS.m
//  JCD Portfolio
//
//  Created by John Duggins on 8/17/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "GPS.h"

#define GPSSTARTBUTTON 13001
#define GPSSTOPBUTTON 13002

@implementation GPS  

@synthesize locManager;
@synthesize lastLocation;
@synthesize lastLatitude;
@synthesize lastLongitude;
@synthesize lastAltitude;
@synthesize lastHeading;
@synthesize lastCourse;
@synthesize lastSpeed;
@synthesize bestAccuracy;
@synthesize lastTimeStamp;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize headingLabel;
@synthesize speedLabel;
@synthesize startGPSButton;
@synthesize stopGPSButton;
@synthesize accuracyCounter;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//self.navigationItem.rightBarButtonItem = BARBUTTON(@"Map", @selector(displayMap));
}

- (void) loadView {
    [super loadView];
    
    if ([UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait 
		|| [UIDevice currentDevice].orientation == UIInterfaceOrientationPortraitUpsideDown
		|| self.interfaceOrientation == UIInterfaceOrientationPortrait 
		|| self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"in portrait mode");
    } else if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft
			   || [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight
			   || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft
			   || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"in landscape mode");
    } else {
		NSLog(@"No idea how I got here");
	}
}

- (void) startGPS {
	
	if ((([CLLocationManager respondsToSelector:@selector(locationServicesEnabled)]) &&
		 ([CLLocationManager locationServicesEnabled])) || (locManager.locationServicesEnabled)) {
		[self.locManager startUpdatingLocation];
		NSLog(@"Heading update started");
	}
	
	if ((([CLLocationManager respondsToSelector:@selector(headingAvailable)]) &&
		 ([CLLocationManager headingAvailable])) || (locManager.headingAvailable)) {
		[self.locManager startUpdatingHeading];
		NSLog(@"Heading update started");
	}
}

- (void) stopGPS {
	
	if ((([CLLocationManager respondsToSelector:@selector(locationServicesEnabled)]) &&
		 ([CLLocationManager locationServicesEnabled])) || (locManager.locationServicesEnabled)) {
		[self.locManager stopUpdatingLocation];
		NSLog(@"Location update stopped");
	}
	
	if ((([CLLocationManager respondsToSelector:@selector(headingAvailable)]) &&
		 ([CLLocationManager headingAvailable])) || (locManager.headingAvailable)) {
		[self.locManager stopUpdatingHeading];
		NSLog(@"Heading update stopped");
	}
}

//- (id) initWithName:(NSString *)myName andPictureName:(NSString*)myPicture andAlpha:(CGFloat)myAlpha {
-(id) init {
	//self = [super initWithName:myName andPictureName:myPicture andAlpha:myAlpha];
    self = [super init];
	
	self.locManager = [[[CLLocationManager alloc] init] autorelease];
	self.locManager.purpose = @"Generic GPS information gathering/display";
	//if (!self.locManager.locationServicesEnabled) {
	//if (![CLLocationManager locationServicesEnabled]) {
	if ((([CLLocationManager respondsToSelector:@selector(locationServicesEnabled)]) &&
		 (![CLLocationManager locationServicesEnabled])) || !(locManager.locationServicesEnabled)) {
		NSLog(@"user has opted out of location services");
		return self;
	}
	
	self.locManager.delegate = self;
	if ([self isVersion4]) self.locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
	else self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
	//self.locManager.distanceFilter = 5.0f; // in meters
	self.locManager.headingFilter = 1.0f; //in degress
	self.locManager.distanceFilter = kCLDistanceFilterNone;
	//self.locManager.headingFilter = kCLHeadingFilterNone;
	
	self.accuracyCounter = 0;
	self.bestAccuracy = 1000000;
	
	return self;
}

/*- (UIView *) loadPortraitView {
	
	UIView *tempView = [super loadPortraitView];
	
	if (startGPSButton.tag == 0 || stopGPSButton.tag == 0) {
		NSLog(@"Making new buttons");
		startGPSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		stopGPSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		startGPSButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		startGPSButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		[startGPSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[startGPSButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
		[startGPSButton setTitle:@"Reset GPS" forState: UIControlStateNormal];
		startGPSButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		
		stopGPSButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		stopGPSButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		[stopGPSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[stopGPSButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
		[stopGPSButton setTitle:@"Pause GPS" forState: UIControlStateNormal];
		stopGPSButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		
		startGPSButton.tag = GPSSTARTBUTTON;
		stopGPSButton.tag = GPSSTOPBUTTON;
		
		[startGPSButton addTarget:self action:@selector(startGPS) forControlEvents: UIControlEventTouchUpInside];
		[stopGPSButton addTarget:self action:@selector(stopGPS) forControlEvents: UIControlEventTouchUpInside];
		
	}
	
	if (self.latitudeLabel == nil || self.longitudeLabel == nil || self.headingLabel == nil || self.speedLabel == nil) {
		
		self.latitudeLabel = [[[UILabel alloc] init] autorelease];
		self.longitudeLabel = [[[UILabel alloc] init] autorelease];
		self.headingLabel = [[[UILabel alloc] init] autorelease];
		self.speedLabel = [[[UILabel alloc] init] autorelease];
		
		
		
		self.latitudeLabel.textAlignment = UITextAlignmentCenter;
		self.longitudeLabel.textAlignment = UITextAlignmentCenter;
		self.headingLabel.textAlignment = UITextAlignmentCenter;
		self.speedLabel.textAlignment = UITextAlignmentCenter;
		
	}
	
	//Class CLLMTester = [CLLocationManager class];
	if (([CLLocationManager respondsToSelector:@selector(headingAvailable)]) &&
		(![CLLocationManager headingAvailable]))
		headingLabel.text = @"No Compass";
	else if (!locManager.headingAvailable) headingLabel.text = @"No Compass";
	
	//NSArray *labelArray = [self makeOutputLabels];
	//NSArray *buttonArray = [self makeControlButtons];
	
	
	if ((([CLLocationManager respondsToSelector:@selector(headingAvailable)]) &&
		 ([CLLocationManager headingAvailable])) || (locManager.headingAvailable)) {
		if ([UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait)
			self.locManager.headingOrientation = CLDeviceOrientationPortrait;
		else if ([UIDevice currentDevice].orientation == UIInterfaceOrientationPortraitUpsideDown)
			self.locManager.headingOrientation = CLDeviceOrientationPortraitUpsideDown;
		else NSLog(@"Unknown orientation for heading adjustment: %d", self.interfaceOrientation);
	}
	
	[self.view addSubview:self.longitudeLabel];
	[self.view addSubview:self.latitudeLabel];
	[self.view addSubview:self.headingLabel];
	[self.view addSubview:self.speedLabel];
	[self.view addSubview:startGPSButton];
	[self.view addSubview:stopGPSButton];
	
	[UIView beginAnimations:@"moveButtons" context:nil];
	[UIView setAnimationDuration:0.3];
	
	self.latitudeLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.longitudeLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.headingLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.speedLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	
	startGPSButton.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	stopGPSButton.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	
	startGPSButton.center = CGPointMake(80.0f, 60.0f);
	stopGPSButton.center = CGPointMake(240.0f, 60.0f);
	
	self.longitudeLabel.center = CGPointMake(80.0f, 120.0f);
	self.latitudeLabel.center = CGPointMake(240.0f, 120.0f);
	
	self.speedLabel.center = CGPointMake(80.0f, 180.0f);
	self.headingLabel.center = CGPointMake(240.0f, 180.0f);
	
	[UIView commitAnimations];
	
	return tempView;
}*/

/*- (UIView *) loadLandscapeView {
	
	UIView *tempView = [super loadLandscapeView];
	
	if (startGPSButton.tag == 0 || stopGPSButton.tag == 0) {
		NSLog(@"Making new buttons");
		startGPSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		stopGPSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		startGPSButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		startGPSButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		[startGPSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[startGPSButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
		[startGPSButton setTitle:@"Reset GPS" forState: UIControlStateNormal];
		startGPSButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		
		stopGPSButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		stopGPSButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		[stopGPSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[stopGPSButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
		[stopGPSButton setTitle:@"Pause GPS" forState: UIControlStateNormal];
		stopGPSButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		
		startGPSButton.tag = GPSSTARTBUTTON;
		stopGPSButton.tag = GPSSTOPBUTTON;
		
		[startGPSButton addTarget:self action:@selector(startGPS) forControlEvents: UIControlEventTouchUpInside];
		[stopGPSButton addTarget:self action:@selector(stopGPS) forControlEvents: UIControlEventTouchUpInside];
		
	}
	
	//NSLog(@"tags are %d and %d",startGPSButton.tag, stopGPSButton.tag);
	
	if (self.latitudeLabel == nil || self.longitudeLabel == nil || self.headingLabel == nil || self.speedLabel == nil) {
		
		self.latitudeLabel = [[[UILabel alloc] init] autorelease];
		self.longitudeLabel = [[[UILabel alloc] init] autorelease];
		self.headingLabel = [[[UILabel alloc] init] autorelease];
		self.speedLabel = [[[UILabel alloc] init] autorelease];
		
		
		
		self.latitudeLabel.textAlignment = UITextAlignmentCenter;
		self.longitudeLabel.textAlignment = UITextAlignmentCenter;
		self.headingLabel.textAlignment = UITextAlignmentCenter;
		self.speedLabel.textAlignment = UITextAlignmentCenter;
	}
	
	//Class CLLMTester = [CLLocationManager class];
	if (([CLLocationManager respondsToSelector:@selector(headingAvailable)]) &&
		(![CLLocationManager headingAvailable]))
		headingLabel.text = @"No Compass";
	else if (!locManager.headingAvailable) headingLabel.text = @"No Compass";
	
	//[self makeOutputLabels];
	//[self makeControlButtons];
	
	if ((([CLLocationManager respondsToSelector:@selector(headingAvailable)]) &&
		 ([CLLocationManager headingAvailable])) || (locManager.headingAvailable)) {
		if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft)
			self.locManager.headingOrientation = CLDeviceOrientationLandscapeRight;
		else if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight)
			self.locManager.headingOrientation = CLDeviceOrientationLandscapeLeft;
		else NSLog(@"Unknown orientation for heading adjustment: %d", self.interfaceOrientation);
	}
	
	[self.view addSubview:self.longitudeLabel];
	[self.view addSubview:self.latitudeLabel];
	[self.view addSubview:self.headingLabel];
	[self.view addSubview:self.speedLabel];
	[self.view addSubview:startGPSButton];
	[self.view addSubview:stopGPSButton];
	
	[UIView beginAnimations:@"moveButtons" context:nil];
	[UIView setAnimationDuration:0.3];
	
	startGPSButton.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	stopGPSButton.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	
	self.latitudeLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.longitudeLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.headingLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.speedLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	
	startGPSButton.center = CGPointMake(160.0f, 60.0f);
	stopGPSButton.center = CGPointMake(320.0f, 60.0f);
	
	self.longitudeLabel.center = CGPointMake(160.0f, 120.0f);
	self.latitudeLabel.center = CGPointMake(320.0f, 120.0f);
	
	self.speedLabel.center = CGPointMake(160.0f, 180.0f);
	self.headingLabel.center = CGPointMake(320.0f, 180.0f);
	
	[UIView commitAnimations];
	
	
	
	return tempView;
}*/

- (void) viewWillAppear:(BOOL)animated {
	UIButton *startGPSButton = (UIButton *)[self.view.window viewWithTag:GPSSTARTBUTTON];
	UIButton *stopGPSButton = (UIButton *)[self.view.window viewWithTag:GPSSTOPBUTTON];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	UIButton *startGPSButton = (UIButton *)[self.view.window viewWithTag:GPSSTARTBUTTON];
	UIButton *stopGPSButton = (UIButton *)[self.view.window viewWithTag:GPSSTOPBUTTON];
	
	if ([UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait 
		|| [UIDevice currentDevice].orientation == UIInterfaceOrientationPortraitUpsideDown) {
		//|| self.interfaceOrientation == UIInterfaceOrientationPortrait 
		//|| self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"in portrait mode");
    } else if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft
			   || [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight) {
			   //|| self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft
			   //|| self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"in landscape mode");
    } else {
		NSLog(@"No idea how I got here");
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	//NSLog(@"Can't get location, captain. Error is %@",[error description]);
	NSLog(@"error code is %d",error.code);
	if (error.code == kCLErrorLocationUnknown) NSLog(@"She can't find where she is, captain.");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {	
	self.accuracyCounter++;
	NSLog(@"Accuracy is %f and the accuracy counter is %d",newLocation.horizontalAccuracy, self.accuracyCounter);
	if (newLocation.horizontalAccuracy > 0 && newLocation.horizontalAccuracy < self.bestAccuracy) {
		self.bestAccuracy = newLocation.horizontalAccuracy;
		self.lastLatitude = newLocation.coordinate.latitude;
		self.lastLongitude = newLocation.coordinate.longitude;
		self.lastAltitude = newLocation.altitude;
		self.lastCourse = newLocation.course;
		self.lastSpeed = newLocation.speed;
		self.lastTimeStamp = newLocation.timestamp;
		self.lastLocation = newLocation;
		
	}
	if (self.accuracyCounter >= 3) {
		self.accuracyCounter = 0;
		self.bestAccuracy = 1000000;
		latitudeLabel.text = [NSString stringWithFormat:@"%1.6f", self.lastLatitude];
		longitudeLabel.text = [NSString stringWithFormat:@"%1.6f", self.lastLongitude];
		if (((([CLLocationManager respondsToSelector:@selector(headingAvailable)]) &&
			  (![CLLocationManager headingAvailable])) || !(locManager.headingAvailable)) && self.lastCourse >= 0)
			headingLabel.text = [NSString stringWithFormat:@"%1.0fC deg",self.lastHeading = self.lastCourse];
		if (self.lastSpeed >= 0.0f) speedLabel.text = [NSString stringWithFormat:@"%1.2f mph",2.23693629 * self.lastSpeed];
	}
	
	//} else NSLog(@"Logging that the newlocation pulled in isn't registering");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	if ([self.lastTimeStamp timeIntervalSinceNow] > 5 || (self.lastSpeed < 1 && -[newHeading.timestamp timeIntervalSinceNow] <= 5.0)){
		float adjustment = 0.0f;
		float adjustedHeading = 0.0f;
		//if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft) adjustment = 10.0f;
		//else if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight) adjustment = -10.0f;
		if (newHeading.headingAccuracy >= 0.0f && newHeading.trueHeading > 0.0f) {//&& newHeading.headingAccuracy < 5.0f)
			adjustedHeading = newHeading.trueHeading + adjustment;
			if (adjustedHeading < 0.0f) adjustedHeading +=360.0f;
			else if (adjustedHeading >= 360.0f) adjustedHeading -= 360.0f;
			self.lastHeading = newHeading.trueHeading;
			headingLabel.text = [NSString stringWithFormat:@"%1.0fT deg", adjustedHeading];
		}
		else {
			adjustedHeading = newHeading.magneticHeading + adjustment;
			if (adjustedHeading < 0.0f) adjustedHeading +=360.0f;
			else if (adjustedHeading >= 360.0f) adjustedHeading -= 360.0f;
			self.lastHeading = newHeading.magneticHeading;
			headingLabel.text = [NSString stringWithFormat:@"%1.0fM deg", adjustedHeading];
		}
	} else if (self.lastCourse >= 0.0f) {
		headingLabel.text = [NSString stringWithFormat:@"%1.0fC deg",self.lastHeading = self.lastCourse];
	} else headingLabel.text = @"No Heading";
    
}

/*- (void) displayMap {
	
	GPSTestMapViewController *gtmvc = [[[GPSTestMapViewController alloc] initWithLocation:self.lastLocation andSpan:0.005f] autorelease];
	[self.navigationController pushViewController:gtmvc animated:YES];
	
}*/

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
	return YES;	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
	NSLog(@"Low memory in the GPSTestViewController");
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/*-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [self startGPS];
}*/

- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self stopGPS];
}

- (void)viewDidUnload {
	
	//[self.locManager stopUpdatingLocation];
	//if ([CLLocationManager headingAvailable]) [self.locManager stopUpdatingHeading];
	
	//[self stopGPS];
	
	NSLog(@"Unloading view from GPSTestViewController");
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[locManager release];
	[lastLocation release];
	[lastTimeStamp release];
	[latitudeLabel release];
	[longitudeLabel release];
	[headingLabel release];
	[speedLabel release];
	//[startGPSButton release];
	//[stopGPSButton release];
    [super dealloc];
}



@end
