//
//  LocalPhotoViewController.m
//  UThing
//
//  Created by wolf on 15/11/26.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

//获取当前屏幕的宽度
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
//获取当前屏幕的高度
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height

#import "LocalPhotoViewController.h"
#import "UTPhotoDetailViewController.h"
#import "SelectImageCollectionCell.h"
#import "AssetHelper.h"
#import "UTImageModel.h"

NSString * const pickerImageCellIndentifer = @"pickerImageCellIndentifer";

@interface LocalPhotoViewController ()

// 装有手机相册中所有的图片
@property (nonatomic, strong) NSMutableArray *dataSource;

// 底部视图
@property (nonatomic, strong) UIView *bottomView;
// 确定按钮
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) ALAssetsGroup *currentAlbum;

@property (nonatomic, strong) NSMutableArray *source;

@end

@implementation LocalPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化视图
    [self initialSubViews];
    
    self.selectArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    [self.sureBtn setTitle:[NSString stringWithFormat:@"(0/%ld)确认",4-self.totalSelectCount] forState:UIControlStateNormal];
    
    [self.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result == nil) return;
        if (![[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {//不是图片
            return;
        }
        UTImageModel *model = [[UTImageModel alloc]init];
//        model.thumbnail = [UIImage imageWithCGImage:result.thumbnail];
        model.imageUrl = result.defaultRepresentation.url;
        model.isFromCamera = NO;
//        model.fullImage =  [UIImage imageWithCGImage:result.defaultRepresentation.fullScreenImage];
        [self.dataSource addObject:model];

    }];
    
    self.source = [[NSMutableArray alloc]initWithCapacity:10];
}

