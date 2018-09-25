//
//  ALAsset+DPSelectImage.m
//  JCZJ
//
//  Created by sunny_ios on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//
#import <objc/runtime.h>
#import "ALAsset+DPSelectImage.h"
static const char *select_key = "select_key";

@implementation ALAsset (DPSelectImage)
- (BOOL)isSelected {
    return [objc_getAssociatedObject(self, select_key) boolValue];
}

- (void)setIsSelected:(BOOL)isSelected {
    objc_setAssociatedObject(self, select_key, [NSNumber numberWithBool:isSelected], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)getorignalImage:(ALAsset *)assert completion:(void (^)(UIImage *))returnImage {
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    [lib assetForURL:assert.defaultRepresentation.url resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *rep = asset.defaultRepresentation;
//        CGImageRef imageRef = rep.fullResolutionImage;
        CGImageRef imageRef = rep.fullScreenImage;

        
//         ALAssetOrientation  origin  = rep.orientation ;
//        
//        UIImage *thubimage = [UIImage imageWithCGImage:assert.thumbnail] ;
//        UIImage *image22 = [UIImage imageWithCGImage:imageRef scale:rep.scale orientation:(UIImageOrientation)rep.orientation];
        UIImage *image = [UIImage imageWithCGImage:imageRef scale:rep.scale orientation:UIImageOrientationUp];

        if (image) {
            returnImage(image);
        }
    }
        failureBlock:^(NSError *error){
            
        }];
}
@end
