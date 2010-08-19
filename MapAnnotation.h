//
//  MapAnnotation.h
//  TestBed
//
//  Created by John Duggins on 8/8/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MapAnnotation : NSObject <MKAnnotation>{
	
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;

}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

@end
