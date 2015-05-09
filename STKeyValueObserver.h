//
//  STKeyValueObserver.h
//
//  Created by Shawn Throop on 08/05/15.
//  Copyright (c) 2015 Silent H Designs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^STKVOBlock)(id target, NSDictionary *change);

@interface STKeyValueObserver : NSObject

+ (NSObject *)observeObject:(id)object keyPath:(NSString *)keyPath target:(id)target block:(STKVOBlock)block;
+ (NSObject *)observeObject:(id)object keyPath:(NSString *)keyPath target:(id)target options:(NSKeyValueObservingOptions)options block:(STKVOBlock)block;

@end
