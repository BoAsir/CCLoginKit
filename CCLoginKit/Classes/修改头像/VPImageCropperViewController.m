//
//  VPImageCropperViewController.m
//  VPolor
//
//  Created by Vinson.D.Warm on 12/30/13.
//  Copyright (c) 2013 Huang Vinson. All rights reserved.
//
#import "VPImageCropperViewController.h"
#import "GNavView.h"
#import "CCMacros.h"
#define SCALE_FRAME_Y 100.0f
#define BOUNDCE_DURATION 0.3f

@interface VPImageCropperViewController ()

@property (nonatomic, retain) UIImage *originalImage;
@property (nonatomic, retain) UIImage *editedImage;

@property (nonatomic, retain) UIImageView *showImgView;
@property (nonatomic, retain) UIView *overCoverView;
@property (nonatomic, retain) UIView *circleView;

@property (nonatomic, assign) CGRect oldFrame;
@property (nonatomic, assign) CGRect largeFrame;

@property (nonatomic, assign) CGFloat limitMax;
@property (nonatomic, assign) BOOL isRectangles;

@property (nonatomic, assign) CGRect latestFrame;
@property (nonatomic, strong) GNavView *nav;//导航栏
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *backButton;
@end

@implementation VPImageCropperViewController

- (void)dealloc {
    self.originalImage = nil;
    self.showImgView = nil;
    self.editedImage = nil;
    self.overCoverView = nil;
    self.circleView = nil;
}

- (id)initWithImage:(UIImage *)originalImage circleFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio {
    
    return [self initWithImage:originalImage circleFrame:cropFrame limitScaleRatio:limitRatio rectangles:NO];
}

- (id)initWithImage:(UIImage *)originalImage circleFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio rectangles:(BOOL)isRectangles
{
    return [self initWithImage:originalImage circleFrame:cropFrame limitScaleRatio:limitRatio rectangles:isRectangles rectangleSize:CGSizeZero];
}

