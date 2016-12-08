//
//  ViewController.m
//  多线程Learning
//
//  Created by 庞仕山 on 16/12/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "ViewController.h"

#import "PthreadLearing.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#pragma mark - 1.pthread
//    [PthreadLearing pthreadRun];
    
    
#pragma mark - 2.NSThread
//    [self createNSThread];
    
#pragma mark - 3.线程状态
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"1 - %@", [NSThread currentThread]);
//        [NSThread sleepForTimeInterval:2]; // 阻塞当前线程2秒
//        [NSThread sleepUntilDate:[NSDate distantFuture]]; // 遥远的未来; [NSDate distantPast] -> 遥远的过去
//        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]]; // 睡眠 直到两秒钟之后
//        [NSThread exit]; // 当前线程直接挂掉
        NSLog(@"2 - %@", [NSThread currentThread]);
    }];
    
}


- (void)createNSThread
{
    // 1.
//    NSThread *thread = [[NSThread alloc] initWithBlock:^{
//        for (int i = 0; i < 10000; i++) {
//            NSLog(@" --- %d - %@", i, [NSThread currentThread]);
//        }
//    }];
//    [thread start];
    
    // 2.
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"haha"];
//    thread.name = @"2222";
//    [thread start];
    
    // 3.
//    [NSThread detachNewThreadWithBlock:^{
//        for (int i = 0; i < 10000; i++) {
//            NSLog(@" --- %d - %@", i, [NSThread currentThread]);
//        }
//    }];
    // 4.
//    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"detach"];
    
    // 5.
//    [self performSelectorInBackground:NSSelectorFromString(@"run:") withObject:@"performBG"];
    
}

- (void)run:(NSString *)str
{
    for (int i = 0; i < 10000; i++) {
        NSLog(@" --- %d - %@ - %@", i, [NSThread currentThread], str);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.view.backgroundColor = [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1];
    NSLog(@" ------- %@", [NSThread currentThread]);
}

- (CGFloat)randomValue
{
    return 1.0 * (arc4random() % 265) / 265.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
