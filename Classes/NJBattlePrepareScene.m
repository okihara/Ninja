//
//  NJBattlePrepareScene.m
//  Ninja
//
//  Created by okihara.masataka on 10/10/18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NJBattlePrepareScene.h"
#import "NJCommon.h"
#import "NJBattleScene.h"

@implementation NJBattlePrepareScene

+ (id)scene
{
	CCScene *scene = [CCScene node];
	[scene addChild:[NJBattlePrepareScene node]];
	return scene;
}

- (id)init
{
	if( (self=[super init]) ) {
		self.isTouchEnabled = YES;
		
		CCLabel *label = [CCLabel labelWithString:@"Battle Prepare Scene" fontName:DEFAULT_FONT_NAME fontSize:48];
		label.position = ccp(240, 180);
		[self addChild:label];
		
		CCLabel *tapLabel = [CCLabel labelWithString:@"Tap to start" fontName:DEFAULT_FONT_NAME fontSize:48];
		tapLabel.position = ccp(240, 120);
		[self addChild:tapLabel];
	}
	
	return self;
}

- (void)onEnter
{
	NSLog(@"%s", __FUNCTION__);
	
	[super onEnter];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"%s", __FUNCTION__);

	[[CCDirector sharedDirector] replaceScene:[NJBattleScene scene]];
}

@end
