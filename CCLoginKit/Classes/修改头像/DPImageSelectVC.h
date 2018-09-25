//
//  DPImageSelectVC.h
//  MutilPhotos
//
//  Created by sunny_ios on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol SelectPicFinishDelegate <NSObject>

- (void)setUpDetailFinishAddedImageView:(NSArray *)images;

@end
/**
 *  图片选择完成
 *
 *  @param isCanceled 是否是取消
 *  @param isCamera   是否是相机
 *  @param assets     选中的数据
 */
typedef void (^UMImagePickerFinishHandle)(BOOL isCanceled,BOOL isCamera,NSArray *assets);


/**
 *  图片选择页面
 */
@interface DPImageSelectVC : UIViewController

@property(nonatomic,strong) NSArray *assertsGroupArray ;
/**
 *  最大能选择几个
 */
@property (nonatomic, assign) NSInteger maxCount ;
/**
 *  图片选择完成
 */
@property (nonatomic, copy) UMImagePickerFinishHandle selectFinishHandle;

@property (nonatomic, assign) BOOL isFromPersonal;
//是否矩形
@property (nonatomic, assign) BOOL isRectangles;

//矩形自定义尺寸 (大卫加的)
@property (nonatomic,assign) CGSize rectangleSize;

@property (nonatomic, weak) id <SelectPicFinishDelegate> delegate;

@end
