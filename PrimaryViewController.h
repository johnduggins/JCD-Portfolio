//
//  PrimaryViewController.h
//  JCD Portfolio
//
//  Created by John Duggins on 8/14/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BARBUTTON(TITLE, SELECTOR) [[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease];

@interface PrimaryViewController : UIViewController {

}

-(BOOL)isVersion4;

@end
