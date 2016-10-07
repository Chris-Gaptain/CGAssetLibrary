//
//  UTImageDetailViewController.m
//  UThing
//
//  Created by wolf on 15/12/14.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import "UTImageDetailViewController.h"
#import "ZoomScrollView.h"


@interface UTImageDetailViewController ()

@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIImageView *zoomImageView;
@property (nonatomic, strong) ZoomScrollView *zoomScrollView;

@end

@implementation UTImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.zoomScrollView];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.rightBtn];
}

#pragma mark - Getter
- (ZoomScrollView *)zoomScrollView {
    if (!_zoomScrollView) {
        _zoomScrollView = [[ZoomScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight+20)];
                
        if (self.imageModel.isFromCamera) {
            
            _zoomScrollView.imageView.image = self.imageModel.thumbnail;
        } else {
            
            [self.imageModel originalImage:^(UIImage *image) {
                _zoomScrollView.imageView.image = image;
                CGFloat scale = image.size.height / image.size.width;
                _zoomScrollView.imageView.center = CGPointMake(_zoomScrollView.bounds.size.width/2, _zoomScrollView.bounds.size.height/2);
                _zoomScrollView.imageView.bounds = CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth *scale);
            }];

        }
        
    }
    return _zoomScrollView;
}

// 假导航
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
        _navView.userInteractionEnabled = YES;
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth/2-25, 30, 50, 20)];
        titleLabel.text = @"预览";
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_navView addSubview:titleLabel];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(12, 25, 30, 30);
        [backBtn setImage:[UIImage imageNamed:@"feedback_backBtn.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(detailImageBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [_rightBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(detailImageRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

// 删除图片
- (void)detailImageRightBtnAction:(UIButton *)sender {
    
    SIAlertView *alertView = [[SIAlertView alloc]initWithTitle:nil andMessage:@"是否删除所选图片"];

    [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
        [self.navigationController popViewControllerAnimated:YES];
    }];

    [alertView addButtonWithTitle:@"删除" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
        // 删除数组中对应的图片
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",self.index],@"row", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteImage" object:nil userInfo:dic];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertView show];

}

// 返回上一页
- (void)detailImageBackBtnAction {
    
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
