//
//  VPImageCropperViewController.h
//  VPolor
//
//  Created by Vinson.D.Warm on 12/30/13.
//  Copyright (c) 2013 Huang Vinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VPImageCropperViewController;


typedef void(^DPFinishHandle)(VPImageCropperViewController *controller, UIImage *image);

@interface VPImageCropperViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) CGRect circleFrame;

@property(nonatomic ,copy) DPFinishHandle finishhandle ;

- (id)initWithImage:(UIImage *)originalImage circleFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

- (id)initWithImage:(UIImage *)originalImage circleFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio rectangles:(BOOL)isRectangles;

- (id)initWithImage:(UIImage *)originalImage circleFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio rectangles:(BOOL)isRectangles rectangleSize:(CGSize)rectangleSize;

@end

@interface UIImage (kCategory)

- (UIImage *)dp_resizedImageToSize:(CGSize)dstSize  ;

@end
