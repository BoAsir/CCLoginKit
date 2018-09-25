//
//  DPImageDetailView.h
//  JCZJ
//
//  Created by sunny_ios on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAsset+DPSelectImage.h"


@protocol SelectPicDelegate <NSObject>

- (void)setUpDetailAddedImageView:(NSArray *)images;

@end

typedef void (^DPImageSelectBlock)(ALAsset *curModel, BOOL isSelect);

@interface DPImageDetailView : UIViewController

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray *assetArray;

@property (nonatomic, copy) DPImageSelectBlock selectBlock;

@property (nonatomic, weak) id<SelectPicDelegate> delegate;

@end