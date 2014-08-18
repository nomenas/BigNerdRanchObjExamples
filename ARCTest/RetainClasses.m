//
//  RetainClasses.m
//  ARCTest
//
//  Created by Naum Puroski on 8/18/14.
//  Copyright (c) 2014 Naum Puroski. All rights reserved.
//

#import "RetainClasses.h"

static int countA = 0;
static int countB = 0;
static int countBWeak = 0;
static int countBAssign = 0;

@implementation RetainClassA
{
    RetainClassB* objB;
}

@synthesize objB;

-(id) init
{
    self = [super init];
    ++countA;
    return self;
}

-(void) dealloc
{
    --countA;
}

+(int) instancesCount
{
    return countA;
}

@end


@implementation RetainClassB
{
    RetainClassA* objA;
}

@synthesize objA;

-(id) init
{
    self = [super init];
    ++countB;
    return self;
}

-(void) dealloc
{
    --countB;
}

+(int) instancesCount
{
    return countB;
}

@end

@implementation RetainClassBWeak
{
    __weak RetainClassA* objAWeak;
}

@synthesize objAWeak;

-(id) init
{
    self = [super init];
    ++countBWeak;
    return self;
}

-(void) dealloc
{
    --countBWeak;
}

+(int) instancesCount
{
    return countBWeak;
}

@end

@implementation RetainClassBAssign
{
    __unsafe_unretained RetainClassA* objAAssign;
}

@synthesize objAAssign;

-(id) init
{
    self = [super init];
    ++countBAssign;
    return self;
}

-(void) dealloc
{
    --countBAssign;
}

+(int) instancesCount
{
    return countBAssign;
}

@end