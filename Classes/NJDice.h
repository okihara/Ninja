//
//  Dice.h
//  Locus
//
//  Created by okihara.masataka on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface NJDice : CCSprite {
	int nextNumber;
}

-(void)ready;
-(void)roll:(int)number;

@property (assign) int nextNumber;

@end
