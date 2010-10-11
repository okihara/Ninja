//
//  HitEffect.h
//  Locus
//
//  Created by okihara.masataka on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HitEffect : CCNode {
	CGPoint _center;
	int curIndex;
}

@property (nonatomic) CGPoint center;

@end
