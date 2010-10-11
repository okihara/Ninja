//
//  LocusLayer.h
//  Locus
//
//  Created by utan on 10/09/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LocusLayer : CCLayer {
	BOOL isRunning;
	uint curIndex;
}

- (BOOL)intersects:(CGRect)rect;

@end
