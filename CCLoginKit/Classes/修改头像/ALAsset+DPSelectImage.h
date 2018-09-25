//
//  ALAsset+DPSelectImage.h
//  JCZJ
//
//  Created by sunny_ios on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface ALAsset (DPSelectImage)

@property (nonatomic, assign) BOOL isSelected;

+ (void)getorignalImage:(ALAsset *)assert completion:(void (^)(UIImage *))returnImage;

@end
