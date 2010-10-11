//
//  Shuriken.m
//  Locus
//
//  Created by okihara.masataka on 10/09/29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Shuriken.h"


@implementation Shuriken

- (id)init
{
	if( (self=[super init]) ) {
	}
	
	return self;
}

- (void)go
{
	NSMutableArray *moveAnimFrames = [NSMutableArray array];
	[moveAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"shuriken_0_h.png"]];
	[moveAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"shuriken_120_h.png"]];
	[moveAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"shuriken_240_h.png"]];
	CCAnimation *moveAnim = [CCAnimation animationWithName:@"walk" delay:0.033f frames:moveAnimFrames];
	
	//
	CGPoint targetPoint = CGPointMake(rand() % 480, rand() % 320);
	self.scale = 0.1f;
	[self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:moveAnim restoreOriginalFrame:NO]]];
	id action = [CCSpawn actions:
				 [CCEaseIn actionWithAction:[CCScaleTo actionWithDuration:2.0f scale:8.0f] rate:3.0f],
				 [CCMoveTo actionWithDuration:2.0f position:targetPoint], nil];
	CCAction *callFunc = [CCCallFunc actionWithTarget:self selector:@selector(doATask)];
	[self runAction:[CCSequence actions:action, callFunc, nil]];
}


- (void)doATask
{
	[self.parent.parent performSelector:@selector(onHit)];
	[self removeFromParentAndCleanup:NO];
}

@end
