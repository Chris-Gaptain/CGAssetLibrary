//
//  PhotoAlbumListViewController.h
//  Chris Gaptain
//
//  Created by Chris Gaptain on 16/11/27.
//  Copyright (c) 2016年 Chris Gaptain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) NSInteger count;
@end
