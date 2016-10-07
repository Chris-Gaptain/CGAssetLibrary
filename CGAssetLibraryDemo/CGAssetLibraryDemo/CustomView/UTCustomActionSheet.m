//
//  UTCustomActionSheet.m
//  UThing
//
//  Created by wolf on 15/12/10.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import "UTCustomActionSheet.h"

// 按钮高度
#define BUTTON_H 50.0f
// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
// 颜色
#define UTColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

@interface UTCustomActionSheet ()
{
    /** 所有按钮 */
    NSArray *_buttonTitles;
    
    /** 暗黑色的view */
    UIView *_darkView;
    
    /** 所有按钮的底部view */
    UIView *_bottomView;
    
    /** 代理 */
    id<UTActionSheetDelegate> _delegate;

}

@property (nonatomic, strong) UIWindow *backWindow;

@end

@implementation UTCustomActionSheet

+ (instancetype)sheetWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(NSInteger)buttonIndex delegate:(id<UTActionSheetDelegate>)delegate {
    
    return [[self alloc] initWithTitle:title buttonTitles:titles redButtonIndex:buttonIndex delegate:delegate];
}

- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(NSInteger)buttonIndex delegate:(id<UTActionSheetDelegate>)delegate {
    self = [super init];
    if (self) {
        
        _delegate = delegate;

        // 暗黑色的view
        UIView *darkView = [[UIView alloc] init];
        [darkView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
//        darkView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        darkView.userInteractionEnabled = NO;
        darkView.alpha = 0;
        darkView.backgroundColor = UTColor(46, 49, 50);
        [self addSubview:darkView];
        _darkView = darkView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        [darkView addGestureRecognizer:tap];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = UTColor(233, 233, 238);
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        if (title) {
            //标题
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, BUTTON_H)];
            label.text = title;
            label.textColor = UTColor(111, 111, 111);
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13.0];
            label.backgroundColor = [UIColor whiteColor];
            [bottomView addSubview:label];
        }
        
        if (titles.count) {
            
            _buttonTitles = titles;
            
            for (int i = 0; i < titles.count; i++) {
                
                // 所有按钮
                UIButton *btn = [[UIButton alloc] init];
                btn.tag = i;
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
                
                UIColor *titleColor = nil;
                if (i == buttonIndex) {
                    
                    titleColor = UTColor(255, 10, 10);
                    
                } else {
                    
                    titleColor = [UIColor blackColor] ;
                }
                [btn setTitleColor:titleColor forState:UIControlStateNormal];
                
                [btn setBackgroundImage:[UIImage imageNamed:@"bgImage_HL"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                CGFloat btnY = BUTTON_H * (i + (title ? 1 : 0));
                btn.frame = CGRectMake(0, btnY, SCREEN_SIZE.width, BUTTON_H);
                [bottomView addSubview:btn];
            }
            
            for (int i = 0; i < titles.count; i++) {
                
                 CGFloat lineY = (i + (title ? 1 : 0)) * BUTTON_H;
                // 所有线条
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, lineY, SCREEN_SIZE.width, 1.0f)];
                line.image = [UIImage imageNamed:@"cellLine"];
                line.contentMode = UIViewContentModeCenter;
                [bottomView addSubview:line];
            }
        }
        
        // 取消按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.tag = titles.count;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"bgImage_HL"] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnY = BUTTON_H * (titles.count + (title ? 1 : 0)) + 5.0f;
        cancelBtn.frame = CGRectMake(0, btnY, SCREEN_SIZE.width, BUTTON_H);
        [bottomView addSubview:cancelBtn];
        
        CGFloat bottomH = (title ? BUTTON_H : 0) + BUTTON_H * titles.count + BUTTON_H + 5.0f;
        [bottomView setFrame:CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, bottomH)];
        
        [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [self.backWindow addSubview:self];


    }
    return self;
}

- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
//        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}

- (void)didClickBtn:(UIButton *)sender {
    
    [self dismiss:nil];
    
    if ([_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        
        [_delegate actionSheet:self didClickedButtonAtIndex:sender.tag];
    }
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         _backWindow.hidden = YES;
                         
                         [self removeFromSuperview];
                     }];
}

- (void)didClickCancelBtn {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         _backWindow.hidden = YES;
                         
                         [self removeFromSuperview];
                         
                         if ([_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
                             
                             [_delegate actionSheet:self didClickedButtonAtIndex:_buttonTitles.count];
                         }
                     }];
}

- (void)show {
    
    _backWindow.hidden = NO;
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0.4f];
                         [_darkView setUserInteractionEnabled:YES];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y -= frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     }
                     completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
