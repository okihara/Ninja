//
//  LocusAppDelegate.m
//  Locus
//
//  Created by utan on 10/09/26.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "NJAppDelegate.h"
#import "CocosViewController.h"
#import "cocos2d.h"

@implementation NJAppDelegate

@synthesize window;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	CocosViewController *viewController = [[CocosViewController alloc] init];
	viewController.delegate = self;
	[window addSubview:viewController.view];																
	[window makeKeyAndVisible];	
	
	[viewController runSceneBattle];
}

- (void)exitCocos
{
	NSLog(@"%s", __FUNCTION__);
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[CCDirector sharedDirector] end];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
