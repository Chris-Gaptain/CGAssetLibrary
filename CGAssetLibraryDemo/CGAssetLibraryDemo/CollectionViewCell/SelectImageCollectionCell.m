//
//  SelectImageCollectionCell.m
//  UThing
//
//  Created by wolf on 15/11/26.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import "SelectImageCollectionCell.h"

@implementation SelectImageCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imageV];
        [self.imageV addSubview:self.selectBtn];
        
    }
    return self;
}

#pragma mark - Getter
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _imageV.userInteractionEnabled = YES;
    }
    return _imageV;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(CGRectGetWidth(self.imageV.frame)-32, 0, 32, 32);
        [_selectBtn setImage:[UIImage imageNamed:@"feedback_normal_image.png"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"feedback_selected_image.png"] forState:UIControlStateSelected];
//        _selectBtn.backgroundColor = [UIColor redColor];
    }
    return _selectBtn;
}
@end
