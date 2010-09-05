//
//  AppDelegate_iPhone.m
//  JCD Portfolio
//
//  Created by John Duggins on 8/14/10.
//  Copyright 2010 John Duggins, Inc. All rights reserved.
//

#import "AppDelegate_iPhone.h"

@implementation AppDelegate_iPhone

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	//return [super application:application didFinishLaunchingWithOptions:launchOptions];
	
	ColorPicker *myFirstViewController = [[ColorPicker alloc] init];
	myFirstViewController.title = @"BGColor Picker";
    UINavigationController *navColorPicker = [[UINavigationController alloc] initWithRootViewController:myFirstViewController];
    navColorPicker.navigationBar.barStyle = UIBarStyleBlack;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"One" ofType:@"png"];
	[navColorPicker.tabBarItem initWithTitle:@"BGColor" image:[[UIImage alloc] initWithContentsOfFile:path] tag:0];
    
	GPS_iPhone *mySecondViewController = [[GPS_iPhone alloc] init];
    mySecondViewController.title = @"GPS Info";
	UINavigationController *navGPS = [[UINavigationController alloc] initWithRootViewController:mySecondViewController];
	navGPS.navigationBar.barStyle = UIBarStyleBlack;
    path = [[NSBundle mainBundle] pathForResource:@"Two" ofType:@"png"];
    [navGPS.tabBarItem initWithTitle:@"GPS" image:[[UIImage alloc] initWithContentsOfFile:path] tag:0];
	
	PrimaryViewController *myThirdViewController = [[PrimaryViewController alloc] init];
	myThirdViewController.title = @"Three";
	path = [[NSBundle mainBundle] pathForResource:myThirdViewController.title ofType:@"png"];
	[myThirdViewController.tabBarItem initWithTitle:myThirdViewController.title
											  image:[[UIImage alloc] initWithContentsOfFile:path] tag:0];
	
	NSArray *tbarArray = [NSArray arrayWithObjects:navColorPicker, navGPS, myThirdViewController, nil];
    
    [myFirstViewController release];
	[mySecondViewController release];
    [myThirdViewController release];
	[navColorPicker release];
    [navGPS release];
	
	UITabBarController *tbarController = [[UITabBarController alloc] init];
	tbarController.viewControllers = tbarArray;
	tbarController.delegate = self;
	
	NSNumber *tabNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTab"];
	if (tabNumber) tbarController.selectedIndex = [tabNumber intValue];
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	//window.backgroundColor = UIColor.whiteColor;
	
	[window addSubview:tbarController.view];
	[window makeKeyAndVisible];
    return YES;
	
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.

     Superclass implementation saves changes in the application's managed object context before the application terminates.
     */
	[super applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 Superclass implementation saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	[super applicationWillTerminate:application];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
    [super applicationDidReceiveMemoryWarning:application];
}


- (void)dealloc {
	
	[super dealloc];
}


@end

