//
//  GPS.m
//  JCD Portfolio
//
//  Created by John Duggins on 8/17/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "GPS.h"

//#define GPSSTARTBUTTON 13001
//#define GPSSTOPBUTTON 13002

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
	
	self.navigationItem.rightBarButtonItem = BARBUTTON(@"Map", @selector(displayMap));
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
	//NSLog(@"init the GPS object");
	
	//NSLog(@"This version is %@", [[UIDevice currentDevice] systemVersion]);
	
	self.locManager = [[[CLLocationManager alloc] init] autorelease];
	self.locManager.purpose = @"Generic GPS information gathering/display";
	if ((([CLLocationManager respondsToSelector:@selector(locationServicesEnabled)]) &&
		 (![CLLocationManager locationServicesEnabled])) || !(locManager.locationServicesEnabled)) {
		NSLog(@"user has opted out of location services");
		return self;
	}
	
	self.locManager.delegate = self;
	if (![self isVersion4])
		self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
	else 
		self.locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
	
	//self.locManager.headingFilter = kCLHeadingFilterNone;
	self.locManager.headingFilter = 1.0f; //in degress
	//self.locManager.distanceFilter = 5.0f; // in meters
	self.locManager.distanceFilter = kCLDistanceFilterNone;
	
	[self createButtonsAndLabels];
	
	self.accuracyCounter = 0;
	self.bestAccuracy = 1000000;
    
    self.locManager.headingOrientation = [UIDevice currentDevice].orientation;
	
	return self;
}

-(void) createButtonsAndLabels {
	self.startGPSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.stopGPSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.latitudeLabel = [[[UILabel alloc] init] autorelease];
	self.longitudeLabel = [[[UILabel alloc] init] autorelease];
	self.headingLabel = [[[UILabel alloc] init] autorelease];
	self.speedLabel = [[[UILabel alloc] init] autorelease];
	
	self.startGPSButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	self.startGPSButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[self.startGPSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.startGPSButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	[self.startGPSButton setTitle:@"Reset GPS" forState: UIControlStateNormal];
	self.startGPSButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
	
	self.stopGPSButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	self.stopGPSButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[self.stopGPSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.stopGPSButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	[self.stopGPSButton setTitle:@"Pause GPS" forState: UIControlStateNormal];
	self.stopGPSButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
	
	//startGPSButton.tag = GPSSTARTBUTTON;
	//stopGPSButton.tag = GPSSTOPBUTTON;
	
	//[self moveUIElements];
	
	[self.startGPSButton addTarget:self action:@selector(startGPS) forControlEvents: UIControlEventTouchUpInside];
	[self.stopGPSButton addTarget:self action:@selector(stopGPS) forControlEvents: UIControlEventTouchUpInside];
	
	self.latitudeLabel.textAlignment = UITextAlignmentCenter;
	self.longitudeLabel.textAlignment = UITextAlignmentCenter;
	self.headingLabel.textAlignment = UITextAlignmentCenter;
	self.speedLabel.textAlignment = UITextAlignmentCenter;
	
	[self layoutButtonsAndLabels];
	[self moveUIElements];
	
	if (([CLLocationManager respondsToSelector:@selector(headingAvailable)]) &&
		(![CLLocationManager headingAvailable]))
		headingLabel.text = @"No Compass";
	else if (!locManager.headingAvailable) headingLabel.text = @"No Compass";
	
    [self loadButtonsAndLabels];
	
	NSLog(@"Buttons and Labels created");
}

-(void) loadButtonsAndLabels {
    self.layoutItemCount = self.view.subviews.count;
    [self.view addSubview:self.longitudeLabel]; self.layoutItemCount++;
	[self.view addSubview:self.latitudeLabel]; self.layoutItemCount++;
	[self.view addSubview:self.headingLabel]; self.layoutItemCount++;
	[self.view addSubview:self.speedLabel]; self.layoutItemCount++;
	[self.view addSubview:self.startGPSButton]; self.layoutItemCount++;
	[self.view addSubview:self.stopGPSButton]; self.layoutItemCount++;
}

-(void) layoutButtonsAndLabels {
	self.latitudeLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.longitudeLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.headingLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.speedLabel.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);	
	self.startGPSButton.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);
	self.stopGPSButton.frame = CGRectMake(0.0f, 0.0f, 120.0f, 50.0f);	
}

