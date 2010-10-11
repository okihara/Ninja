//
//  WinScene.m
//  Locus
//
//  Created by okihara.masataka on 10/09/28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ResultScene.h"
#import "BattleScene.h"

@implementation ResultScene

+(id)scene
{
	CCScene *scene = [CCScene node];
	[scene addChild:[ResultScene node]];
	return scene;
}

- (id)init
{
	if( (self=[super init]) ) {
		self.isTouchEnabled = YES;
		
		CCLabel *label = [CCLabel labelWithString:@"Result Scene" fontName:@"Marker Felt" fontSize:48];
		label.position = ccp(240, 180);
		[self addChild:label];
		
		CCLabel *tapLabel = [CCLabel labelWithString:@"Tap to restart" fontName:@"Marker Felt" fontSize:48];
		tapLabel.position = ccp(240, 120);
		[self addChild:tapLabel];
	}
	
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[[CCDirector sharedDirector] popScene];
}

@end
