//
//  Space.h
//  Locus
//
//  Created by okihara.masataka on 10/10/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface NJSpace : CCSprite {
	NJSpace *next;
	NJSpace *prev;	
	NJSpace *another;
	
	uint type;
}

@property (assign) NJSpace *next;
@property (assign) NJSpace *prev;
@property (assign) NJSpace *another;
@property (assign) uint type;

@end
