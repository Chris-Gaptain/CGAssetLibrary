//
//  ViewController.m
//  CGAssetLibraryDemo
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Chris Gaptain. All rights reserved.
//

#import "ViewController.h"
#import "CameraCollectionCell.h"
#import "BlankCollectionCell.h"
#import "ImageCollectionCell.h"
#import "UTCustomActionSheet.h"
#import "PhotoAlbumListViewController.h"
#import "UTImageDetailViewController.h"
#import "UTImageModel.h"

NSString * const imageViewCellIdentifier   = @"ImageViewCellIdentifier";
NSString * const cameraCellIndentifier   = @"ClickBtnCellIndentifier";
NSString * const noImageViewCellIndentifer = @"NoImageViewCellIndentifer";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UTActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.collectionView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getSelectedPhotoNotification:) name:@"GetSelectedPhotoNotification" object:nil];
}

- (void)getSelectedPhotoNotification:(NSNotification *)notification {
    NSMutableArray *array = [notification.userInfo objectForKey:@"PhotoArray"];
    [self.dataArray addObjectsFromArray:array];
    [self.collectionView reloadData];
}

#pragma mark - Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

// CollectionViewLayout
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake((kMainScreenWidth-50)/4, (kMainScreenWidth-50)/4);
        _layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    }
    return _layout;
}

// CollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, kMainScreenWidth,(kMainScreenWidth-50)/4) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[CameraCollectionCell class] forCellWithReuseIdentifier:cameraCellIndentifier];
        [_collectionView registerClass:[ImageCollectionCell class] forCellWithReuseIdentifier:imageViewCellIdentifier];
        [_collectionView registerClass:[BlankCollectionCell class] forCellWithReuseIdentifier:noImageViewCellIndentifer];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

#pragma mark - CollectionViewDataSource && delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count == 0) {
        if (indexPath.row == 0) {
            CameraCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cameraCellIndentifier forIndexPath:indexPath];
            return cell;
        } else {
            BlankCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:noImageViewCellIndentifer forIndexPath:indexPath];
            return cell;
        }
    }
    
    if (self.dataArray.count == 4) {
        ImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageViewCellIdentifier forIndexPath:indexPath];
        
        UTImageModel *model = self.dataArray[self.dataArray.count - indexPath.row - 1];
        cell.imageV.image = model.thumbnail;
        return cell;
    }

    if (self.dataArray.count > 0 && self.dataArray.count < 4) {
        if (indexPath.row < self.dataArray.count) {
            ImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageViewCellIdentifier forIndexPath:indexPath];
            
            UTImageModel *model = self.dataArray[self.dataArray.count - indexPath.row - 1];
            cell.imageV.image = model.thumbnail;
            return cell;
        }
        
        if (indexPath.row == self.dataArray.count) {
            CameraCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cameraCellIndentifier forIndexPath:indexPath];
            
            return cell;
        } else {
            BlankCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:noImageViewCellIndentifer forIndexPath:indexPath];
            
            return cell;
        }
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (self.dataArray.count == 0) {
        if (indexPath.row == 0) {
            
            [self showActionSheet];
        }
    }

    if (self.dataArray.count > 0 && self.dataArray.count < 8) {
        if (indexPath.row == self.dataArray.count) {
            
            [self showActionSheet];
        } else if (indexPath.row < self.dataArray.count) {
             // 删除图片
            [self didSelectCollectionViewCheckImageDetail:indexPath];
        } else {
            
        }
    }
    //
}

- (void)showActionSheet {
    // 添加图片按钮
    UTCustomActionSheet *sheetView = [UTCustomActionSheet sheetWithTitle:nil buttonTitles:@[@"拍照",@"从手机相册选择"] redButtonIndex:-1 delegate:self];
    [sheetView show];
}

- (void)didSelectCollectionViewCheckImageDetail:(NSIndexPath *)indexPath {
    
    UTImageDetailViewController *detail = [[UTImageDetailViewController alloc]init];
    detail.index = indexPath.row;
    detail.imageModel = self.dataArray[self.dataArray.count-indexPath.row-1];
    
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - UTCustomActionSheet delegate
- (void)actionSheet:(UTCustomActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //拍照
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        //            imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];    }
    if (buttonIndex == 1) {
        //从手机相册选择(自定义手机相册)
        PhotoAlbumListViewController *photoVC = [[PhotoAlbumListViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:photoVC];
        
        if (self.dataArray.count) {
            ((PhotoAlbumListViewController *)nav.viewControllers[0]).count = self.dataArray.count;
            //            photoVC.count = self.headerView.dataArray.count;
        }
        [self presentViewController:nav animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
