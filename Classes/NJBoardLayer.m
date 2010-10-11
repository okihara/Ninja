//
//  BoardLayer.m
//  Locus
//
//  Created by okhra on 10/10/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NJBoardLayer.h"
#import "NJSpace.h"

#define MASU_SIZE 100
#define PADDING 30
#define PADDING_HEIGHT 30
#define BOARD_WIDTH_OFFSET BOARD_WIDTH - 110
#define BOARD_HEIGHT_OFFSET MASU_SIZE / 2 + 20

//int n[] = {3,3};
CGPoint space_list[] = {
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 0 - PADDING * 0, BOARD_HEIGHT_OFFSET + PADDING * 0 + MASU_SIZE * 0},	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 1 - PADDING * 1, BOARD_HEIGHT_OFFSET + PADDING * 0 + MASU_SIZE * 0},	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 2 - PADDING * 2, BOARD_HEIGHT_OFFSET + PADDING * 0 + MASU_SIZE * 0},
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 3 - PADDING * 3, BOARD_HEIGHT_OFFSET + PADDING * 0 + MASU_SIZE * 0},	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 4 - PADDING * 4, BOARD_HEIGHT_OFFSET + PADDING * 0 + MASU_SIZE * 0},	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 4 - PADDING * 4, BOARD_HEIGHT_OFFSET + PADDING * 1 + MASU_SIZE * 1},	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 4 - PADDING * 4, BOARD_HEIGHT_OFFSET + PADDING * 2 + MASU_SIZE * 2},	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 3 - PADDING * 3, BOARD_HEIGHT_OFFSET + PADDING * 2 + MASU_SIZE * 2},	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 2 - PADDING * 2, BOARD_HEIGHT_OFFSET + PADDING * 2 + MASU_SIZE * 2},	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 1 - PADDING * 1, BOARD_HEIGHT_OFFSET + PADDING * 2 + MASU_SIZE * 2},	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 0 - PADDING * 0, BOARD_HEIGHT_OFFSET + PADDING * 2 + MASU_SIZE * 2},		
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 0 - PADDING * 0, BOARD_HEIGHT_OFFSET + PADDING * 1 + MASU_SIZE * 1},		
	
	{BOARD_WIDTH_OFFSET - PADDING - MASU_SIZE * 2 - PADDING * 2, BOARD_HEIGHT_OFFSET + PADDING * 3 + MASU_SIZE * 3},		
};
int type_list[13] = {0,0,1,0,0,5,0,0,5,0,0,5};
//int type_list[13] = {5,5,5,5,5,5,5,5,5,5,5,5,5};

@implementation NJBoardLayer

-(NJSpace*)setupSpaces
{
	NJSpace *start;
	NJSpace *prev = nil;
	for (int i = 0; i < sizeof(space_list) / sizeof(CGPoint) - 1; ++i) {
		NJSpace *space = nil;
		switch (type_list[i]) {
			case 0:
				space = [NJSpace spriteWithFile:@"space_g.png"];
				break;
			case 1:
				space = [NJSpace spriteWithFile:@"space_b.png"];
				break;
			case 5:
				space = [NJSpace spriteWithFile:@"space_r.png"];
				break;
			default:
				break;
		}
		if (space) {
			space.position = space_list[i];
			space.type = type_list[i];
			[self addChild:space];
		}
		
		if (prev) {
			space.prev = prev;
			prev.next = space;
		}
		
		prev = space;
		if (i == 0) {
			start = space;
		} else if (i == 11) {
			space.next = start;
		}
	}
		
	// boss
	NJSpace *space = [NJSpace spriteWithFile:@"space_r.png"];
	space.position = space_list[12];
	space.type = 5;
	[self addChild:space];
	
	return start;
}

-(id) init
{
	if( (self=[super init] )) {
		self.isTouchEnabled = YES;
	}
	
	return self;
}

@end
