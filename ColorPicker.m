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
	
	redSlider.minimumValue = 0.0f;
	blueSlider.minimumValue = 0.0f;
	greenSlider.minimumValue = 0.0f;
	alphaSlider.minimumValue = 0.0f;
	
	redSlider.maximumValue = 1.0f;
	blueSlider.maximumValue = 1.0f;
	greenSlider.maximumValue = 1.0f;
	alphaSlider.maximumValue = 1.0f;
    
    [self layoutControllers];
		
	return self;
}

- (void) loadView {
	[super loadView];
	
	[self layoutControllers];
	
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
	
	[redSlider setValue:[PrimaryViewController redValue] animated:YES];
	[blueSlider setValue:[PrimaryViewController blueValue] animated:YES];
	[greenSlider setValue:[PrimaryViewController greenValue] animated:YES];
	[alphaSlider setValue:[PrimaryViewController alphaValue] animated:YES];
	
	//NSLog(@"values are %f, %f, %f, %f", redValue, blueValue, greenValue, alphaValue);
	
}

- (void) layoutControllers {
    
    if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft 
		|| [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight) {
        redSlider.frame = CGRectMake(0,0, 200, 30);
        blueSlider.frame = CGRectMake(0,0, 200, redSlider.frame.size.height);
        greenSlider.frame = CGRectMake(0,0, 200, redSlider.frame.size.height);
        alphaSlider.frame = CGRectMake(0,0, 200, redSlider.frame.size.height);
        
        CGPoint myApplicationCenter = self.view.center;
        redSlider.center = CGPointMake(myApplicationCenter.x+100, 75);
        blueSlider.center = CGPointMake(myApplicationCenter.x-100, 75);
        greenSlider.center = CGPointMake(myApplicationCenter.x+100, 225);
        alphaSlider.center = CGPointMake(myApplicationCenter.x-100, 225);

        
    } else {
        redSlider.frame = CGRectMake(0,0, 100, 30);
        blueSlider.frame = CGRectMake(0,0, 100, redSlider.frame.size.height);
        greenSlider.frame = CGRectMake(0,0, 100, redSlider.frame.size.height);
        alphaSlider.frame = CGRectMake(0,0, 100, redSlider.frame.size.height);
        
        CGPoint myApplicationCenter = self.view.center;
        redSlider.center = CGPointMake(myApplicationCenter.x, 75);
        blueSlider.center = CGPointMake(myApplicationCenter.x, 275);
        greenSlider.center = CGPointMake(myApplicationCenter.x, 175);
        alphaSlider.center = CGPointMake(myApplicationCenter.x, 375);
    }
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [UIView beginAnimations:@"moveSliders" context:nil];
	[UIView setAnimationDuration:0.3];
    
    [self layoutControllers];
    
    [UIView commitAnimations];
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
