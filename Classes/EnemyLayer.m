//
//  EnemyLayer.m
//  Locus
//
//  Created by utan on 10/09/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EnemyLayer.h"
#import "Enemy.h"

@implementation EnemyLayer

- (id)init
{
	if( (self=[super init]) ) {
		CCSprite *bg = [CCSprite spriteWithFile:@"ninja_battle_bg_half.png"];
		bg.position = ccp(240, 160);
		[self addChild:bg];
	}
	
	return self;
}

@end
