//
//  main.m
//  JCD Portfolio
//
//  Created by John Duggins on 8/14/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal;
	
	if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&
		[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate_iPhone");
	} else if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&
			   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate_iPad");
	}
    [pool release];
    return retVal;
}
