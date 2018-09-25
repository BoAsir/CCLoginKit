//
//  MaskProgressHUD.h
//  HHSLive
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaskProgressHUD : UIView

@property (nonatomic,strong) NSString *titleStr;

+(instancetype)hudStartAnimatingAndAddToView:(UIView *)view;
+(instancetype)defaultMaskProgressHUD;
-(void)stop;
@end