/*-(void) moveUIElementsPortrait {	

    
    int width = [UIScreen mainScreen].bounds.size.width;

	int availableWidth = width - startGPSButton.bounds.size.width - stopGPSButton.bounds.size.width;
    int wBuffer = availableWidth/2;
    if (wBuffer > 60) wBuffer = 60;
    int topBuffer = 30;
    int hBuffer = ([UIScreen mainScreen].bounds.size.height - 100)/6;
    startGPSButton.center = CGPointMake(width/2 - wBuffer*2, topBuffer);
    stopGPSButton.center = CGPointMake(width/2 + wBuffer*2, topBuffer);
	
	self.longitudeLabel.center = CGPointMake(width/2 - wBuffer*2, topBuffer+hBuffer);
	self.latitudeLabel.center = CGPointMake(width/2 + wBuffer*2, topBuffer+hBuffer);
	
	self.speedLabel.center = CGPointMake(width/2 - wBuffer*2, topBuffer+hBuffer*2);
	self.headingLabel.center = CGPointMake(width/2 + wBuffer*2, topBuffer+hBuffer*2);
}

-(void) moveUIElementsLandscape {

    int width = [UIScreen mainScreen].bounds.size.height;
    
    int availableWidth = width - startGPSButton.bounds.size.width - stopGPSButton.bounds.size.width;
    int buffer = availableWidth/2;
    if (buffer > 60) buffer = 60;
    int topBuffer = 30;
    int hBuffer = ([UIScreen mainScreen].bounds.size.width - startGPSButton.bounds.size.height - stopGPSButton.bounds.size.height)/3.5;
    startGPSButton.center = CGPointMake(width/2 - buffer*2, topBuffer);
    stopGPSButton.center = CGPointMake(width/2 + buffer*2, topBuffer);
	
	self.longitudeLabel.center = CGPointMake(width/2 - buffer*2, topBuffer+hBuffer);
	self.latitudeLabel.center = CGPointMake(width/2 + buffer*2, topBuffer+hBuffer);
	
	self.speedLabel.center = CGPointMake(width/2 - buffer*2, topBuffer+hBuffer*2);
	self.headingLabel.center = CGPointMake(width/2 + buffer*2, topBuffer+hBuffer*2);
}*/

