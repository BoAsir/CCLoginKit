//
//  InsideLoadingVIew.h
//  HHSLive
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsideLoadingVIew : UIView
@property (nonatomic,strong) UIImageView *gifImageView;
+(instancetype)loadingStartAnimatingAndAddToView:(UIView *)view;
-(void)stop;
@end
