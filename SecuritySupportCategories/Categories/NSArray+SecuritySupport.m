//
//  NSArray+SecuritySupport.m
//  SecuritySupportCategories
//
//  Created by 邓旭东 on 2018/1/19.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "NSArray+SecuritySupport.h"

@implementation NSArray (SecuritySupport)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            dxd_swizzleMethods(objc_getClass("__NSArray0"), @selector(objectAtIndex:), @selector(dxd_emptyObjectIndex:));
            dxd_swizzleMethods(objc_getClass("__NSArrayI"), @selector(objectAtIndex:), @selector(dxd_arrObjectIndex:));
            dxd_swizzleMethods(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:), @selector(dxd_arrObjectAtIndexedSubscript:));
            dxd_swizzleMethods(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(dxd_arrSingleObjectIndex:));
            dxd_swizzleMethods(objc_getClass("__NSPlaceholderArray"), @selector(initWithObjects:count:), @selector(dxd_initWithObjects:count:));
            
        }
    });
}
/**
 空数组越界保护
 */
- (id)dxd_emptyObjectIndex:(NSInteger)index{
    return nil;
}
/**
 含有一个以上元素越界保护（objectAtIndex）
 */
- (id)dxd_arrObjectIndex:(NSInteger)index{
    if (index >= self.count || !self.count) {
        @try {
            [self dxd_arrObjectIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        @finally {}
    }
    else {
        return [self dxd_arrObjectIndex:index];
    }
}
/**
 含有一个以上元素越界保护（字面量）
 */
- (id)dxd_arrObjectAtIndexedSubscript:(NSInteger)index{
    if (index >= self.count || !self.count) {
        @try {
            [self dxd_arrObjectAtIndexedSubscript:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        @finally {}
    }
    else {
        return [self dxd_arrObjectAtIndexedSubscript:index];
    }
}
/**
 只含有一个元素
 */
- (id)dxd_arrSingleObjectIndex:(NSInteger)index{
    if (index >= self.count || !self.count) {
        @try {
            [self dxd_arrSingleObjectIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        @finally {}
    }
    else {
        return [self dxd_arrSingleObjectIndex:index];
    }
}
/**
 初始化
 */
- (instancetype)dxd_initWithObjects:(id *)objects count:(NSUInteger)count {
    NSUInteger newCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (!objects[i]) {
            break;
        }
        newCount++;
    }
    return [self dxd_initWithObjects:objects count:newCount];
}
@end
