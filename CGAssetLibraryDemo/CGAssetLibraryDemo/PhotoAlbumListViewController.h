//
//  PhotoAlbumListViewController.h
//  UThing
//
//  Created by wolf on 15/11/27.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) NSInteger count;
@end
