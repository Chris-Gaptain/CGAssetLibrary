//
//  UTImageDetailViewController.h
//  UThing
//
//  Created by wolf on 15/12/14.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UTImageModel.h"

/**
 *  controller: 照片详情
 */
@interface UTImageDetailViewController : UIViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UTImageModel *imageModel;

@end
