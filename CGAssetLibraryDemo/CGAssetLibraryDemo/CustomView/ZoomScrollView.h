//
//  ZoomScrollView.h
//  Chris Gaptain
//
//  Created by Chris Gaptain on 16/11/27.
//  Copyright (c) 2016年 Chris Gaptain. All rights reserved.
//


/*
 * 这是一个自身能放大缩小的Scrollview.自带一个与之等大的imageView,缩放也作用于这个imageView的.
 */

#import <UIKit/UIKit.h>

@interface ZoomScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end
