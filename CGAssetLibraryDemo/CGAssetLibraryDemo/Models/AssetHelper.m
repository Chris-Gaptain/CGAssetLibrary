//
//  AssetHelper.m
//  Chris Gaptain
//
//  Created by Chris Gaptain on 16/11/26.
//  Copyright (c) 2016年 Chris Gaptain. All rights reserved.
//

#import "AssetHelper.h"


@implementation AssetHelper

+(ALAssetsLibrary *) defaultAssetsLibrary;
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,
                  ^{
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}


@end

