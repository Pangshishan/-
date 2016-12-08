//
//  UIButton+Create.m
//  多线程Learning
//
//  Created by 庞仕山 on 16/12/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "UIButton+Create.h"

@implementation UIButton (Create)

+ (UIButton *)createButtonWithTitle:(NSString *)title superView:(UIView *)superView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [superView addSubview:button];
    button.center = superView.center;
    return button;
}

@end
