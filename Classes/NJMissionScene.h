//
//  Sugoroku.h
//  Locus
//
//  Created by okihara.masataka on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class NJBoardLayer;
@class NJSpace;
@class NJPlayer;
@class NJDice;

@interface NJMissionScene : CCLayer {
	//
	CGPoint cameraPosition;
	
	BOOL isMoving;
	int restAction;
	int restEventType;
	
	//model
	NJPlayer *player;
	NJDice *dice;

	// view
	NJBoardLayer *boardLayer;
	NJSpace *currentSpace;

	// view for info layer
	CCLabel *energy;
	CCLabel *exp;
	CCLabel *level;
	CCLabel *money;
}

@property (assign) NJSpace *currentSpace;

+ (id)scene;

@end
