//
//  WinScene.m
//  Locus
//
//  Created by okihara.masataka on 10/09/28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NJBattleResultScene.h"
#import "NJCommon.h"
#import "NJBattleScene.h"

@implementation NJBattleResultScene

+(id)scene
{
	CCScene *scene = [CCScene node];
	[scene addChild:[NJBattleResultScene node]];
	return scene;
}

- (id)init
{
	if( (self=[super init]) ) {
		self.isTouchEnabled = YES;
		
		CCLabel *label = [CCLabel labelWithString:@"Result Scene" fontName:DEFAULT_FONT_NAME fontSize:48];
		label.position = ccp(240, 180);
		[self addChild:label];
		
		CCLabel *tapLabel = [CCLabel labelWithString:@"Tap to restart" fontName:DEFAULT_FONT_NAME fontSize:48];
		tapLabel.position = ccp(240, 120);
		[self addChild:tapLabel];
	}
	
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (YES) {
		[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"OnExitCocosView" object:self]];
		[[CCDirector sharedDirector] replaceScene:[CCScene node]];
	}else {
		[[CCDirector sharedDirector] popScene];
	}
}

@end
