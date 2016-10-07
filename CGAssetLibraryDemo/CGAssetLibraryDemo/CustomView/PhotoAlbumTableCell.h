//
//  PhotoAlbumTableCell.h
//  UThing
//
//  Created by wolf on 15/11/27.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoAlbumTableCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@end
