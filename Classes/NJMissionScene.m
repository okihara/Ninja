//
//  Sugoroku.m
//  Locus
//
//  Created by okihara.masataka on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NJMissionScene.h"
#import "NJCommon.h"
#import "LevelUpScene.h"
#import "NJBattleScene.h"
#import "NJBoardLayer.h"
#import "NJPlayer.h"
#import "NJSpace.h"
#import "NJDice.h"


@implementation NJMissionScene

@synthesize currentSpace;

+ (id)scene
{
	CCScene *scene = [CCScene node];
	[scene addChild:[NJMissionScene node]];
	return scene;
}

- (void)updateCamera
{
	float screen_width  = 480.0f;
	float screen_height = 320.0f;
	float x = player.position.x - screen_width  / 2;
	float y = player.position.y - screen_height / 2;
	
	x = x > BOARD_WIDTH  - screen_width  ? BOARD_WIDTH  - screen_width       : x < 0 ? 0 : x;
	y = y > BOARD_HEIGHT - screen_height ? BOARD_HEIGHT - screen_height + 64 : y < 0 ? 0 : y;

	boardLayer.position = ccp(0 - x, 0 - y);
}

-(void)updateInfo
{
	[energy setString:[NSString stringWithFormat:@"Energy %5d", player.energy]];
	[exp setString:[NSString stringWithFormat:@"Exp %10d", player.exp]];	
	[level setString:[NSString stringWithFormat:@"Lv %3d", player.level]];
	[money setString:[NSString stringWithFormat:@"Money %6d", player.money]];
}

- (void) setupInfoLayer {
	float infoHeight = 64;
	
	CCColorLayer *infoLayer = [CCColorLayer layerWithColor:ccc4(ccWHITE.r, ccWHITE.g, ccWHITE.b, 255) width:480 height:infoHeight];		
	[self addChild:infoLayer];
	
	infoLayer.position = ccp(0, 320 - infoHeight);
	CCLabel *name = [CCLabel labelWithString:@"Tokumaru" fontName:DEFAULT_FONT_NAME fontSize:24];
	name.position = ccp(70 + name.contentSize.width / 2, infoHeight - name.contentSize.height / 2);
	name.color = ccBLACK;
	[infoLayer addChild:name];
	
	CCSprite *face = [CCSprite spriteWithFile:@"face_female.png"];
	face.anchorPoint = ccp(0, 0);
	[infoLayer addChild:face];
	
	level = [CCLabel labelWithString:@"Lv.01" fontName:DEFAULT_FONT_NAME fontSize:24];
	level.position = ccp(200 + level.contentSize.width / 2, infoHeight - level.contentSize.height / 2);
	level.color = ccRED;
	[infoLayer addChild:level];
	
	exp = [CCLabel labelWithString:[NSString stringWithFormat:@"Exp %10d", 100] fontName:DEFAULT_FONT_NAME fontSize:24];
	exp.position = ccp(70 + exp.contentSize.width / 2, 5 + exp.contentSize.height / 2);
	exp.color = ccBLUE;
	[infoLayer addChild:exp];
	
	energy = [CCLabel labelWithString:@"Energy" fontName:DEFAULT_FONT_NAME fontSize:24];
	energy.anchorPoint = ccp(0,0);
	energy.position = ccp(290 , infoHeight - energy.contentSize.height);
	energy.color = ccORANGE;
	[infoLayer addChild:energy];
	
	money = [CCLabel labelWithString:@"Money" fontName:DEFAULT_FONT_NAME fontSize:24];
	money.anchorPoint = ccp(0,0);
	money.position = ccp(290, 5);
	money.color = ccORANGE;
	[infoLayer addChild:money];
	
	[self updateInfo];
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
	if ([keyPath isEqualToString:@"position"]) {
		[self updateCamera];
	} else {
		[self updateInfo];
	}
}

-(id) init
{
	if( (self=[super init] )) {
		// init vars
		self.isTouchEnabled = YES;
		restAction = 0;
		isMoving = NO;
		restEventType = -1;
		
		//
		srand(time(NULL));
		
		//
		boardLayer = [NJBoardLayer node];
		[self addChild:boardLayer];
		
		//
		CCSprite *bg = [CCSprite spriteWithFile:@"ninja_bg_ip4.png"];// rect:CGRectMake(0, 0, 1061, 800)];
		bg.anchorPoint = ccp(0, 0);
		bg.scale = 2.0f;
		NSLog(@"bg.contentSize %f %f", bg.contentSize.width, bg.contentSize.height);
		[boardLayer addChild:bg];
		
		//
		currentSpace = [boardLayer setupSpaces];
		
		//
		player = [NJPlayer spriteWithFile:@"player_ss.png"];
		player.energy = 3;
		player.level = 1;
		player.exp = 0;
		[player addObserver:self forKeyPath:@"energy" options:NSKeyValueObservingOptionNew context:nil];
		[player addObserver:self forKeyPath:@"position" options:NSKeyValueObservingOptionNew context:nil];
		[player spawn:self.currentSpace];
		[boardLayer addChild:player];
		
		//
		[self setupInfoLayer];
		
		//
		dice = [NJDice spriteWithSpriteFrameName:@"010306life021-trans.png"];
		[dice ready];
		[self addChild:dice];
		
		CCLabel *back = [CCLabel labelWithString:@"Back" fontName:@"Courier-Bold" fontSize:24];
		back.anchorPoint = ccp(0,0);
		back.position = ccp(420, 230);
		back.color = ccBLACK;
		[self addChild:back];
	}
	
	return self;
}

-(void)move:(uint)times
{
	restAction = times;
	[player move:currentSpace.next];
}

-(BOOL)pushedBackButton:(CGPoint)point
{
	NSLog(@"%s %f %f", __FUNCTION__, point.x, point.y);
	if (point.x < 480 && point.x > 420) {
		if (point.y < 250 && point.y > 230) {
			return YES;
		}
	}
	return NO;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint p = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
	if ([self pushedBackButton:p]) {
		[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"OnExitCocosView" object:self]];
	}
	
	if (isMoving) {
		return;
	}
	
	isMoving = YES;
	
	player.energy -= 1;
	
	int n = 1 + rand() % 5;
	[dice roll:n];
}

-(void)onCastEnd
{
	[self move:dice.nextNumber];
}

- (void) handleSpaceType:(uint)type {
	switch (type) {
	case 5:
		[[CCDirector sharedDirector] pushScene:[CCRotoZoomTransition transitionWithDuration:1.0f scene:[NJBattleScene scene]]];
		break;
	default:
		break;
	}
}

-(void)onEnter
{
	NSLog(@"%s", __FUNCTION__);
	[super onEnter];
	
	if (restEventType >= 0) {
		[self handleSpaceType:restEventType];						
	}
	restEventType = -1;
}

-(void)onMoveEnd
{
	currentSpace = currentSpace.next;	
	--restAction;
	NSLog(@"restAction %d", restAction);
	if (restAction == 0) {
		player.exp += 2;
		player.money += 10;
		if([player levelUp]){
			[[CCDirector sharedDirector] pushScene:[LevelUpScene scene]];
			restEventType = currentSpace.type;
		} else {
			[self handleSpaceType:currentSpace.type];						
		}
		
		if (player.energy == 0) {
			//[dice ready];
			isMoving = YES;
		} else {
			[dice ready];
		}
		isMoving = NO;
	} else {
		[player move:currentSpace.next];
	}
}

@end
