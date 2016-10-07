//
//  ImageCollectionCell.m
//  Chris Gaptain
//
//  Created by Chris Gaptain on 16/11/25.
//  Copyright (c) 2016年 Chris Gaptain. All rights reserved.
//

#import "ImageCollectionCell.h"

@implementation ImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
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
