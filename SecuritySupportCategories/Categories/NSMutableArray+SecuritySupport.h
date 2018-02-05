//
//  NSMutableArray+SecuritySupport.h
//  SecuritySupportCategories
//
//  Created by 邓旭东 on 2018/1/19.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 NSMutableArray hook后会产生系统键盘会被ARC释放掉从而产生zombie memory,导致闪退的问题
 具体情况: iOS8下 随机激活一个textfield/textview 键盘出现后,按home键使app进入后台,app随即闪退
 解决方案:在工程配置中 设置这个NSArray的SecuritySupport的.m文件使用mrc运行, 配置加上 -fno-objc-arc
 */
@interface NSMutableArray (SecuritySupport)

@end
