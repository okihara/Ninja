//
//  HitEffect.m
//  Locus
//
//  Created by okihara.masataka on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HitEffect.h"


@implementation HitEffect

@synthesize center=_center;

- (id)init
{
	if( (self=[super init]) ) {
		curIndex = 0;
		[self scheduleUpdateWithPriority:-10];
	}
	
	return self;
}

- (void) drawLineWithLength:(float)length width:(float)width
{
	CGPoint loc = CGPointMake(_center.x - length / 2.0f, _center.y);
	for (int i = 0; i < 17; ++i) {
		float w = 0.1 + width * sinf(M_PI * i / 17);
		glLineWidth( w );
		ccDrawLine( ccp(loc.x + length * i / 17, loc.y), ccp(loc.x + length * (i + 1) / 17, loc.y) );
	}
}

-(void) update:(ccTime)deltaTime
{
	if(++curIndex >= 9) {
		[self unscheduleUpdate];
		[self removeFromParentAndCleanup:NO];
	}
}

float anim_tbl[] = {30, 300, 200};

- (void)draw
{
	float length = anim_tbl[curIndex / 3];
	
	glColor4f( 0.7f, 0.0f, 0.0f, 1.0f );
	[self drawLineWithLength:length width:22];
	
	glColor4f( 0.9f, 0.0f, 0.0f, 1.0f );
	[self drawLineWithLength:length width:16];
	
	
	glColor4f( 1.0f, 1.00f, 1.0f, 1.0f );
	[self drawLineWithLength:length width:10];
}

@end
