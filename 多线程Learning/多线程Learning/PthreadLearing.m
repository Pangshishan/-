//
//  PthreadLearing.m
//  多线程Learning
//
//  Created by 庞仕山 on 16/12/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PthreadLearing.h"
#import <pthread.h>

@implementation PthreadLearing

void *run(void *param) {
    
    NSLog(@"pthread -- %@", [NSThread currentThread]);
    return NULL;
}

+ (void)pthreadRun
{
    pthread_t pthread;
    pthread_create(&pthread, NULL, run, NULL);
}

@end
