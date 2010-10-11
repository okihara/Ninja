//
//  InfoLayer.h
//  Locus
//
//  Created by okihara.masataka on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface InfoLayer : CCLayer {
	float gage1_value;
	float gage1_target_value;
	float gage1_display;
	
	float gage2_value;
	float gage2_target_value;
	float gage2_display;
}

- (void)updateInfo:(int)value;
- (void)updatePlayerHP:(int)value;

@end
