//
//  BlankCollectionCell.m
//  Chris Gaptain
//
//  Created by Chris Gaptain on 16/11/25.
//  Copyright (c) 2016年 Chris Gaptain. All rights reserved.
//

#import "BlankCollectionCell.h"

@implementation BlankCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

@end
