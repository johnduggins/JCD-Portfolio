//
//  ColorPicker.m
//  JCD Portfolio
//
//  Created by John Duggins on 8/15/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import "ColorPicker.h"


@implementation ColorPicker

@synthesize redSlider;
@synthesize blueSlider;
@synthesize greenSlider;
@synthesize alphaSlider;

- (id) init {
	self = [super init];
	
	redSlider = [[UISlider alloc] init];
	blueSlider = [[UISlider alloc] init];
	greenSlider = [[UISlider alloc] init];
	alphaSlider = [[UISlider alloc] init];
	
	redSlider.minimumValue = 0;
	blueSlider.minimumValue = 0;
	greenSlider.minimumValue = 0;
	alphaSlider.minimumValue = 0.0f;
	
	redSlider.maximumValue = 1.0f;
	blueSlider.maximumValue = 1.0f;
	greenSlider.maximumValue = 1.0f;
	alphaSlider.maximumValue = 1.0f;
	
	redSlider.value = 0.0f;
	blueSlider.value = 1.0f;
	greenSlider.value = 0.0f;
	alphaSlider.value = 1.0f;
		
	return self;
}

- (void) loadView {
	[super loadView];
	
	redSlider.frame = CGRectMake(0,0, 200, redSlider.frame.size.height);
	blueSlider.frame = CGRectMake(0,0, 200, redSlider.frame.size.height);
	greenSlider.frame = CGRectMake(0,0, 200, redSlider.frame.size.height);
	alphaSlider.frame = CGRectMake(0,0, 200, redSlider.frame.size.height);
	
	CGPoint myApplicationCenter = self.view.center;
	redSlider.center = CGPointMake(myApplicationCenter.x, 75);
	blueSlider.center = CGPointMake(myApplicationCenter.x, 275);
	greenSlider.center = CGPointMake(myApplicationCenter.x, 175);
	alphaSlider.center = CGPointMake(myApplicationCenter.x, 375);
	
	[redSlider addTarget:self action:@selector(updateBackground) 
        forControlEvents: UIControlEventTouchDown+UIControlEventTouchDragInside+UIControlEventTouchDragOutside+UIControlEventTouchUpInside+UIControlEventTouchUpOutside];
	[blueSlider addTarget:self action:@selector(updateBackground) 
         forControlEvents: UIControlEventTouchDown+UIControlEventTouchDragInside+UIControlEventTouchDragOutside+UIControlEventTouchUpInside+UIControlEventTouchUpOutside];
	[greenSlider addTarget:self action:@selector(updateBackground) 
          forControlEvents: UIControlEventTouchDown+UIControlEventTouchDragInside+UIControlEventTouchDragOutside+UIControlEventTouchUpInside+UIControlEventTouchUpOutside];
	[alphaSlider addTarget:self action:@selector(updateBackground) 
          forControlEvents: UIControlEventTouchDown+UIControlEventTouchDragInside+UIControlEventTouchDragOutside+UIControlEventTouchUpInside+UIControlEventTouchUpOutside];
	
	[self.view addSubview:redSlider];
	[self.view addSubview:blueSlider];
	[self.view addSubview:greenSlider];
	[self.view addSubview:alphaSlider];
	
}

- (void) updateBackground {
	self.view.backgroundColor = [UIColor colorWithRed:redSlider.value
												green:greenSlider.value blue:blueSlider.value alpha:alphaSlider.value];
	[ColorPicker setRedValue:redSlider.value];
	[ColorPicker setGreenValue:greenSlider.value];
	[ColorPicker setBlueValue:blueSlider.value];
	[ColorPicker setAlphaValue:alphaSlider.value];
	
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:redSlider.value] forKey:@"redBGColor"];
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:greenSlider.value] forKey:@"greenBGColor"];
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:blueSlider.value] forKey:@"blueBGColor"];
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:alphaSlider.value] forKey:@"alphaBGColor"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
