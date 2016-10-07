//
//  UTCustomActionSheet.h
//  UThing
//
//  Created by wolf on 15/12/10.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UTCustomActionSheet;

@protocol UTActionSheetDelegate <NSObject>

/**
 *  点击了buttonIndex处的按钮
 */
- (void)actionSheet:(UTCustomActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface UTCustomActionSheet : UIView

/**
 *  返回一个ActionSheet对象, 类方法
 *
 *  @param title 提示标题
 *
 *  @param titles 所有按钮的标题
 *
 *  @param redButtonIndex 红色按钮的index
 *
 *  @param delegate 代理
 *
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
+ (instancetype)sheetWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(NSInteger)buttonIndex delegate:(id<UTActionSheetDelegate>)delegate;
/**
 *  返回一个ActionSheet对象, 实例方法
 *
 *  @param title 提示标题
 *
 *  @param titles 所有按钮的标题
 *
 *  @param redButtonIndex 红色按钮的index
 *
 *  @param delegate 代理
 *
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(NSInteger)buttonIndex delegate:(id<UTActionSheetDelegate>)delegate;

- (void)show;

@end
