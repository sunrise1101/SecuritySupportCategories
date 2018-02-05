//
//  ViewController.m
//  SecuritySupportCategories
//
//  Created by 邓旭东 on 2018/1/19.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO: test  crash
    NSString *nilString = nil;
    
    NSMutableArray *testMArray = [NSMutableArray arrayWithObjects:nilString, @"anObject", nil];
    [testMArray addObject:nilString];
    [testMArray removeObjectAtIndex:4];
    [testMArray replaceObjectAtIndex:5 withObject:@"indexObject"];
    
    NSMutableDictionary *testMDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:nilString, @"testNilString", nil];
    [testMDict setObject:nilString forKey:@"testNilString"];
    
    NSArray *testArray = @[nilString];
    NSLog(@"indexString____%@", testArray[10]);
    NSLog(@"indexString____%@", [testArray objectAtIndex:3]);
    
    NSLog(@"indexString____%@", [testMArray objectAtIndex:10]);
    NSLog(@"indexString____%@", testMArray[3]);
    
    [testMDict removeObjectForKey:nilString];
    
    NSDictionary *testDict = @{@"testNilString" : nilString};
    NSLog(@"testDict____%@", testDict);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
