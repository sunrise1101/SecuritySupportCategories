//
//  GeneralMethod.h
//  SecuritySupportCategories
//
//  Created by 邓旭东 on 2018/1/19.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import <objc/runtime.h>

#ifndef GeneralMethod_h
#define GeneralMethod_h

#ifndef NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#endif
#ifndef NS_ASSUME_NONNULL_END
#define NS_ASSUME_NONNULL_END   _Pragma("clang assume_nonnull end")
#endif

#endif /* GeneralMethod_h */

NS_ASSUME_NONNULL_BEGIN

static inline void dxd_swizzleMethods(Class class, SEL originalSelector, SEL swizzledSelector)   {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

NS_ASSUME_NONNULL_END

