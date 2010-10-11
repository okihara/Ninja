//
//  EffectLayer.h
//  Locus
//
//  Created by utan on 10/09/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EffectLayer : CCLayer {
	int curIndex;
//	CCParticleSystem *emitter;
}

- (void)makeEffectWithPosition:(CGPoint)position;

@end
