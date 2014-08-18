//
//  TestClass.m
//  ARCTest
//
//  Created by Naum Puroski on 8/18/14.
//  Copyright (c) 2014 Naum Puroski. All rights reserved.
//

#import "TestClass.h"

static int instanceCounter = 0;

@implementation TestClass

-(id) init
{
    instanceCounter++;
    return self;
}

-(void) dealloc
{
    instanceCounter--;
}

+(int) numOfIstances
{
    return instanceCounter;
}

@end
