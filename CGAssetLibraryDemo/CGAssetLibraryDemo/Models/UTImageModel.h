//
//  UTImageModel.h
//  UThing
//
//  Created by wolf on 15/11/26.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^ShowOriginalImageBlock)(UIImage *returnImage);

@interface UTImageModel : NSObject

//@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, copy) NSURL *imageUrl;

@property (nonatomic, assign) BOOL selectState;
@property (nonatomic, assign) BOOL isFromCamera;


//- (void)originalImage:(void (^)(UIImage *image))returnImage;//获取原图

@end
