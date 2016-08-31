//
//  CustomLabel.m
//  Have a chat
//
//  Created by 黄兵 on 16/8/8.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:17];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void)setScale:(CGFloat)scale
{
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    CGFloat transform = 1 + scale*0.5;
    self.transform = CGAffineTransformMakeScale(transform, transform);
}

@end
