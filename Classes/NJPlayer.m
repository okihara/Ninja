//
//  Player.m
//  Locus
//
//  Created by okihara.masataka on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NJPlayer.h"
#import "NJSpace.h"

int level_exp_table[]    = {6, 12, 20, 32, 42, 52, 68, 72, 90};
int level_energy_table[] = {5, 6, 7, 8, 9, 10, 11, 12, 13};

@implementation NJPlayer

@synthesize currentSpace;
@synthesize energy;
@synthesize exp;
@synthesize level;
@synthesize money;

-(void)spawn:(NJSpace*)targetSpace
{
	self.position = ccp(targetSpace.position.x, targetSpace.position.y + 30);
}

-(void)move:(NJSpace*)targetSpace
{
	id moveAction = [CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.5f position:ccp(targetSpace.position.x, targetSpace.position.y + 30)] rate:2.0f];
	CCAction *callFunc = [CCCallFunc actionWithTarget:self.parent.parent selector:@selector(onMoveEnd)];	
	[self runAction:[CCSequence actions:moveAction, callFunc, nil]];
	currentSpace = targetSpace;
}

-(BOOL)levelUp
{
	if (exp >= level_exp_table[self.level - 1]) {
		self.level++;
		self.energy = level_energy_table[self.level - 2];
		return YES;
	} else {
		return NO;
	}
}

@end