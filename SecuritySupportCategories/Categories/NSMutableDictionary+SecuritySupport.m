//
//  NSMutableDictionary+SecuritySupport.m
//  SecuritySupportCategories
//
//  Created by 邓旭东 on 2018/1/19.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "NSMutableDictionary+SecuritySupport.h"

@implementation NSMutableDictionary (SecuritySupport)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            dxd_swizzleMethods(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:), @selector(dxd_setObject:forKey:));
            dxd_swizzleMethods(objc_getClass("__NSDictionaryM"), @selector(removeObjectForKey:), @selector(dxd_removeObjectForKey:));
        }
    });
}

/**
 添加value值为nil
 */
- (void)dxd_setObject:(id)value forKey:(id <NSCopying>)key {
    if (!value || !key) {
        @try {
            [self dxd_setObject:value forKey:key];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSMutableString *strCrash = [NSMutableString string];
            for (NSString *str in [exception callStackSymbols]) {
                [strCrash appendString:str];
                [strCrash appendString:@"\n"];
            }
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            NSLog(@"%@", strCrash);
#endif
        }
        @finally {}
    }else {
        [self dxd_setObject:value forKey:key];
    }
}

- (void)dxd_removeObjectForKey:(id)key {
    if (!key) {
        @try {
            [self dxd_removeObjectForKey:key];
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
        return [self dxd_removeObjectForKey:key];
    }
}

@end
