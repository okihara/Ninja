//
//  HelloWorldLayer.m
//  Locus
//
//  Created by utan on 10/09/26.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

// Import the interfaces
#import "NJBattleScene.h"
#import "NJCommon.h"
#import "LocusLayer.h"
#import "EnemyLayer.h"
#import "EffectLayer.h"
#import "InfoLayer.h"
#import "Enemy.h"
#import "Shuriken.h"

#import "NJBattleResultScene.h"

enum BATTILE_SCENE_STATE {
	BATTLE_SCENE_STATE_MAIN,
	BATTLE_SCENE_STATE_WIN,
	BATTLE_SCENE_STATE_LOSE
};

@implementation NJBattleScene

+ (id)scene
{
	CCScene *scene = [CCScene node];
	[scene addChild:[NJBattleScene node]];
	return scene;
}

-(id) init
{
	if( (self=[super init] )) {
		//
		self.isTouchEnabled = NO;
		state = BATTLE_SCENE_STATE_MAIN;
		
		//
		player_hp = player_max_hp = 100;
		enemy_hp = enemy_max_hp = 100 * NUM_ENEMY;
		
		//
		EnemyLayer *enemyLayer = [EnemyLayer node];
		[self addChild:enemyLayer];
		
		//
		Enemy *enemy;
		for (int i = 0; i < NUM_ENEMY; ++i) {
			enemy = [Enemy spriteWithFile:@"white_ninja.png"];
			enemy.max_hp = 100;
			enemy.hp = 100;
			[enemyLayer addChild:enemy];
		}
		
		//
		locusLayer = [LocusLayer node];
		[self addChild:locusLayer];
		
		//
		effectLayer = [EffectLayer node];
		[self addChild:effectLayer];

		//
		infoLayer= [InfoLayer node];
		[self addChild:infoLayer];
	}
	
	return self;
}

- (void)onExit
{
	NSLog(@"%s", __FUNCTION__);
	
	[super onExit];

	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"OnFinishBattle" object:self]];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	switch (state) {
		case BATTLE_SCENE_STATE_WIN:
			[[CCDirector sharedDirector] replaceScene:[NJBattleResultScene node]];
			break;
		case BATTLE_SCENE_STATE_LOSE:
			[[CCDirector sharedDirector] replaceScene:
			 [CCFadeTransition transitionWithDuration:3.0f scene:[NJBattleResultScene node] withColor:ccRED]];
			break;
		default:
			break;
	}
}

- (void)needCollision:(id)enemy
{
	Enemy *e = (Enemy*)enemy;
	//float width = 70.0f;
	float width = e.contentSize.width;
	if( [locusLayer intersects:CGRectMake(e.position.x - width / 2, e.position.y - width / 2, width, width)] ) {
		//
		[effectLayer makeEffectWithPosition:e.position];
		//
		enemy_hp -= 10;
		[infoLayer updateInfo:enemy_hp];
		
		//
		[e damage];
	}
}

- (void)onDead:(id)enemy
{
	if (enemy_hp > 0) return;
	
	// change state
	self.isTouchEnabled = YES;
	state = BATTLE_SCENE_STATE_WIN;
	
	// display youwin
	CCLabel *label = [CCLabel labelWithString:@"YOU WIN!!" fontName:DEFAULT_FONT_NAME fontSize:96];
	label.position = ccp(240, -160);
	[label runAction:[CCEaseOut actionWithAction:[CCMoveTo actionWithDuration:1.0f position:ccp(240, 160)] rate:10.0f]];
	[self addChild:label];
}

- (void)onHit
{
	if (player_hp <= 0) return;
	
	//
	player_hp -= 30;
	if (player_hp < 0) {
		player_hp = 0;
	}
	
	//
	if (player_hp == 0) {
		// change state
		self.isTouchEnabled = YES;
		state = BATTLE_SCENE_STATE_LOSE;
		
		// display youwin
		CCLabel *label = [CCLabel labelWithString:@"YOU LOSE!!" fontName:DEFAULT_FONT_NAME fontSize:96];
		label.position = ccp(240, -160);
		[label runAction:[CCEaseOut actionWithAction:[CCMoveTo actionWithDuration:1.0f position:ccp(240, 160)] rate:10.0f]];
		[self addChild:label];
	}
	
	//
	[infoLayer updatePlayerHP:player_hp];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