- (id)initWithImage:(UIImage *)originalImage circleFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio rectangles:(BOOL)isRectangles rectangleSize:(CGSize)rectangleSize {
    
    self = [super init];
    
    if (self) {
        
        //1.默认正方形尺寸
        CGFloat h = SCREEN_WIDTH - 10;
        CGFloat w = SCREEN_WIDTH - 10;
        if (isRectangles) {
            h = 190;//2.矩形默认高度
            if (rectangleSize.height > 0) {//3.矩形设定size
                h = (rectangleSize.height*w)/rectangleSize.width;
            }
        }
        self.isRectangles = isRectangles;
        self.circleFrame =CGRectMake(5, 164, w, h);
        self.limitMax = limitRatio;
        self.originalImage = originalImage;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor] ;
    [self initView];
    
    self.nav=[[GNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.nav.titleString=@"裁切";
    [self.view addSubview:self.nav];
    
    self.backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame=CGRectMake(0, STATUS_BAR_HEIGHT, 44, 44);
    self.backButton.imageEdgeInsets = UIEdgeInsetsMake ( 11 , 11 , 11 , 11);
    [self.backButton setImage:[UIImage imageNamed:@"顶部-返回"] forState:UIControlStateNormal];
    [self.view addSubview:self.backButton];
    [self.backButton addTarget:self action:@selector(topBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame=CGRectMake(SCREEN_WIDTH-90, STATUS_BAR_HEIGHT, 100, 44);
    //    self.rightButton.imageEdgeInsets = UIEdgeInsetsMake ( 10 , 0 , -15 , -20);
    [self.rightButton setTitle:@"确认" forState:(UIControlStateNormal)];
    [self.view addSubview:self.rightButton];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [self.rightButton addTarget:self action:@selector(barBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - UI
- (void)initView {
    self.showImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.showImgView setImage:self.originalImage];
    [self.showImgView setUserInteractionEnabled:YES];
    [self.showImgView setMultipleTouchEnabled:YES];
    
    // scale to fit the screen
    CGFloat oriWidth = self.circleFrame.size.width;
    CGFloat oriHeight = self.originalImage.size.height * (oriWidth / self.originalImage.size.width);
    CGFloat oriX = self.circleFrame.origin.x + (self.circleFrame.size.width - oriWidth) / 2;
    CGFloat oriY = self.circleFrame.origin.y + (self.circleFrame.size.height - oriHeight) / 2;
    self.oldFrame = CGRectMake(oriX, oriY, oriWidth, oriHeight);
    self.latestFrame = self.oldFrame;
    self.showImgView.frame = self.oldFrame;
    
    self.largeFrame = CGRectMake(0, 0, self.limitMax * self.oldFrame.size.width, self.limitMax * self.oldFrame.size.height);
    //最小图
    
    
    
    [self addGestureRecognizers];
    [self.view addSubview:self.showImgView];//self.view.bounds]
    
    //半透明背景
    self.overCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.overCoverView.alpha = 0.5f;
    self.overCoverView.backgroundColor = [UIColor blackColor];
    self.overCoverView.userInteractionEnabled = NO;
    self.overCoverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.overCoverView];
    
    //圆圈self.circleFrame]
    self.circleView = [[UIView alloc] initWithFrame:self.circleFrame];
    self.circleView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.circleView.layer.borderWidth = 1.0f;
    if (!self.isRectangles) {
        self.circleView.layer.cornerRadius = self.circleFrame.size.width/2.0 ;
    }
    //    self.circleView.layer.cornerRadius = self.circleFrame.size.width/2.0 ;
    self.circleView.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:self.circleView];
    
    [self overlayClipping];
}


-(void)topBackClick:(id)sender{
    //    if (self.finishhandle) {
    //        self.finishhandle( self,nil) ;
    //
    //    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)barBtnClick:(id)sender{
    
    if (self.finishhandle) {
        CGFloat scale = MAX(1, [UIScreen mainScreen].scale);
        UIImage *image;
        if (self.isRectangles) {
            image = [self getRecImage];
        } else {
            image =  [self getSquareImage];
            //        self.finishhandle(self,[[self getSubImage] dp_resizedImageToSize:CGSizeMake(100, 100)]) ;
            image =[image dp_resizedImageToSize:CGSizeMake(40*scale/image.scale, 40*scale/image.scale)];
        }
        //        UIImage *image = [self getSubImage];
        //        self.finishhandle(self,[[self getSubImage] dp_resizedImageToSize:CGSizeMake(100, 100)]) ;
        //        image =[image dp_resizedImageToSize:CGSizeMake(40*scale/image.scale, 40*scale/image.scale)];
        self.finishhandle(self,image);
        
    }
}

#pragma mark - 蒙板mask
- (void)overlayClipping
{
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:self.overCoverView.frame] ;
    
    CGFloat radius = self.isRectangles ? 0 : self.circleView.frame.size.width/2.0;
    [path1 appendPath: [[UIBezierPath bezierPathWithRoundedRect:self.circleView.frame cornerRadius:radius] bezierPathByReversingPath]];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.overCoverView.frame;
    maskLayer.path = path1.CGPath;
    self.overCoverView.layer.mask = maskLayer;
    
}

#pragma mark - 手势
- (void) addGestureRecognizers
{
    // add pinch gesture
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    
    // add pan gesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

// pinch gesture handler
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = self.showImgView;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
    else if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGRect newFrame = self.showImgView.frame;
        newFrame = [self handleScaleOverflow:newFrame];
        newFrame = [self handleBorderOverflow:newFrame];
        [UIView animateWithDuration:BOUNDCE_DURATION animations:^{
            self.showImgView.frame = newFrame;
            self.latestFrame = newFrame;
        }];
    }
}

// pan gesture handler
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = self.showImgView;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        // calculate accelerator
        CGFloat absCenterX = self.circleFrame.origin.x + self.circleFrame.size.width / 2;
        CGFloat absCenterY = self.circleFrame.origin.y + self.circleFrame.size.height / 2;
        CGFloat scaleRatio = self.showImgView.frame.size.width / self.circleFrame.size.width;
        CGFloat acceleratorX = 1 - ABS(absCenterX - view.center.x) / (scaleRatio * absCenterX);
        CGFloat acceleratorY = 1 - ABS(absCenterY - view.center.y) / (scaleRatio * absCenterY);
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x * acceleratorX, view.center.y + translation.y * acceleratorY}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // bounce to original frame
        CGRect newFrame = self.showImgView.frame;
        newFrame = [self handleBorderOverflow:newFrame];
        [UIView animateWithDuration:BOUNDCE_DURATION animations:^{
            self.showImgView.frame = newFrame;
            self.latestFrame = newFrame;
        }];
    }
}

- (CGRect)handleScaleOverflow:(CGRect)newFrame {
    // bounce to original frame
    CGPoint oriCenter = CGPointMake(newFrame.origin.x + newFrame.size.width/2, newFrame.origin.y + newFrame.size.height/2);
    if (newFrame.size.width < self.oldFrame.size.width) {
        newFrame = self.oldFrame;
    }
    
    if (newFrame.size.width > self.largeFrame.size.width) {
        newFrame = self.largeFrame;
    }
    newFrame.origin.x = oriCenter.x - newFrame.size.width/2;
    newFrame.origin.y = oriCenter.y - newFrame.size.height/2;
    return newFrame;
}


