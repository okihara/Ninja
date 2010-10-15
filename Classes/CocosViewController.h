//
//  CocosViewController.h
//  Ninja
//
//  Created by okihara.masataka on 10/10/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CocosViewController : UIViewController {
	id delegate;
}

- (void)runSceneBattle;
- (void)runSceneMission;

@property (assign) id delegate;

@end
