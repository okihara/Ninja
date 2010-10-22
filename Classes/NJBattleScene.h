//
//  HelloWorldLayer.h
//  Locus
//
//  Created by utan on 10/09/26.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@class LocusLayer;
@class EffectLayer;
@class InfoLayer;

#define NUM_ENEMY 3

@interface NJBattleScene : CCLayer
{
	uint state;
	
	LocusLayer *locusLayer;
	EffectLayer *effectLayer;
	InfoLayer *infoLayer;
	
	int player_max_hp;
	int player_hp;
	
	int enemy_max_hp;
	int enemy_hp;
}

+ (id)scene;

@end
