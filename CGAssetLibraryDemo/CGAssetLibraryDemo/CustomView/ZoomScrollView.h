//
//  ZoomScrollView.h
//  UThing
//
//  Created by wolf on 15/11/27.
//  Copyright (c) 2015年 UThing. All rights reserved.
//


/*
 * 这是一个自身能放大缩小的Scrollview.自带一个与之等大的imageView,缩放也作用于这个imageView的.
 */

#import <UIKit/UIKit.h>

@interface ZoomScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end
