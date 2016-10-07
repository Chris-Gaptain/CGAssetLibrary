//
//  PhotoAlbumListViewController.m
//  Chris Gaptain
//
//  Created by Chris Gaptain on 16/11/27.
//  Copyright (c) 2016年 Chris Gaptain. All rights reserved.
//

#import "PhotoAlbumListViewController.h"
#import "LocalPhotoViewController.h"
#import "PhotoAlbumTableCell.h"
#import "UILabel+SizeAdaption.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "AssetHelper.h"

@interface PhotoAlbumListViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation PhotoAlbumListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initialSubView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [[AssetHelper defaultAssetsLibrary] enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
            [group setAssetsFilter:onlyPhotosFilter];
            
            if ([group numberOfAssets]>0) {
                
                LocalPhotoViewController *localVC = [[LocalPhotoViewController alloc]init];
                localVC.group = group;
                localVC.totalSelectCount = self.count;
                [self.navigationController pushViewController:localVC animated:NO];
            } else {
                NSLog(@"读取相册完毕");
            }

        } failureBlock:^(NSError *error) {
            NSLog(@"相册打开失败");
            }];
        
         });
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)groups {
    if (!_groups) {
        _groups = [[NSMutableArray alloc]initWithCapacity:10];
        dispatch_async(dispatch_get_main_queue(), ^{

            [[AssetHelper defaultAssetsLibrary] enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {

                if (group) {
                    [_groups addObject:group];
                    [self.tableView reloadData];
                }
                
            } failureBlock:^(NSError *error) {
                NSLog(@"相册打开失败");
            }];
            
        });
    }
    return _groups;
}

#pragma mark - Tableview DataSource && Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"PhotoAlbumTableCell";
    
    PhotoAlbumTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
        cell = [[PhotoAlbumTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    ALAssetsGroup *group = [self.groups objectAtIndex:indexPath.row];
    cell.assetsGroup = group;
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LocalPhotoViewController *localVC = [[LocalPhotoViewController alloc]init];
    localVC.totalSelectCount = self.count;
    localVC.group = self.groups[indexPath.row];
    [self.navigationController pushViewController:localVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - 初始化视图
- (void)initialSubView {
    
    self.navigationItem.title = @"照片";
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"img_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAct)];
    self.navigationItem.leftBarButtonItem = bar;
}

- (void)backAct {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
