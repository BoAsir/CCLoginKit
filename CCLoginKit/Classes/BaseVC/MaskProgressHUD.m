//
//  MaskProgressHUD.m
//  HHSLive
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MaskProgressHUD.h"
@interface MaskProgressHUD()
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UILabel *titleLab;
@end
@implementation MaskProgressHUD

+(instancetype)hudStartAnimatingAndAddToView:(UIView *)view
{
    MaskProgressHUD *progressView = [MaskProgressHUD defaultMaskProgressHUD];
    
    [progressView setCenter:view.center];
    [view addSubview:progressView];
    
    return progressView;
}


+(instancetype)defaultMaskProgressHUD
{
    MaskProgressHUD *progressView = [[MaskProgressHUD alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ccui getRH:100.0f], [ccui getRH:100.0f])];
    [progressView setBackgroundColor:[UIColor blackColor]];
    progressView.backgroundColor = RGBA(0, 0, 0, .5);
    progressView.layer.cornerRadius = [ccui getRH:15];
    progressView.layer.masksToBounds = YES;
    
    progressView.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ccui getRH:100.0f], [ccui getRH:100.0f])];
    [progressView.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [progressView.activityIndicator startAnimating];
    [progressView addSubview:progressView.activityIndicator];
    
    progressView.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0, 0)];
    progressView.titleLab.textAlignment = NSTextAlignmentCenter;
    progressView.titleLab.font = [UIFont systemFontOfSize:13];
    progressView.titleLab.textColor = [UIColor whiteColor];
    [progressView addSubview:progressView.titleLab];

    return progressView;
}


-(void)setTitleStr:(NSString *)titleStr
{
    if (titleStr) {
        self.height = [ccui getRH:110];
        
        self.titleLab.frame = CGRectMake(0, self.activityIndicator.bottom-[ccui getRH:25], self.width, [ccui getRH:20]);
        self.titleLab.text = titleStr;
    }
}

-(void)timerStart
{

}
-(void)stop
{
    [self.activityIndicator stopAnimating];
    [self removeFromSuperview];
}

-(void)dealloc
{
    
}
@end
