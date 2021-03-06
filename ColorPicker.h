//
//  ColorPicker.h
//  JCD Portfolio
//
//  Created by John Duggins on 8/15/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrimaryViewController.h"


@interface ColorPicker : PrimaryViewController {
	
	UISlider *redSlider;
	UISlider *blueSlider;
	UISlider *greenSlider;
	UISlider *alphaSlider;
    
    UIButton *redLabel;
    UIButton *greenLabel;
    UIButton *blueLabel;
    UIButton *alphaLabel;

}

@property (nonatomic, retain) UISlider *redSlider;
@property (nonatomic, retain) UISlider *blueSlider;
@property (nonatomic, retain) UISlider *greenSlider;
@property (nonatomic, retain) UISlider *alphaSlider;
@property (nonatomic, retain) UIButton *redLabel;
@property (nonatomic, retain) UIButton *greenLabel;
@property (nonatomic, retain) UIButton *blueLabel;
@property (nonatomic, retain) UIButton *alphaLabel;

-(void)updateBackground;
-(void)layoutControllers;

@end
