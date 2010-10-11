//
//  Enemy.h
//  Locus
//
//  Created by okihara.masataka on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCSprite {
	BOOL isDamage;
	uint deadCount;
	int max_hp;
	int hp;
	float tx;
	float vy;
	uint frame;
}

- (void)damage;

@property int max_hp;
@property int hp;


@end
