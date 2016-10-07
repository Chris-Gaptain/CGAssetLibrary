//
//  UILabel+SizeAdaption.m
//  ceshi
//
//  Created by US Corp on 14/11/21.
//  Copyright (c) 2014年 uscorp. All rights reserved.
//


#import "UILabel+SizeAdaption.h"

@implementation UILabel (SizeAdaption)
// 自适应宽度
- (void)widthAdaption
{
    self.numberOfLines=0;
    CGRect rect =[self.text boundingRectWithSize:CGSizeMake(1000, self.frame.size.height) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width, self.frame.size.height);
}
// 自适应高度
- (void)heightAdaption
{
    self.numberOfLines=0;
    CGRect rect =[self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rect.size.height);
}

- (void)widthAdaptionMaxWidth:(CGFloat)width
{
    self.numberOfLines=0;
    CGRect rect =[self.text boundingRectWithSize:CGSizeMake(width, self.frame.size.height) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width, self.frame.size.height);
}

- (void)heightAdaptionMaxHeight:(CGFloat)height
{
//    self.numberOfLines=0;
    CGRect rect =[self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, height) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width, self.frame.size.height);
}



@end