- (CGRect)handleBorderOverflow:(CGRect)newFrame {
    // horizontally
    if (newFrame.origin.x > self.circleFrame.origin.x)
        newFrame.origin.x = self.circleFrame.origin.x;
    if (CGRectGetMaxX(newFrame) < self.circleFrame.size.width)
        newFrame.origin.x = self.circleFrame.size.width - newFrame.size.width;
    // vertically
    if (newFrame.origin.y > self.circleFrame.origin.y) newFrame.origin.y = self.circleFrame.origin.y;
    if (CGRectGetMaxY(newFrame) < self.circleFrame.origin.y + self.circleFrame.size.height) {
        newFrame.origin.y = self.circleFrame.origin.y + self.circleFrame.size.height - newFrame.size.height;
    }
    // adapt horizontally rectangle
    if (self.showImgView.frame.size.width > self.showImgView.frame.size.height && newFrame.size.height <= self.circleFrame.size.height) {
        newFrame.origin.y = self.circleFrame.origin.y + (self.circleFrame.size.height - newFrame.size.height) / 2;
    }
    return newFrame;
}

#pragma mark - 图片裁剪
/** 获取正方形图片 */
-(UIImage *)getSquareImage{
    CGRect squareFrame = self.circleFrame;
    CGFloat scaleRatio = self.latestFrame.size.width / self.originalImage.size.width;
    
    CGFloat x = (squareFrame.origin.x - self.latestFrame.origin.x) / scaleRatio;
    CGFloat y = (squareFrame.origin.y - self.latestFrame.origin.y) / scaleRatio;
    CGFloat w = squareFrame.size.width / scaleRatio;
    CGFloat h = squareFrame.size.width / scaleRatio;
    if (self.latestFrame.size.width < self.circleFrame.size.width) {//
        CGFloat newW = self.originalImage.size.width;
        CGFloat newH = newW * (self.circleFrame.size.height / self.circleFrame.size.width);
        x = 0; y = y + (h - newH) / 2;
        w = newH; h = newH;
    }
    if (self.latestFrame.size.height < self.circleFrame.size.height) {
        CGFloat newH = self.originalImage.size.height;
        CGFloat newW = newH * (self.circleFrame.size.width / self.circleFrame.size.height);
        x = x + (w - newW) / 2; y = 0;
        w = newH; h = newH;
    }
    CGRect myImageRect = CGRectMake(x, y, w, h);
    CGImageRef imageRef = self.originalImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage ;
    //    return [self circleImage:smallImage];
}


/** 获取矩形形图片 */
-(UIImage *)getRecImage{
    CGRect squareFrame = self.circleFrame;
    CGFloat scaleRatio = self.latestFrame.size.width / self.originalImage.size.width;
    
    CGFloat x = (squareFrame.origin.x - self.latestFrame.origin.x) / scaleRatio;
    CGFloat y = (squareFrame.origin.y - self.latestFrame.origin.y) / scaleRatio;
    CGFloat w = squareFrame.size.width / scaleRatio;
    CGFloat h = squareFrame.size.height / scaleRatio;
    
    if (self.latestFrame.size.width < self.circleFrame.size.width) {//
//        CGFloat newW = self.originalImage.size.width;
        CGFloat newH = self.originalImage.size.height;
        x = 0; y = y + (h - newH) / 2;
        w = newH; h = newH;
    }
    if (self.latestFrame.size.height < self.circleFrame.size.height) {
        CGFloat newH = self.originalImage.size.height;
        CGFloat newW = newH * (self.circleFrame.size.width / self.circleFrame.size.height);
        x = x + (w - newW) / 2; y = 0;
        w = newH; h = newH;
    }
    CGRect myImageRect = CGRectMake(x, y, w, h);
    CGImageRef imageRef = self.originalImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage ;
    //    return [self circleImage:smallImage];
}

#pragma mark - 图片变成圆形
-(UIImage*) circleImage:(UIImage*) image {
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGRect rect = CGRectMake(0,0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


@end


@implementation UIImage (kCategory)

- (UIImage *)dp_resizedImageToSize:(CGSize)dstSize {
    CGImageRef imgRef = self.CGImage;
    // the below values are regardless of orientation : for UIImages from Camera, width>height (landscape)
    CGSize srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which is dependant on the imageOrientation)!
    
    /* Don't resize if we already meet the required destination size. */
    if (CGSizeEqualToSize(srcSize, dstSize)) {
        return self;
    }
    
    CGFloat scaleRatio = dstSize.width / srcSize.width;
    UIImageOrientation orient = self.imageOrientation;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(srcSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(srcSize.width, srcSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, srcSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    /////////////////////////////////////////////////////////////////////////////
    // The actual resize: draw the image on a new context, applying a transform matrix
    UIGraphicsBeginImageContextWithOptions(dstSize, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (!context) {
        return nil;
    }
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -srcSize.height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -srcSize.height);
    }
    
    CGContextConcatCTM(context, transform);
    
    // we use srcSize (and not dstSize) as the size to specify is in user space (and we use the CTM to apply a scaleRatio)
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, srcSize.width, srcSize.height), imgRef);
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}


@end


