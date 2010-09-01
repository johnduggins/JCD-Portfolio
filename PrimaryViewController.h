//
//  PrimaryViewController.h
//  JCD Portfolio
//
//  Created by John Duggins on 8/14/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BARBUTTON(TITLE, SELECTOR) [[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease];

static CGFloat redValue;
static CGFloat greenValue;
static CGFloat blueValue;
static CGFloat alphaValue;

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
