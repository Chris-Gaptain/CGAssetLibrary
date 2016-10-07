//
//  UTImageModel.m
//  UThing
//
//  Created by wolf on 15/11/26.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import "UTImageModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetHelper.h"

@implementation UTImageModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectState = NO;
        self.isFromCamera = NO;
    }
    return self;
}

//- (void)originalImage:(void (^)(UIImage *))returnImage{
//    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
//    [lib assetForURL:self.imageUrl resultBlock:^(ALAsset *asset) {
//        ALAssetRepresentation *rep = asset.defaultRepresentation;
//        CGImageRef imageRef = rep.fullResolutionImage;
//        UIImage *image = [UIImage imageWithCGImage:imageRef scale:rep.scale orientation:(UIImageOrientation)rep.orientation];
//        if (image) {
//            returnImage(image);
//        }
//    } failureBlock:^(NSError *error) {
//        
//    }];
//}


@end
