//
//  ARCTestTests.m
//  ARCTestTests
//
//  Created by Naum Puroski on 7/17/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestClass.h"
#import "RetainClasses.h"

@interface ARCTestTests : XCTestCase

@end

@implementation ARCTestTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testObjectCreatedInScope
{
    {
        TestClass* newObject = [[TestClass alloc] init];
        XCTAssert(newObject != nil, @"object initilized");
        XCTAssertEqual(1, [TestClass numOfIstances]);
    }
    XCTAssertEqual(0, [TestClass numOfIstances]);
}

-(void) testAssignNewValue
{
    {
        TestClass* obj1 = [[TestClass alloc] init];
        XCTAssertEqual(1, [TestClass numOfIstances]);
        obj1 = [[TestClass alloc] init];
        XCTAssertEqual(1, [TestClass numOfIstances]);
        TestClass* obj2 = obj1;
        XCTAssertEqual(1, [TestClass numOfIstances]);
    }
}

-(void) testRetainCycle
{
    {
        RetainClassA* objA = [[RetainClassA alloc] init];
        RetainClassB* objB = [[RetainClassB alloc] init];
        
        objA.objB = objB;
        objB.objA = objA;
        
        XCTAssertEqual(1, [RetainClassA instancesCount]);
        XCTAssertEqual(1, [RetainClassB instancesCount]);
    }
    
    XCTAssertEqual(1, [RetainClassA instancesCount]);
    XCTAssertEqual(1, [RetainClassB instancesCount]);
}

-(void) testRetainCycleWithWeak
{
    {
        RetainClassA* objA = [[RetainClassA alloc] init];
        RetainClassBWeak* objB = [[RetainClassBWeak alloc] init];
        
        objA.objB = objB;
        objB.objAWeak = objA;
        
        XCTAssertEqual(2, [RetainClassA instancesCount]);
        XCTAssertEqual(1, [RetainClassBWeak instancesCount]);
    }
    
    XCTAssertEqual(1, [RetainClassA instancesCount]);
    XCTAssertEqual(0, [RetainClassBWeak instancesCount]);
}

-(void) testRetainCycleWithAssign
{
    {
        RetainClassA* objA = [[RetainClassA alloc] init];
        RetainClassBAssign* objB = [[RetainClassBAssign alloc] init];
        
        objA.objB = objB;
        objB.objAAssign = objA;
        
        XCTAssertEqual(2, [RetainClassA instancesCount]);
        XCTAssertEqual(1, [RetainClassBAssign instancesCount]);
    }
    
    XCTAssertEqual(1, [RetainClassA instancesCount]);
    XCTAssertEqual(0, [RetainClassBAssign instancesCount]);
}

-(void) testValidatyOfWeakAfterRelease
{
    RetainClassBWeak* objB = [[RetainClassBWeak alloc] init];
    
    {
        RetainClassA* objA = [[RetainClassA alloc] init];
        objB.objAWeak = objA;
        objA.objB = objB;
        
        XCTAssertEqual(2, [RetainClassA instancesCount]);
        XCTAssertEqual(1, [RetainClassBWeak instancesCount]);
    }
    
    XCTAssertEqual(1, [RetainClassA instancesCount]);
    XCTAssertEqual(1, [RetainClassBWeak instancesCount]);
    
    XCTAssert(nil == objB.objAWeak, @"check dangling pointer");
}

@end
