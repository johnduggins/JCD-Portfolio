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
@synthesize redLabel;
@synthesize greenLabel;
@synthesize blueLabel;
@synthesize alphaLabel;

- (id) init {
	self = [super init];
	
	redSlider = [[UISlider alloc] init];
	blueSlider = [[UISlider alloc] init];
	greenSlider = [[UISlider alloc] init];
	alphaSlider = [[UISlider alloc] init];
    
    //redLabel = [[UIButton alloc] init];
    redLabel = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    greenLabel = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    blueLabel = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    alphaLabel = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    //greenLabel = [[UILabel alloc] init];
    //blueLabel = [[UILabel alloc] init];
    //alphaLabel = [[UILabel alloc] init];
	
	redSlider.minimumValue = 0.0f;
	blueSlider.minimumValue = 0.0f;
	greenSlider.minimumValue = 0.0f;
	alphaSlider.minimumValue = 0.0f;
	
	redSlider.maximumValue = 1.0f;
	blueSlider.maximumValue = 1.0f;
	greenSlider.maximumValue = 1.0f;
	alphaSlider.maximumValue = 1.0f;
    
    redLabel.enabled = FALSE;
    greenLabel.enabled = FALSE;
    blueLabel.enabled = FALSE;
    alphaLabel.enabled = FALSE;
    
    [redLabel setBackgroundColor:[UIColor redColor]];
    [redLabel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [greenLabel setBackgroundColor:[UIColor greenColor]];
    [greenLabel setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [blueLabel setBackgroundColor:[UIColor blueColor]];
    [blueLabel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [alphaLabel setBackgroundColor:[UIColor clearColor]];
    
    [redLabel setTitle:@"Red Value" forState:UIControlStateNormal];
    [greenLabel setTitle:@"Green Value" forState:UIControlStateNormal];
    [blueLabel setTitle:@"Blue Value" forState:UIControlStateNormal];
    [alphaLabel setTitle:@"Alpha Value" forState:UIControlStateNormal];
		
	return self;
}

- (void) loadView {
	[super loadView];
    
    self.redSlider.frame = CGRectMake(0,0, 100, 30);
    self.greenSlider.frame = CGRectMake(0,0, 100, redSlider.frame.size.height);
    self.blueSlider.frame = CGRectMake(0,0, 100, redSlider.frame.size.height);
    self.alphaSlider.frame = CGRectMake(0,0, 100, redSlider.frame.size.height);
    
    self.redLabel.frame = CGRectMake(0, 0, 100, 30);
    self.greenLabel.frame = CGRectMake(0, 0, 100, 30);
    self.blueLabel.frame = CGRectMake(0, 0, 100, 30);
    self.alphaLabel.frame = CGRectMake(0, 0, 100, 30);
	
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
    [self.view addSubview:redLabel];
    [self.view addSubview:greenLabel];
    [self.view addSubview:blueLabel];
    [self.view addSubview:alphaLabel];
	
	[redSlider setValue:[PrimaryViewController redValue] animated:YES];
	[blueSlider setValue:[PrimaryViewController blueValue] animated:YES];
	[greenSlider setValue:[PrimaryViewController greenValue] animated:YES];
	[alphaSlider setValue:[PrimaryViewController alphaValue] animated:YES];
	
	//NSLog(@"values are %f, %f, %f, %f", redValue, blueValue, greenValue, alphaValue);
	
}

- (void) layoutControllers {
    
    int hCenter = self.view.frame.size.width/2;
    int offCenter = 100;
    if (hCenter > 300) offCenter *= 2;
    //int tmp = self.view.frame.origin.x;
    
    if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft 
		|| [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight) {
        
        NSLog(@"Landscape sliders: %d", hCenter);        
        
        self.redSlider.frame = CGRectMake(self.redSlider.frame.origin.x, self.redSlider.frame.origin.y,200,30);
        self.greenSlider.frame = CGRectMake(self.greenSlider.frame.origin.x, self.greenSlider.frame.origin.y,200,30);
        self.blueSlider.frame = CGRectMake(self.blueSlider.frame.origin.x, self.blueSlider.frame.origin.y,200,30);
        self.alphaSlider.frame = CGRectMake(self.alphaSlider.frame.origin.x, self.alphaSlider.frame.origin.y,200,30);
        
        self.redSlider.center = CGPointMake(hCenter-offCenter, 75);
        self.greenSlider.center = CGPointMake(hCenter+offCenter, 75);
        self.blueSlider.center = CGPointMake(hCenter-offCenter, 155);
        self.alphaSlider.center = CGPointMake(hCenter+offCenter, 155);
        
        self.redLabel.center = CGPointMake(hCenter-offCenter, 35);
        self.greenLabel.center = CGPointMake(hCenter+offCenter, 35);
        self.blueLabel.center = CGPointMake(hCenter-offCenter, 115);
        self.alphaLabel.center = CGPointMake(hCenter+offCenter, 115);

    } else {
        
        NSLog(@"Portrait sliders: %d", hCenter);
        
        self.redSlider.frame = CGRectMake(self.redSlider.frame.origin.x, self.redSlider.frame.origin.y,100,30);
        self.greenSlider.frame = CGRectMake(self.greenSlider.frame.origin.x, self.greenSlider.frame.origin.y,100,30);
        self.blueSlider.frame = CGRectMake(self.blueSlider.frame.origin.x, self.blueSlider.frame.origin.y,100,30);
        self.alphaSlider.frame = CGRectMake(self.alphaSlider.frame.origin.x, self.alphaSlider.frame.origin.y,100,30);
        
        self.redSlider.center = CGPointMake(hCenter-offCenter, 75);
        self.greenSlider.center = CGPointMake(hCenter+offCenter, 75);
        self.blueSlider.center = CGPointMake(hCenter-offCenter, 225);
        self.alphaSlider.center = CGPointMake(hCenter+offCenter, 225);
        
        self.redLabel.center = CGPointMake(hCenter-offCenter, 35);
        self.greenLabel.center = CGPointMake(hCenter+offCenter, 35);
        self.blueLabel.center = CGPointMake(hCenter-offCenter, 185);
        self.alphaLabel.center = CGPointMake(hCenter+offCenter, 185);
        
    }
    
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    [UIView beginAnimations:@"moveSliders" context:nil];
	[UIView setAnimationDuration:0.3];
    
    [self layoutControllers];
    
    [UIView commitAnimations];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
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

-(void) dealloc {
    
    [redSlider release];
    [greenSlider release];
    [blueSlider release];
    [alphaSlider release];
    [redLabel release];
    [greenLabel release];
    [blueLabel release];
    [alphaLabel release];

    [super dealloc];

}

@end
