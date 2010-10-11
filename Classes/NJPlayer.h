//
//  Player.h
//  Locus
//
//  Created by okihara.masataka on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NJSpace.h"

@interface NJPlayer : CCSprite {
	//
	NJSpace *currentSpace;
	
	//
	int energy;
	int atk;
	int def;
	int money;
	int level;
	int name;
	int exp;
}

@property (assign) NJSpace *currentSpace;
@property (assign) int energy;
@property (assign) int exp;
@property (assign) int level;
@property (assign) int money;

-(void)spawn:(NJSpace*)targetSpace;
-(void)move:(NJSpace*)targetSpace;
-(BOOL)levelUp;

@end
