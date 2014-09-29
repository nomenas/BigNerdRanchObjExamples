//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Naum Puroski on 9/29/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray* allItems;

+ (instancetype) sharedStore;

-(BNRItem*) createItem;
-(BNRItem*) itemAt:(NSInteger) index;

@end
