//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Naum Puroski on 9/29/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic, strong) NSMutableArray* privateItems;

@end

@implementation BNRItemStore

- (instancetype) init {
    @throw [NSException exceptionWithName: @"Singleton" reason: @"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}
- (instancetype) initPrivate {
    self = [super init];
    
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (instancetype) sharedStore {	
    static BNRItemStore* pBNRItemStore = nil;
    
    if (!pBNRItemStore) {
        pBNRItemStore = [[BNRItemStore alloc] initPrivate];
    }
    
    return pBNRItemStore;
}

-(BNRItem*) createItem {
    BNRItem* item = [BNRItem randomItem];
    [_privateItems addObject:item];
    return item;
}

-(NSArray*) allItems {
    return [_privateItems copy];
}

-(BNRItem*) itemAt:(NSInteger) index {
    return (index >= 0 && index < _privateItems.count) ? [_privateItems objectAtIndex: index] : nil;
}

@end
