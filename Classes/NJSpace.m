//
//  Space.m
//  Locus
//
//  Created by okihara.masataka on 10/10/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NJSpace.h"


@implementation NJSpace

@synthesize next;
@synthesize prev;
@synthesize another;
@synthesize type;

-(id)init
{
	if ( (self=[super init]) ) {
		next  = nil;
		prev  = nil;
		another = nil;
		type = 0;
	}
	
	return self;
}

@end
