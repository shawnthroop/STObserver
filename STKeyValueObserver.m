//
//  STKeyValueObserver.m
//
//  Created by Shawn Throop on 08/05/15.
//  Copyright (c) 2015 Silent H Designs. All rights reserved.
//

#import "STKeyValueObserver.h"

@interface STKeyValueObserver ()

@property (nonatomic, weak) id observedObject;
@property (nonatomic, copy) NSString* keyPath;
@property (nonatomic, weak) id target;

@property (nonatomic, copy) STKVOBlock block;

@end



@implementation STKeyValueObserver

- (instancetype)initWithObject:(id)object keyPath:(NSString *)keyPath target:(id)target options:(NSKeyValueObservingOptions)options block:(STKVOBlock)block
{
    if (object == nil) {
        return nil;
    }
    
    if (self = [super init]) {
        _observedObject = object;
        _keyPath = keyPath;
        _target = target;
        _block = block;
        
        [object addObserver:self forKeyPath:keyPath options:options context:(__bridge void *)(self)];
    }
    
    return self;
}


+ (NSObject *)observeObject:(id)object keyPath:(NSString *)keyPath target:(id)target block:(STKVOBlock)block
{
    return [self observeObject:object keyPath:keyPath target:target options:0 block:block];
}


+ (NSObject *)observeObject:(id)object keyPath:(NSString *)keyPath target:(id)target options:(NSKeyValueObservingOptions)options block:(STKVOBlock)block
{
    return [[self alloc] initWithObject:object keyPath:keyPath target:target options:options block:block];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == (__bridge void *)(self)) {
        self.block(self.target, change);
    }
}

- (void)dealloc
{
    [self.observedObject removeObserver:self forKeyPath:self.keyPath];
}
@end
