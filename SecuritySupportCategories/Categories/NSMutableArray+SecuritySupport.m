//
//  NSMutableArray+SecuritySupport.m
//  SecuritySupportCategories
//
//  Created by 邓旭东 on 2018/1/19.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "NSMutableArray+SecuritySupport.h"

@implementation NSMutableArray (SecuritySupport)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            dxd_swizzleMethods(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:), @selector(dxd_insertObject:atIndex:));
            dxd_swizzleMethods(objc_getClass("__NSArrayM"), @selector(removeObjectsInRange:), @selector(dxd_removeObjectAtIndex:));
            dxd_swizzleMethods(objc_getClass("__NSArrayM"), @selector(replaceObjectAtIndex:withObject:), @selector(dxd_replaceObjectAtIndex:withObject:));
            dxd_swizzleMethods(objc_getClass("__NSArrayM"), @selector(objectAtIndex:), @selector(dxd_mutableObjectIndex:));
            dxd_swizzleMethods(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:), @selector(dxd_mutableObjectAtIndexedSubscript:));
        }
    });
}


/**
 添加nil
 */
- (void)dxd_insertObject:(id)object atIndex:(NSUInteger)index {
    if (object == nil) {
        @try {
            [self dxd_insertObject:object atIndex:index];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSMutableString *strCrash = [NSMutableString string];
            for (NSString *str in [exception callStackSymbols]) {
                [strCrash appendString:str];
                [strCrash appendString:@"\n"];
            }
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", strCrash);
#endif
        }
        @finally {}
    }else {
        [self dxd_insertObject:object atIndex:index];
    }
}
/**
 移除时下标越界
 */
- (void)dxd_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count || !self.count) {
        @try {
            [self dxd_removeObjectAtIndex:index];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSLog(@"exception: %@", exception.reason);
#endif
            return;
        }
        @finally {}
    }
    else {
        return [self dxd_removeObjectAtIndex:index];
    }
}
/**
 替换时下标越界
 */
- (void)dxd_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (index >= self.count || !self.count || !object) {
        @try {
            [self dxd_replaceObjectAtIndex:index withObject:object];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSLog(@"exception: %@", exception.reason);
#endif
            return;
        }
        @finally {}
    }
    else {
        return [self dxd_replaceObjectAtIndex:index withObject:object];
    }
}

/**
 含有一个以上元素越界保护（objectAtIndex）
 */
- (id)dxd_mutableObjectIndex:(NSInteger)index{
    if (index >= self.count || !self.count) {
        @try {
            [self dxd_mutableObjectIndex:index];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSLog(@"exception: %@", exception.reason);
#endif
            return nil;
        }
        @finally {}
    }
    else {
        return [self dxd_mutableObjectIndex:index];
    }
}
/**
 含有一个以上元素越界保护（字面量）
 */
- (id)dxd_mutableObjectAtIndexedSubscript:(NSInteger)index{
    if (index >= self.count || !self.count) {
        @try {
            [self dxd_mutableObjectAtIndexedSubscript:index];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSLog(@"exception: %@", exception.reason);
#endif
            return nil;
        }
        @finally {}
    }
    else {
        return [self dxd_mutableObjectAtIndexedSubscript:index];
    }
}

@end
