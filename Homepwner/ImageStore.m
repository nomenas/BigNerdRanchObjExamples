//
//  ImageStore.m
//  Homepwner
//
//  Created by Naum Puroski on 11/2/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import "ImageStore.h"

@interface ImageStore ()

@property (strong, nonatomic) NSMutableDictionary* dictionary;

@end

@implementation ImageStore

-(id) initPrivate
{
    id returnValue = [super init];
    
    if (returnValue)
    {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return returnValue;
}

+ (instancetype) sharedStore;
{
    static ImageStore* sharedStore = nil;
    
    if (sharedStore == nil)
    {
        sharedStore = [[ImageStore alloc] initPrivate];
    }
    
    return sharedStore;
}

-(id) init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use sharedStore" userInfo:nil];
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.dictionary setObject:image forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key
{
    return [_dictionary objectForKey:key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if (key)
    {
        [_dictionary removeObjectForKey:key];
    }
}

@end
