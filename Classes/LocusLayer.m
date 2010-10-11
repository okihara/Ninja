//
//  LocusLayer.m
//  Locus
//
//  Created by utan on 10/09/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LocusLayer.h"


@implementation LocusLayer

- (id)init
{
	if( (self=[super init]) ) {
		self.isTouchEnabled = YES;
		isRunning = NO;
		curIndex = 0;
		//[self scheduleUpdate];
	}
	return self;
}

#define MAX_LOCUS_POINTS 20
CGPoint locus_points[MAX_LOCUS_POINTS];

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	isRunning = NO;
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint p = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];

	if (!isRunning) {
		for (int i =0; i < MAX_LOCUS_POINTS; ++i) {
			locus_points[i] = p;
		}
		curIndex = 0;
	}
	
	//
	isRunning = YES;
	
	//
	locus_points[0] = p;
	if (++curIndex == MAX_LOCUS_POINTS) {
		curIndex = MAX_LOCUS_POINTS - 1;
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//isRunning = NO;
}

- (void) drawLineWithWidth:(float)width
{
	if (curIndex < 1) return;
	
	for (int i = 0; i < curIndex - 1; ++i) {
		CGPoint curr = locus_points[i];
		CGPoint prev = locus_points[i + 1];
		
		// 太さ設定
		float w = width - width * i / (curIndex - 1);
		glLineWidth( w );
		
		// 線を描画
		ccDrawLine( ccp(prev.x, prev.y), ccp(curr.x, curr.y) );
		
		//
		CGPoint points[] = {
			ccp(prev.x, prev.y),
			ccp(curr.x, prev.y),
			ccp(curr.x, curr.y),
			ccp(prev.x, curr.y),
		};
		glLineWidth( 1.0f );
		ccDrawPoly(points, 4, YES);
	}
}

//-(void) update:(ccTime)deltaTime
//{
//	--curIndex;
//	if(curIndex < 0) {
//		curIndex = 0;
//	}
//}

- (void)draw
{
	//
	if(!isRunning) return;
	
	//
	for (int i = MAX_LOCUS_POINTS - 1; i > 0; --i) {
		locus_points[i] = locus_points[i - 1];			
	}
	
	// 色設定
	glColor4f( 0.5f, 0.5f, 0.5f, 1.0f );
	[self drawLineWithWidth:20];


	// 色設定
	glColor4f( 0.7f, 0.7f, 0.7f, 1.0f );
	[self drawLineWithWidth:16];
	
	// 色設定
	glColor4f( 1.0f, 1.0f, 1.0f, 1.0f);
	[self drawLineWithWidth:10];
}

- (BOOL)intersects:(CGRect)rect
{
	if (curIndex < 1) return NO;

	// cocos 的な衝突判定に変える
	for (int i = 0; i < curIndex - 1; ++i) {
		CGPoint curr = locus_points[i];
		CGPoint prev = locus_points[i + 1];
		if(CGPointEqualToPoint(curr, prev)) {
			return NO;
		}
		float width = abs(curr.x - prev.x);
		float height = abs(curr.y - prev.y);
		float x = prev.x >= curr.x ? curr.x : prev.x;
		float y = prev.y >= curr.y ? curr.y : prev.y;
		
		CGRect r2 = CGRectMake(x, y, width, height);
		if( !CGRectIsNull(CGRectIntersection(rect, r2)) ) {
			return YES;
		}
	}
	return NO;
}

@end
