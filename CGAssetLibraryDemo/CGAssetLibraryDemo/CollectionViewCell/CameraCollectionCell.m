//
//  CameraCollectionCell.m
//  UThing
//
//  Created by wolf on 15/11/25.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import "CameraCollectionCell.h"

@implementation CameraCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imageV];
    }
    return self;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 37.5, 33)];
        _imageV.image = [UIImage imageNamed:@"mine_feedback_camera.png"];
    }
    return _imageV;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageV.center = self.contentView.center;
}
@end
