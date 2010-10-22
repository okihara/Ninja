//
//  LevelUpScene.m
//  Locus
//
//  Created by okihara.masataka on 10/10/05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LevelUpScene.h"
#import "NJCommon.h"

@implementation LevelUpScene

+ (id)scene
{
	CCScene *scene = [CCScene node];
	[scene addChild:[LevelUpScene node]];
	return scene;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[[CCDirector sharedDirector] popScene];
}

-(id) init
{
	if( (self=[super init] )) {
		self.isTouchEnabled = YES;
		
		CCLabel *levelupLabel = [CCLabel labelWithString:@"LEVEL UP!!" fontName:DEFAULT_FONT_NAME fontSize:48];
		levelupLabel.position = ccp(240, 160);
		[self addChild:levelupLabel];
	}
	
	return self;
}


@end