- (void)moveUIElements {
    int width;
    int height;
    int heightFactor;
    if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft 
		|| [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight) {
        height = [UIScreen mainScreen].bounds.size.width;
        width = [UIScreen mainScreen].bounds.size.height;
        heightFactor = 3.5;
        NSLog(@"moving UI elements to landscape");
    } else {
        width = [UIScreen mainScreen].bounds.size.width;
        height = [UIScreen mainScreen].bounds.size.height;
        heightFactor = 6;
        NSLog(@"moving UI elements to portrait");
    }
    
    int wBuffer = (width - startGPSButton.bounds.size.width - stopGPSButton.bounds.size.width)/2;
    int hBuffer = (height - startGPSButton.bounds.size.height - stopGPSButton.bounds.size.height)/heightFactor;
    if (wBuffer > 60) wBuffer = 60;
    int topBuffer = 30;
    
    startGPSButton.center = CGPointMake(width/2 - wBuffer*2, topBuffer);
    stopGPSButton.center = CGPointMake(width/2 + wBuffer*2, topBuffer);
	
	self.longitudeLabel.center = CGPointMake(width/2 - wBuffer*2, topBuffer+hBuffer);
	self.latitudeLabel.center = CGPointMake(width/2 + wBuffer*2, topBuffer+hBuffer);
	
	self.speedLabel.center = CGPointMake(width/2 - wBuffer*2, topBuffer+hBuffer*2);
	self.headingLabel.center = CGPointMake(width/2 + wBuffer*2, topBuffer+hBuffer*2);

}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	//UIButton *startGPSButton = (UIButton *)[self.view.window viewWithTag:GPSSTARTBUTTON];
	//UIButton *stopGPSButton = (UIButton *)[self.view.window viewWithTag:GPSSTOPBUTTON];
	
	[UIView beginAnimations:@"moveButtons" context:nil];
	[UIView setAnimationDuration:0.3];
	
	/*if ([UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait 
		|| [UIDevice currentDevice].orientation == UIInterfaceOrientationPortraitUpsideDown) {
		//|| self.interfaceOrientation == UIInterfaceOrientationPortrait 
		//|| self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"in portrait mode");
		[self moveUIElementsPortrait];
    } else if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft
			   || [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight) {
			   //|| self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft
			   //|| self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"in landscape mode");
		[self moveUIElementsLandscape];
    } else {
		NSLog(@"No idea how I got here");
	}*/
    [self moveUIElements];
    
    self.locManager.headingOrientation = toInterfaceOrientation;
	
	[UIView commitAnimations];
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
		self.latitudeLabel.text = [NSString stringWithFormat:@"%1.6f", self.lastLatitude];
		self.longitudeLabel.text = [NSString stringWithFormat:@"%1.6f", self.lastLongitude];
		if (((([CLLocationManager respondsToSelector:@selector(headingAvailable)]) &&
			  (![CLLocationManager headingAvailable])) || !(locManager.headingAvailable)) && self.lastCourse >= 0)
			self.headingLabel.text = [NSString stringWithFormat:@"%1.0fC deg",self.lastHeading = self.lastCourse];
		if (self.lastSpeed >= 0.0f) self.speedLabel.text = [NSString stringWithFormat:@"%1.2f mph",2.23693629 * self.lastSpeed];
	}
	
	//} else NSLog(@"Logging that the newlocation pulled in isn't registering");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	if ([lastTimeStamp timeIntervalSinceNow] > 5 || (lastSpeed < 1 && -[newHeading.timestamp timeIntervalSinceNow] <= 5.0)){
		float adjustment = 0.0f;
		float adjustedHeading = 0.0f;
		//if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft) adjustment = 10.0f;
		//else if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight) adjustment = -10.0f;
		if (newHeading.headingAccuracy >= 0.0f && newHeading.trueHeading > 0.0f) {//&& newHeading.headingAccuracy < 5.0f)
			adjustedHeading = newHeading.trueHeading + adjustment;
			if (adjustedHeading < 0.0f) adjustedHeading +=360.0f;
			else if (adjustedHeading >= 360.0f) adjustedHeading -= 360.0f;
			self.lastHeading = newHeading.trueHeading;
			self.headingLabel.text = [NSString stringWithFormat:@"%1.0fT deg", adjustedHeading];
		}
		else {
			adjustedHeading = newHeading.magneticHeading + adjustment;
			if (adjustedHeading < 0.0f) adjustedHeading +=360.0f;
			else if (adjustedHeading >= 360.0f) adjustedHeading -= 360.0f;
			self.lastHeading = newHeading.magneticHeading;
			self.headingLabel.text = [NSString stringWithFormat:@"%1.0fM deg", adjustedHeading];
		}
	} else if (lastCourse >= 0.0f) {
		headingLabel.text = [NSString stringWithFormat:@"%1.0fC deg",self.lastHeading = self.lastCourse];
	} else headingLabel.text = @"No Heading";
    
}

- (void) displayMap {
	
	GPSTestMapViewController *gtmvc = [[[GPSTestMapViewController alloc] initWithLocation:self.lastLocation andSpan:0.005f] autorelease];
	[self.navigationController pushViewController:gtmvc animated:YES];
	
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
	return YES;	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
	NSLog(@"Low memory in the GPS");
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	//if (self.startGPSButton == nil || self.latitudeLabel == nil) {
		//[self createButtonsAndLabels];	
	//}
    
    if (self.view.subviews.count < self.layoutItemCount) [self loadButtonsAndLabels];
    [self moveUIElements];
    
    //NSLog(@"GPS view coming back into view");
    [self startGPS];
}

- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self stopGPS];
}

- (void)viewDidUnload {
	
	//[self.locManager stopUpdatingLocation];
	//if ([CLLocationManager headingAvailable]) [self.locManager stopUpdatingHeading];
	
	//[self stopGPS];
	
	NSLog(@"Unloading view from GPS");
	
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
