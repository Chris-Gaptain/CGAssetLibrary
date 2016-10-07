//
//  BlankCollectionCell.m
//  UThing
//
//  Created by wolf on 15/11/25.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import "BlankCollectionCell.h"

@implementation BlankCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
