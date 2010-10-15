//
//  CocosViewController.m
//  Ninja
//
//  Created by okihara.masataka on 10/10/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CocosViewController.h"
#import "cocos2d.h"
#import "BattleScene.h"
#import "NJMissionScene.h"

@implementation CocosViewController

@synthesize delegate;

- (void)runSceneBattle
{
	[[CCDirector sharedDirector] replaceScene:[BattleScene scene]];
}

- (void)runSceneMission
{
	[[CCDirector sharedDirector] replaceScene:[NJMissionScene scene]];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView {
//
//}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
 	NSLog(@"%s", __FUNCTION__);

	CGRect frame = [[UIScreen mainScreen] bounds];
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )								
		[CCDirector setDirectorType:kCCDirectorTypeNSTimer];									
	CCDirector *__director = [CCDirector sharedDirector];										
	[__director setDeviceOrientation:kCCDeviceOrientationPortrait];								
	[__director setDisplayFPS:NO];																
	[__director setAnimationInterval:1.0/60];													
	EAGLView *__glView = [EAGLView viewWithFrame:frame	
									 pixelFormat:kEAGLColorFormatRGB565							
									 depthFormat:0 /* GL_DEPTH_COMPONENT24_OES */				
							  preserveBackbuffer:NO];											
	[__director setOpenGLView:__glView];
	
	// Obtain the shared director in order to...
	CCDirector *director = [CCDirector sharedDirector];
	
	// Sets landscape mode
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
	
	// Turn on display FPS
	[director setDisplayFPS:YES];
	
	// Turn on multiple touches
	EAGLView *view = [director openGLView];
	[view setMultipleTouchEnabled:YES];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888];	
	
	
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"untitled.plist"];
	
	self.view = __glView;
	
	[director runWithScene:[CCScene node]];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
