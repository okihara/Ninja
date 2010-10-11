//
//  InfoLayer.m
//  Locus
//
//  Created by okihara.masataka on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InfoLayer.h"
#import "BattleScene.h"

#define GAGE_WIDTH 400

@implementation InfoLayer

- (id)init
{
	if( (self=[super init]) ) {
		//
		gage1_value = 0;
		gage1_target_value = 100 * NUM_ENEMY;

		gage2_value = 0;
		gage2_target_value = 100;

		//
		CCSprite *leftFace = [CCSprite spriteWithFile:@"face_enemy.png"];
		leftFace.position = ccp(leftFace.contentSize.width / 2, 320 - leftFace.contentSize.height / 2);
		[self addChild:leftFace];
		
		//
		CCSprite *rightFace = [CCSprite spriteWithFile:@"face_female.png"];
		rightFace.position = ccp(480 - rightFace.contentSize.width / 2, rightFace.contentSize.height / 2);
		[self addChild:rightFace];
		
		//
		[self scheduleUpdate];
	}
	return self;
}

-(void) update:(ccTime)deltaTime
{
	//
	float s = (gage1_target_value - gage1_value) / 2.0f;
	if (abs(s) < 0.01f) {
		gage1_value = gage1_target_value;
	} else {
		gage1_value += s;
	}
	gage1_display = GAGE_WIDTH * gage1_value / NUM_ENEMY / 100;
	
	//
	gage2_value = gage2_target_value;
	gage2_display = GAGE_WIDTH * gage2_value / 100;
}

- (void)drawHPBar
{
	//
	glColor4f( 1.0f, 0.0f, 0.0f, 1.0f );
	glLineWidth( 10 );
	ccDrawLine( ccp(70, 300), ccp(70 + GAGE_WIDTH, 300) );

	glColor4f( 1.0f, 1.0f, 0.0f, 1.0f );
	glLineWidth( 10 );
	ccDrawLine( ccp(70, 300), ccp(70 + gage1_display, 300) );
	
	//
	glColor4f( 1.0f, 0.0f, 0.0f, 1.0f );
	glLineWidth( 10.0f );
	ccDrawLine( ccp(10, 20), ccp(10 + GAGE_WIDTH, 20) );

	//
	glColor4f( 1.0f, 1.0f, 0.0f, 1.0f );
	glLineWidth( 10.0f );
	ccDrawLine( ccp(10, 20), ccp(10 + gage2_display, 20) );
}

- (void)draw
{
	[self drawHPBar];
}

- (void)updateInfo:(int)value
{
	gage1_target_value = value;
}

- (void)updatePlayerHP:(int)value
{
	gage2_target_value = value;
}

@end
