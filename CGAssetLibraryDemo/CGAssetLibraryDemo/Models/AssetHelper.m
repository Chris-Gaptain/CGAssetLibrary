//
//  AssetHelper.m
//  UThing
//
//  Created by wolf on 15/11/26.
//  Copyright (c) 2015年 UThing. All rights reserved.
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