#pragma mark - Getter
// 数据源
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _dataSource;
}
// 底部view
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kMainScreenHeight-88, kMainScreenWidth, 44)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1)];
        lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:1.0];
        [_bottomView addSubview:lineView];
    }
    return _bottomView;
}
// 确定按钮
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(kMainScreenWidth-100-12, 0, 100, 44);
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        _sureBtn.backgroundColor = [UIColor redColor];
        
        _sureBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    }
    return _sureBtn;
}
// CollectionViewLayout
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake((kMainScreenWidth-36)/3, (kMainScreenWidth-36)/3);
        _layout.headerReferenceSize = CGSizeMake(0, 13);
        _layout.minimumLineSpacing = 6.0;
        _layout.minimumInteritemSpacing = 6.0;
        _layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    }
    return _layout;
}
// CollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kMainScreenHeight-44-44) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[SelectImageCollectionCell class] forCellWithReuseIdentifier:pickerImageCellIndentifer];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SelectImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:pickerImageCellIndentifer forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    UTImageModel *model = self.dataSource[indexPath.row];
//    cell.imageV.image = model.thumbnail;
    
    if (model.selectState) {
        
        [cell.selectBtn setImage:[UIImage imageNamed:@"feedback_selected_image.png"] forState:UIControlStateNormal];
        model.selectState = YES;
    } else {
        
        [cell.selectBtn setImage:[UIImage imageNamed:@"feedback_normal_image.png"] forState:UIControlStateNormal];
        model.selectState = NO;
    }
    
    [cell.selectBtn addTarget:self action:@selector(selectImageAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectBtn.tag = indexPath.row + 50000;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    UTImageModel *model = self.dataSource[indexPath.row];
    
    UTPhotoDetailViewController *detailVC = [[UTPhotoDetailViewController alloc]init];
    
    detailVC.imageModel = model;
    detailVC.selectCount = self.totalSelectCount;
    detailVC.totalArray = self.selectArray;
    
    detailVC.choseBlock = ^(UTImageModel *iModel, NSMutableArray *array){
        
        SelectImageCollectionCell *cell = (SelectImageCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        
        self.selectArray = array;

        if (iModel.selectState) {

            [cell.selectBtn setImage:[UIImage imageNamed:@"feedback_selected_image.png"] forState:UIControlStateNormal];
            model.selectState = YES;
        } else {

            [cell.selectBtn setImage:[UIImage imageNamed:@"feedback_normal_image.png"] forState:UIControlStateNormal];
            model.selectState = NO;
        }
        NSLog(@"====%ld",self.selectArray.count);
        
        [self.sureBtn setTitle:[NSString stringWithFormat:@"(%ld/%ld)确认",self.selectArray.count,4-self.totalSelectCount] forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Action
// collectionView上得选择图片按钮
- (void)selectImageAction:(UIButton *)sender {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag - 50000 inSection:0];
    
    UTImageModel *model = self.dataSource[indexPath.row];
    
    if ([self.selectArray containsObject:model]) {
        
        [self.selectArray removeObject:model];
    } else {
        
        // 数组最多只能装有4张图片
        if (self.selectArray.count+self.totalSelectCount > 3) {
//            SIAlertView *alertView = [[SIAlertView alloc]initWithTitle:nil andMessage:@"最多选择4张图片"];
//            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
//            }];
//            [alertView show];
            return;
        }
        [self.selectArray addObject:model];
    }
    
    if (model.selectState) {
        model.selectState = NO;
    } else {
        model.selectState = YES;
    }
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    [self.sureBtn setTitle:[NSString stringWithFormat:@"(%ld/%ld)确认",self.selectArray.count,4-self.totalSelectCount] forState:UIControlStateNormal];

    
    NSLog(@"=======%ld",self.selectArray.count);
}
// 底部视图上得确定按钮
- (void)confirmBtnAction:(UIButton *)sender {
    

//    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithCapacity:10];
    
//    for (NSInteger i = 0; i < self.selectArray.count; i++) {
//        
//        UTImageModel *model = self.selectArray[i];
//        
//        [mutableArray addObject:model.thumbnail];
//    }
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:self.selectArray,@"PhotoArray", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"GetSelectedPhotoNotification" object:nil userInfo:dic];
    [self dismissViewControllerAnimated:NO completion:nil];
}

// 读出手机相册中所有的图片
//- (void)showPhoto:(ALAssetsGroup *)album {
//
//    if (album != nil) {
//        
//        if (self.currentAlbum == nil || [[self.currentAlbum valueForProperty:ALAssetsGroupPropertyName] isEqualToString:[album valueForProperty:ALAssetsGroupPropertyName]]) {
//            
//            self.currentAlbum = album;
//            if (!self.dataSource) {
//                self.dataSource = [[NSMutableArray alloc]init];
//            } else {
//                [self.dataSource removeAllObjects];
//            }
//            
//            ALAssetsFilter *photoFilter = [ALAssetsFilter allPhotos];
//            [self.currentAlbum setAssetsFilter:photoFilter];
////            [self.currentAlbum enumerateAssetsUsingBlock:assetsEnumerationBlock];
////            self.title = [self.currentAlbum valueForProperty:ALAssetsGroupPropertyName];
//            
//            [self.currentAlbum enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                
//                if (result) {
//                    
//                    CGImageRef imageRef = [result thumbnail];
////                    CGImageRef imageRef = [result defaultRepresentation].fullScreenImage;
//                    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
//                    
//                    UTImageModel *model = [[UTImageModel alloc]init];
//                    model.thumbnail = thumbnail;
//                    model.selectState = NO;
//                    
//                    [self.dataSource addObject:model];
//                    
////                    CGImageRef imageRef2 = [result defaultRepresentation].fullScreenImage;
////                    UIImage *thumbnail2 = [UIImage imageWithCGImage:imageRef2];
////                    [self.source addObject:thumbnail2];
//                }
//
//            }];
//            
//            [self.collectionView reloadData];
//            
//            
//        }
//    }
//}

#pragma mark - initial
- (void)initialSubViews {
    
    self.navigationItem.title = @"选择照片";
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.sureBtn];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBarButtonAction)];
    
    self.navigationItem.rightBarButtonItem = bar;
}

- (void)cancelBarButtonAction {
    

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)download:(ALAssetsGroup *)album {
//    
//    if (album != nil) {
//        
//        if (self.currentAlbum == nil || [[self.currentAlbum valueForProperty:ALAssetsGroupPropertyName] isEqualToString:[album valueForProperty:ALAssetsGroupPropertyName]]) {
//            
//            self.currentAlbum = album;
//            if (!self.source) {
//                self.source = [[NSMutableArray alloc]init];
//            } else {
//                [self.source removeAllObjects];
//            }
//            
//            ALAssetsFilter *photoFilter = [ALAssetsFilter allPhotos];
//            [self.currentAlbum setAssetsFilter:photoFilter];
//            
//            [self.currentAlbum enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                
//                if (result) {
//                    
//                    CGImageRef imageRef = [result defaultRepresentation].fullScreenImage;
//                    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
//                    [self.source addObject:thumbnail];
//                }
//                
//            }];
//            
//            
//            
//        }
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
