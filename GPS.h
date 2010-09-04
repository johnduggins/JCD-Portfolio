//
//  GPS.h
//  JCD Portfolio
//
//  Created by John Duggins on 8/17/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "PrimaryViewController.h"
#import "GPSTestMapViewController.h"


@interface GPS : PrimaryViewController <CLLocationManagerDelegate> {
    CLLocationManager *locManager;
	
    CLLocationDegrees lastLatitude;
    CLLocationDegrees lastLongitude;
    CLLocationDistance lastAltitude;
    CLLocationDirection lastHeading;
    CLLocationDirection lastCourse;
    CLLocationSpeed lastSpeed;
    CLLocationAccuracy bestAccuracy;
    NSDate *lastTimeStamp;
    
    UILabel *latitudeLabel;
    UILabel *longitudeLabel;
    UILabel *headingLabel;
    UILabel *speedLabel;
    
    UIButton *startGPSButton;
    UIButton *stopGPSButton;
    
    int accuracyCounter;
}

@property (nonatomic, retain) CLLocationManager *locManager;
@property (nonatomic, retain) CLLocation *lastLocation;
@property (nonatomic) CLLocationDegrees lastLatitude;
@property (nonatomic) CLLocationDegrees lastLongitude;
@property (nonatomic) CLLocationDistance lastAltitude;
@property (nonatomic) CLLocationDirection lastHeading;
@property (nonatomic) CLLocationDirection lastCourse;
@property (nonatomic) CLLocationSpeed lastSpeed;
@property (nonatomic) CLLocationAccuracy bestAccuracy;
@property (nonatomic, retain) NSDate *lastTimeStamp;
@property (nonatomic, retain) UILabel *latitudeLabel;
@property (nonatomic, retain) UILabel *longitudeLabel;
@property (nonatomic, retain) UILabel *headingLabel;
@property (nonatomic, retain) UILabel *speedLabel;
@property (nonatomic, retain) UIButton *startGPSButton;
@property (nonatomic, retain) UIButton *stopGPSButton;
@property (nonatomic) int accuracyCounter;


//-(void)makeOutputLabels;
//-(void)makeControlButtons;
-(void)startGPS;
-(void)stopGPS;
//-(void)displayMap;
-(void)createButtonsAndLabels;
-(void)moveUIElementsPortrait;
-(void)moveUIElementsLandscape;
-(void) loadButtonsAndLabels;
-(void)layoutButtonsAndLabels;

@end
