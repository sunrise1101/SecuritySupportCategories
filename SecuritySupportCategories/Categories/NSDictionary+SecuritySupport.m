//
//  NSDictionary+SecuritySupport.m
//  SecuritySupportCategories
//
//  Created by 邓旭东 on 2018/1/21.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "NSDictionary+SecuritySupport.h"

@implementation NSDictionary (SecuritySupport)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            dxd_swizzleMethods(objc_getClass("__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:), @selector(dxd_initWithObjects:forKeys:count:));
        }
    });
}

/**
 初始化
 */
- (instancetype)dxd_initWithObjects:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count {
    NSUInteger newCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }
        newCount++;
    }
    return [self dxd_initWithObjects:objects forKeys:keys count:newCount];
}

@end
