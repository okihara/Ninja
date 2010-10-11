//
//  EffectLayer.m
//  Locus
//
//  Created by utan on 10/09/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EffectLayer.h"
#import "HitEffect.h"


//
// ParticleExplosion
//
//! An explosion particle system
@interface CCParticleHit : CCQuadParticleSystem
{
}
@end

@implementation CCParticleHit

-(id) init
{
	return [self initWithTotalParticles:200];
}

-(id) initWithTotalParticles:(int)p
{
	if( (self=[super initWithTotalParticles:p]) ) {
		
		// duration
		duration = 0.1f;
		
		self.emitterMode = kCCParticleModeGravity;
		
		// Gravity Mode: gravity
		self.gravity = ccp(0,0);
		
		// Gravity Mode: speed of particles
		self.speed = 70 * 3;
		self.speedVar = 40;
		
		// Gravity Mode: radial
		self.radialAccel = 0;
		self.radialAccelVar = 0;
		
		// Gravity Mode: tagential
		self.tangentialAccel = 0;
		self.tangentialAccelVar = 0;
		
		// angle
		angle = 90;
		angleVar = 360;
		
		// emitter position
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		self.position = ccp(winSize.width/2, winSize.height/2);
		posVar = CGPointZero;
		
		// life of particles
		life = 0.4f;
		lifeVar = 0.1f;
		
		// size, in pixels
		startSize = 2.0f;
		startSizeVar = 2.0f;
		endSize = kCCParticleStartSizeEqualToEndSize;
		
		// emits per second
		emissionRate = totalParticles/duration;
		
		// color of particles
		startColor.r = 1.0f;
		startColor.g = 0.9f;
		startColor.b = 0.0f;
		startColor.a = 1.0f;
		startColorVar.r = 0.0f;
		startColorVar.g = 0.0f;
		startColorVar.b = 0.0f;
		startColorVar.a = 0.0f;
		endColor.r = 1.0f;
		endColor.g = 0.9f;
		endColor.b = 0.0f;
		endColor.a = 1.0f;
		endColorVar.r = 0.0f;
		endColorVar.g = 0.0f;
		endColorVar.b = 0.0f;
		endColorVar.a = 0.0f;
		
		//self.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
		
		// additive
		self.blendAdditive = NO;
	}
	
	return self;
}
@end


//
// EffectLayer
//
@implementation EffectLayer

- (id)init
{
	if( (self=[super init]) ) {
	}
	
	return self;
}

- (void)makeEffectWithPosition:(CGPoint)position
{
	HitEffect *e = [HitEffect node];
	e.center = position;
	[self addChild:e];
	
	CCParticleSystem *emitter = [CCParticleHit node];
	emitter.position = position;
	emitter.autoRemoveOnFinish = YES;
	[self addChild: emitter z:10];
}

@end
