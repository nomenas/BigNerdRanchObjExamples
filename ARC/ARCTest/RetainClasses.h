//
//  RetainClasses.h
//  ARCTest
//
//  Created by Naum Puroski on 8/18/14.
//  Copyright (c) 2014 Naum Puroski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RetainClassA;
@class RetainClassB;

@interface RetainClassA : NSObject

@property RetainClassB* objB;

-(id) init;
-(void) dealloc;

+(int) instancesCount;

@end


@interface RetainClassB : NSObject

@property RetainClassA* objA;

-(id) init;
-(void) dealloc;

+(int) instancesCount;

@end

@interface RetainClassBWeak : RetainClassB

@property (weak) RetainClassA* objAWeak;

-(id) init;
-(void) dealloc;

+(int) instancesCount;

@end

@interface RetainClassBAssign : RetainClassB 

@property (assign) RetainClassA* objAAssign;

-(id) init;
-(void) dealloc;

+(int) instancesCount;

@end