//
//  ImageCollectionCell.m
//  UThing
//
//  Created by wolf on 15/11/25.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import "ImageCollectionCell.h"

@implementation ImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageV];
    }
    return self;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _imageV.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageV;
}

@end
