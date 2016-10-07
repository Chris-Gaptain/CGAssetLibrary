//
//  PhotoAlbumTableCell.m
//  Chris Gaptain
//
//  Created by Chris Gaptain on 16/11/27.
//  Copyright (c) 2016年 Chris Gaptain. All rights reserved.
//


#import "PhotoAlbumTableCell.h"
#import "UILabel+SizeAdaption.h"

@implementation PhotoAlbumTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.countLabel];
        [self.contentView addSubview:self.icon];
    }
    return self;
}

#pragma mark - Setter
- (void)setAssetsGroup:(ALAssetsGroup *)assetsGroup {
    _assetsGroup = assetsGroup;
    
    NSString *groupName = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger groupCount = [assetsGroup numberOfAssets];
    
    UIImage *image = [UIImage imageWithCGImage:assetsGroup.posterImage];
    self.imageV.image = image;
    
    self.titleLabel.text = groupName;
    [self.titleLabel widthAdaption];
    
    self.countLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+5, CGRectGetMinY(self.titleLabel.frame), 10, 20);
    self.countLabel.text = [NSString stringWithFormat:@"(%ld)",groupCount];
    [self.countLabel widthAdaption];
}

#pragma mark - Getter
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
//        _imageV.backgroundColor = [UIColor cyanColor];
    }
    return _imageV;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame)+15, (75-20)/2, 150, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
//        _titleLabel.backgroundColor = [UIColor redColor];
    }
    return _titleLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+5, CGRectGetMinY(self.titleLabel.frame), 10, 20)];
        _countLabel.font = [UIFont systemFontOfSize:16.0];
//        _countLabel.backgroundColor = [UIColor blueColor];
    }
    return _countLabel;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(kMainScreenWidth-13-15, 30, 15, 15)];
        _icon.image = [UIImage imageNamed:@"icoArrow.png"];
    }
    return _icon;
}

@end
