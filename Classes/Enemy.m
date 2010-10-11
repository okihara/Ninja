//
//  Enemy.m
//  Locus
//
//  Created by okihara.masataka on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "Shuriken.h"
#import "BattleScene.h"

@implementation Enemy

@synthesize max_hp;
@synthesize hp;

float gy = 0.27f;

- (id)init
{
	if( (self=[super init]) ) {
		isDamage = NO;
		deadCount = 0;
		tx = 240.0f;
		vy = 6.0f;
		frame = rand() % 10000;
		self.position = ccp(rand() % 240, rand() % 200);
		self.scale = 0.7f;
		[self scheduleUpdateWithPriority:-10];
	}
	return self;
}

-(void) update:(ccTime)deltaTime
{
	if (isDamage) {
		++deadCount;
		if (deadCount < 7) {
			return;
		} else {
			isDamage = NO;
			deadCount = 0;
		}
	}

	float x = self.position.x;
	float y = self.position.y;
	
	y += vy;
	vy -= gy;
	
	x += (tx - x) / 10.0f;
	
	if (y < 100) {
		y = 100;
		vy = 4 + rand() % 6;
	}
	
	if (frame % 270 == 0) {
		tx = 60.0f;
	} else if (frame % 160 == 0) {
		tx = 420.0f;
	} else if (frame % 90 == 0) {
		tx = 240.0f;
	} else if (frame % 790 == 0) {
		Shuriken *shuriken = [Shuriken spriteWithSpriteFrameName:@"shuriken_0_h.png"];
		shuriken.position = self.position;
		[shuriken go];
		[self.parent addChild:shuriken];
	}
	
	++frame;
	
	self.position = ccp(x, y);

	// locus layer に衝突判定求める
	[self.parent.parent performSelector:@selector(needCollision:) withObject:self];
}

- (void)damage
{
	isDamage = YES;
	
	hp -= 10;
	if (hp > 0) return;

	// win
	hp = 0;
	
	CCParticleExplosion *emitter = [CCParticleExplosion node];
	emitter.position = self.position;
	emitter.speed = 220;
	emitter.life = 0.7f;
	emitter.lifeVar = 0;
	emitter.autoRemoveOnFinish = YES;
	[self.parent addChild: emitter z:10];
	
	[self.parent.parent performSelector:@selector(onDead:) withObject:self];

	[self removeFromParentAndCleanup:NO];
}

@end
