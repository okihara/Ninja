//
//  Dice.m
//  Locus
//
//  Created by okihara.masataka on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NJDice.h"

CCAnimation *diceAnim = nil;

@implementation NJDice

@synthesize nextNumber;

-(void)setupAnimation
{
	if (diceAnim) return;
	
	NSMutableArray *moveAnimFrames = [NSMutableArray array];
	[moveAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"010306life021-trans.png"]];
	[moveAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"010306life022-trans.png"]];
	[moveAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"010306life023-trans.png"]];
	[moveAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"010306life024-trans.png"]];
	[moveAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"010306life025-trans.png"]];
	[moveAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"010306life026-trans.png"]];
	diceAnim = [CCAnimation animationWithName:@"roll" delay:0.1f frames:moveAnimFrames];
	[diceAnim retain];
}

-(id) init
{
	if( (self=[super init]) ) {
		nextNumber = 1;
		
		[self setupAnimation];
	}
		
	return self;
}

-(void)ready
{
	self.position = ccp(480 - 40, 40);
	[self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:diceAnim restoreOriginalFrame:NO]]];
}

-(void)roll:(int)number
{
	nextNumber = number;
	CGPoint targetPoint = CGPointMake(60, 200);
	id action = [CCSpawn actions:
				 [CCEaseOut actionWithAction:[CCMoveTo actionWithDuration:1.0f position:targetPoint] rate:3.0f],
				 nil];
	CCAction *callFunc = [CCCallFunc actionWithTarget:self selector:@selector(didFinishedRoll)];
	[self runAction:[CCSequence actions:action, callFunc, nil]];
}

-(void)didFinishedRoll
{
	[[CCActionManager sharedManager] removeAllActionsFromTarget:self];
	CCSpriteFrame *sf = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"010306life02%1d-trans.png", nextNumber]];
	[self setDisplayFrame:sf];
	[self.parent performSelector:@selector(onCastEnd)];
	//[self.delegate didFinishedRoll];
}

@end
