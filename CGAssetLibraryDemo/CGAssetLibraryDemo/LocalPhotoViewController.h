//
//  LocalPhotoViewController.h
//  Chris Gaptain
//
//  Created by Chris Gaptain on 16/11/26.
//  Copyright (c) 2016年 Chris Gaptain. All rights reserved.
//


/*
 * 意见反馈中 展示手机图片的控制器
 */

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface LocalPhotoViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger totalSelectCount;
// 装有选中的图片
@property (nonatomic, strong) NSMutableArray *selectArray;

// 接收上个界面传来的数据
@property (nonatomic, strong) ALAssetsGroup *group;

@end
