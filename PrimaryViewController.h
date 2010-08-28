//
//  PrimaryViewController.h
//  JCD Portfolio
//
//  Created by John Duggins on 8/14/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BARBUTTON(TITLE, SELECTOR) [[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease];

static CGFloat redValue = 0.0f;
static CGFloat greenValue = 0.0f;
static CGFloat blueValue = 1.0f;
static CGFloat alphaValue = 1.0f;

@interface PrimaryViewController : UIViewController {

}

-(BOOL)isVersion4;
+(void)setRedValue:(CGFloat)red;
+(void)setGreenValue:(CGFloat)green;
+(void)setBlueValue:(CGFloat)blue;
+(void)setAlphaValue:(CGFloat)alpha;
+(CGFloat)redValue;
+(CGFloat)greenValue;
+(CGFloat)blueValue;
+(CGFloat)alphaValue;

@end
