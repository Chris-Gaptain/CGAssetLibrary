//
//  UTPhotoDetailViewController.m
//  UThing
//
//  Created by wolf on 15/11/27.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

//获取当前屏幕的宽度
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
//获取当前屏幕的高度
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height


#import "UTPhotoDetailViewController.h"
#import "ZoomScrollView.h"

@interface UTPhotoDetailViewController ()

@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIImageView *zoomImageView;
@property (nonatomic, strong) ZoomScrollView *zoomScrollView;

@end

@implementation UTPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.zoomScrollView];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.rightBtn];
    
    if (self.imageModel.selectState) {
        
        [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    } else {
        
        [self.rightBtn setTitle:@"选择" forState:UIControlStateNormal];
    }
    
    
}

#pragma mark - Getter
- (ZoomScrollView *)zoomScrollView {
    if (!_zoomScrollView) {
        _zoomScrollView = [[ZoomScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight+20)];
        
//        [self.imageModel originalImage:^(UIImage *image) {
//            
//            _zoomScrollView.imageView.image = image;
//            CGFloat scale = image.size.height / image.size.width;
//            _zoomScrollView.imageView.center = CGPointMake(_zoomScrollView.bounds.size.width/2, _zoomScrollView.bounds.size.height/2);
//            _zoomScrollView.imageView.bounds = CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth *scale);
//        }];

    }
    return _zoomScrollView;
}

// 假导航
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
        _navView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
        _navView.userInteractionEnabled = YES;
//        _navView.backgroundColor = [UIColor redColor];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth/2-25, 30, 50, 20)];
//        [titleLabel setText:@"预览" textColor:[UIColor colorFromHexRGB:@"ffffff"] font:[UIFont systemFontOfSize:17.0]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_navView addSubview:titleLabel];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(12, 25, 30, 30);
        [backBtn setImage:[UIImage imageNamed:@"feedback_backBtn.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(feedbackBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:backBtn];
        
    }
    return _navView;
}

// 选择和取消按钮
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(kMainScreenWidth-60-5, 10, 60, CGRectGetHeight(self.navView.frame));
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
//        [_rightBtn setTitleColor:[UIColor colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
//        _rightBtn.backgroundColor = [UIColor yellowColor];
        _rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [_rightBtn addTarget:self action:@selector(feedbackRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

// 选择和取消
- (void)feedbackRightBtnAction:(UIButton *)sender {
    
    if (self.imageModel.selectState) {
        
        if ([self.totalArray containsObject:self.imageModel]) {
            
            [self.totalArray removeObject:self.imageModel];
        }
        
        self.imageModel.selectState = NO;
        [self.rightBtn setTitle:@"选择" forState:UIControlStateNormal];
    } else {
        
        if (self.totalArray.count + self.selectCount == 4) {
            // 数组最多只能装有4张图片
//            SIAlertView *alertView = [[SIAlertView alloc]initWithTitle:nil andMessage:@"最多选择4张图片"];
//            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
//            }];
//            [alertView show];
            return;
        }

        [self.totalArray addObject:self.imageModel];
        self.imageModel.selectState = YES;
        [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
        
        if (self.choseBlock) {
            self.choseBlock (self.imageModel, self.totalArray);
        }

        [self.navigationController popViewControllerAnimated:YES];
    }

    NSLog(@"self.totalArray.count = %ld",self.totalArray.count);
}

// 返回上一页
- (void)feedbackBackBtnAction {
    
    
    if (self.choseBlock) {
        self.choseBlock (self.imageModel, self.totalArray);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
