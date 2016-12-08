//
//  ViewController.m
//  多线程Learning
//
//  Created by 庞仕山 on 16/12/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "ViewController.h"
#import "PthreadLearing.h"
#import "UIButton+Create.h"
#import <ReactiveCocoa.h>
@interface ViewController ()
// 模拟买票
@property (nonatomic, strong) NSThread *thread01;
@property (nonatomic, strong) NSThread *thread02;
@property (nonatomic, strong) NSThread *thread03;
@property (nonatomic, assign) NSInteger ticketsCount;
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
//    [NSThread detachNewThreadWithBlock:^{
//        NSLog(@"1 - %@", [NSThread currentThread]);
////        [NSThread sleepForTimeInterval:2]; // 阻塞当前线程2秒
////        [NSThread sleepUntilDate:[NSDate distantFuture]]; // 遥远的未来; [NSDate distantPast] -> 遥远的过去
////        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]]; // 睡眠 直到两秒钟之后
////        [NSThread exit]; // 当前线程直接挂掉
//        NSLog(@"2 - %@", [NSThread currentThread]);
//    }];
    
#pragma mark - 4.线程锁 (模拟买票)
    UIButton *btn = [UIButton createButtonWithTitle:@"开始卖票" superView:self.view];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.thread01 start];
        [self.thread02 start];
        [self.thread03 start];
    }];
    void (^block)(void) = ^{
        // 1.不推荐用的锁, ()里面放的是锁, NSObject类型就是, 必须是同一个对象, 代表同一把锁
        @synchronized (self) {
            while (1) {
                if (self.ticketsCount > 0) {
                    self.ticketsCount--;
                    NSLog(@"%@ - 卖了一张票, 剩余:%ld", [NSThread currentThread].name, _ticketsCount);
                } else {
                    NSLog(@"卖光了");
                    break;
                }
            }
        }
    };
    self.ticketsCount = 100;
    self.thread01 = [[NSThread alloc] initWithBlock:block];
    self.thread02 = [[NSThread alloc] initWithBlock:block];
    self.thread03 = [[NSThread alloc] initWithBlock:block];
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
