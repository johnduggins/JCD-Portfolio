//
//  MapAnnotation.m
//  TestBed
//
//  Created by John Duggins on 8/8/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id)initWithCoordinate: (CLLocationCoordinate2D) aCoordinate {
	if (self = [super init]) coordinate = aCoordinate;
	return self;
}

- (void) dealloc {
	[title release];
	[subtitle release];
	[super dealloc];
}

@end
