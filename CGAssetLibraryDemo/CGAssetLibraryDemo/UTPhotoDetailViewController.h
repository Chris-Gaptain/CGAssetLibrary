//
//  UTPhotoDetailViewController.h
//  UThing
//
//  Created by wolf on 15/11/27.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

/*
 * 意见反馈中 展示图片详情的控制器
 */

#import <UIKit/UIKit.h>
#import "UTImageModel.h"

typedef void(^ChoseImageBlock)(UTImageModel *iModel, NSMutableArray *mutableArray);

@interface UTPhotoDetailViewController : UIViewController

@property (nonatomic, strong) UTImageModel *imageModel;
@property (nonatomic, assign) NSInteger selectCount;
@property (nonatomic, strong) NSMutableArray *totalArray;

@property (nonatomic, copy) ChoseImageBlock choseBlock;

@property (nonatomic,  strong) UIImage *detailImage;

@end
