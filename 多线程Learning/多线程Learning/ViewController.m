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
//    UIButton *btn = [UIButton createButtonWithTitle:@"开始卖票" superView:self.view];
//    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        [self.thread01 start];
//        [self.thread02 start];
//        [self.thread03 start];
//    }];
//    void (^block)(void) = ^{
//        while (1) {
//            // 1.互斥锁(线程同步) - 不推荐用的锁, ()里面放的是锁, NSObject类型就是, 必须是同一个对象, 代表同一把锁
//            // 2.注意, while内部是在卖票, 因此应该将锁加到while内部; 如果将锁加到while外部, 先进去的线程会一直霸占卖票过程, 等卖完才会开放给其他线程进去
//            @synchronized (self) {
//                if (self.ticketsCount > 0) {
//                    self.ticketsCount--;
//                    NSLog(@"%@ - 卖了一张票, 剩余:%ld", [NSThread currentThread].name, _ticketsCount);
//                } else {
//                    NSLog(@"卖光了");
//                    break;
//                }
//            }
//        }
//    };
//    self.ticketsCount = 100;
//    self.thread01 = [[NSThread alloc] initWithBlock:block];
//    self.thread02 = [[NSThread alloc] initWithBlock:block];
//    self.thread03 = [[NSThread alloc] initWithBlock:block];
//    self.thread01.name = @"01";
//    self.thread02.name = @"02";
//    self.thread03.name = @"03";
#pragma mark - 线程间通信(nonatomic, atomic)
    // 1. atomic : 线程安全, 需要消耗大量资源
    // 2. nonatomic : 非线程安全, 存放内存小的移动设备, 大部分使用这个
//    CFTimeInterval begin = CFAbsoluteTimeGetCurrent(); // 获取线程的绝对时间, 用于计算时间差
    // 回到主线程的方法
//    self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>
    // 跟runloop有关，可以让程序不那么卡
//    self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#> modes:<#(nullable NSArray<NSString *> *)#>
    
    // 让某个线程调用某个方法， 最后一个方法是等不等这个方法调用完，也就是租不阻塞当前这个线程
//    self performSelector:<#(nonnull SEL)#> onThread:<#(nonnull NSThread *)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>
#pragma mark - GCD (Grand Central Dispatch) (牛逼的中枢调度器)
    /*
     GCD两个核心概念：
     1.任务：执行什么操作（block）
     2.队列：用来存放任务
     
     GCD的使用就2个步骤
     1.定制任务
     2.将任务加到队列中（自动将队列中的任务取出，放到线程中执行；任务遵循FIFO先进先出原则执行）
     
     GCD在libdispatch里面，默认导入这个库
     */
    
    /*
     同步、异步只决定：具不具备开启线程的能力 ************************************
     1、同步：只能在当前线程中执行任务，不具备开启新线程的能力
     dispatch_sync(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
     2、异步：可以在新的线程中执行任务，具备开启新线程的能力
     dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
     
     并行、串行主要硬性：任务的执行方式 *****************************************
     1、并行队列（Concurrent Dispatch Queue）
     （1）允许多个任务并行（同时）执行；（自动开启多个线程执行任务）
     （2）并发功能只有在异步（dispatch_async）函数下才有效
     2、串行队列（Serial Dispatch Queue）
     （1）让任务一个接着一个执行
     */
    
    // 同步异步 + 并行串行 组合
//    [self gcd_asyncConcurrent];
//    [self gcd_syncSerial];
//    [self gcd_syncMain];
    
#pragma mark - GCD - 线程间通讯
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        // 异步 并发执行任务，开启了一个新线程
        NSLog(@"新线程 - %@", [NSThread currentThread]);
        
        // 回到主线程， async 和 sync都行
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到了主线程 - %@", [NSThread currentThread]);
        });
        
        // async：走完这句再回到主线程；sync：先回到主线程做完事情再走这句
        NSLog(@"走这一步 - %@", [NSThread currentThread]);
    });
    
}
// gcd - 0. 同步 + 主队列：
- (void)gcd_syncMain
{
    // 特殊的串行队列，主队列；主队列里的任务都在 主线程 里执行（不管是同步还是异步）
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"-- begin");
    // 2、将任务添加到队列 - 同步
    // 这里会出现问题，蹦了
#pragma mark - BUG
    /*
     1.同步不会开启线程（并且主队列中的任务都在主线程中进行）
     2.当前线程（主线程）正在执行任务，要执行完才能去执行下一个任务，而当前这个任务又要马上要在当前线程执行，于是当前线程就懵逼了：“你想要我怎样”（当前线程需要马上执行两个任务）。还可以这样理解：大任务执行完才能开启小任务，然而小任务不执行完 大任务没法完成，就堵到这了
     */
    // 用sync函数往当前串行队列中添加任务，会卡住当前串行队列
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"1 --- %@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"2 --- %@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"3 --- %@", [NSThread currentThread]);
        }
    });
    NSLog(@"-- end");
}
// gcd - 1. 异步 + 并发 ：可同时开启多条线程
- (void)gcd_asyncConcurrent
{
    // 1、创建并行队列
    // label：队列标签
    // attr：队列类型，串行还是并行
//    dispatch_queue_t queue = dispatch_queue_create("com.pangshishan.haha", DISPATCH_QUEUE_CONCURRENT);
    
    // 获取全局的并发队列，全局队列就是一个并发队列，第一个参数是优先级
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    // 2、将任务添加到队列 - 异步
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"1 --- %@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"2 --- %@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"3 --- %@", [NSThread currentThread]);
        }
    });
    
}
// gcd - 2. 同步 + 并行；其他情况自行模拟
- (void)gcd_syncSerial
{
    // 1、创建串行队列，DISPATCH_QUEUE_SERIAL == NULL
//    dispatch_queue_t queue = dispatch_queue_create("com.pangshishan.haha", DISPATCH_QUEUE_SERIAL);
    
    // 特殊的串行队列，主队列；主队列里的任务都在 主线程 里执行（不管是同步还是异步）
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    
    // 2、将任务添加到队列 - 异步
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"1 --- %@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"2 --- %@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"3 --- %@", [NSThread currentThread]);
        }
    });
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
