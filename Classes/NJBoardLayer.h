//
//  BoardLayer.h
//  Locus
//
//  Created by okhra on 10/10/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define BOARD_WIDTH 960
#define BOARD_HEIGHT 1280

@class NJSpace;

@interface NJBoardLayer : CCLayer {

}

-(NJSpace*)setupSpaces;

@end
