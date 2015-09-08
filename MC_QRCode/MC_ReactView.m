//
//  MC_ReactView.m
//  MC_QRCode
//
//  Created by xulu on 15/8/19.
//  Copyright (c) 2015年 _MC. All rights reserved.
//

#import "MC_ReactView.h"

@implementation MC_ReactView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
-(void)drawRect:(CGRect)rect {
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.7);
    CGContextFillRect(context, rect);
    CGContextFillPath(context);
    CGContextSetRGBFillColor(context, 1, 1, 1, 0);
    CGContextClearRect(context, CGRectMake(0.2*[UIScreen mainScreen].bounds.size.width, 0.3*[UIScreen mainScreen].bounds.size.height, 0.6*[UIScreen mainScreen].bounds.size.width, 0.4*[UIScreen mainScreen].bounds.size.height));
    CGContextSetRGBStrokeColor(context, 0, 0.8, 0, 1);
    CGContextSetLineWidth(context, 0.5);
    CGContextAddRect(context, CGRectMake(0.2*[UIScreen mainScreen].bounds.size.width, 0.3*[UIScreen mainScreen].bounds.size.height, 0.6*[UIScreen mainScreen].bounds.size.width, 0.4*[UIScreen mainScreen].bounds.size.height));
    CGContextStrokePath(context);
    
}


@end
