//
//  UILabel+SizeAdaption.h
//  ceshi
//
//  Created by US Corp on 14/11/21.
//  Copyright (c) 2014年 uscorp. All rights reserved.
//

/*
 
 描述:该类是一个UILabel的一个分类,提供了两种方法,
 1.UILabel的长度定死了,高度根据text的内容自动调整   UILabel
 2.UILabel的高度给定了,长度根据text的内容自动调整
 */

#import <UIKit/UIKit.h>

@interface UILabel (SizeAdaption)
//宽度自适应方法,就是定义好label的左边的起点,右边结束的位置由text的长度自动适应
- (void)widthAdaption;
//高度自适应方法,就是我定义号label的上边的起点,底边结束的位置由text的高度自动适应
- (void)heightAdaption;

- (void)widthAdaptionMaxWidth:(CGFloat)width;

- (void)heightAdaptionMaxHeight:(CGFloat)height;

@end
