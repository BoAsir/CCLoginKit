//
//  DPSelectImgView.m
//  MutilPhotos
//
//  Created by sunny_ios on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DPSelectImgView.h"

//图片选择中的对号
@implementation DPMarkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.isSelected = NO ;
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(24.0, 24.0);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if(self.isSelected){
        //填充背景
        CGContextSetRGBFillColor(context, 0.17, 0.42, 1.0, 1.0);
        CGContextFillEllipseInRect(context, self.bounds);
        
        
        // 中间对号
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
        CGContextSetLineWidth(context, 1.5);
        CGContextMoveToPoint(context, 6.0, 12.0);
        CGContextAddLineToPoint(context, 10.0, 16.0);
        CGContextAddLineToPoint(context, 18.0, 8.0);
        CGContextStrokePath(context);
        
    }
    
    //外围圆圈
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextStrokeEllipseInRect(context, CGRectInset(self.bounds, 1.0, 1.0));
    
    
}


@end



//图片选择的覆盖视图
@implementation DPCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // View settings
        //        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES ;
        
        
        // Create a checkmark view
        DPMarkView *checkmarkView = [[DPMarkView alloc] initWithFrame:CGRectMake(self.bounds.size.width - (4.0 + 24.0),  4.0 , 24.0, 24.0)];
        checkmarkView.autoresizingMask = UIViewAutoresizingNone;
        
        checkmarkView.layer.shadowColor = [[UIColor grayColor] CGColor];
        checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
        checkmarkView.layer.shadowOpacity = 0.6;
        checkmarkView.layer.shadowRadius = 2.0;
        
        [self addSubview:checkmarkView];
        self.checkmarkView = checkmarkView;
    }
    return self;
}


@end


@interface DPSelectImgView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) DPCoverView *overlayView;
@property (nonatomic, strong) UIImage *blankImage;

@end

@implementation DPSelectImgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isSelected = NO;
        
        
        self.backgroundColor = [UIColor brownColor];
        // Create a image view
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:imageView];
        self.imageView = imageView;
        
        
        DPCoverView *overlayView = [[DPCoverView alloc] initWithFrame:self.bounds];
        overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:overlayView];
        self.overlayView = overlayView;
        
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    // Show/hide overlay view
    if (isSelected) {
        [self showOverlayView];
    } else {
        [self hideOverlayView];
    }
}


- (void)showOverlayView
{
    //    [self hideOverlayView];
    
    if (!self.overlayView.checkmarkView.isSelected) {
        self.overlayView.checkmarkView.isSelected= YES ;
        [self.overlayView.checkmarkView setNeedsDisplay];
    }
    
}

- (void)hideOverlayView
{
    
    if (self.overlayView.checkmarkView.isSelected) {
        self.overlayView.checkmarkView.isSelected = NO ;
        [self.overlayView.checkmarkView setNeedsDisplay];
    }
}

- (void)setAsset:(ALAsset *)asset
{
    _asset = asset;
    
    // Update view
    CGImageRef thumbnailImageRef = [asset thumbnail];
    
    if (thumbnailImageRef) {
        self.imageView.image = [UIImage imageWithCGImage:thumbnailImageRef];
    } else {
        self.imageView.image = [self blankImage];
    }
    
}

- (UIImage *)blankImage
{
    if (_blankImage == nil) {
        CGSize size = CGSizeMake(100.0, 100.0);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        
        [[UIColor colorWithWhite:(240.0 / 255.0) alpha:1.0] setFill];
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        
        _blankImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    return _blankImage;
}

@end