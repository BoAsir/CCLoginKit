//
//  InsideLoadingVIew.m
//  HHSLive
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "InsideLoadingVIew.h"
#import "UIImage+gifChange.h"

@implementation InsideLoadingVIew
+(instancetype)loadingStartAnimatingAndAddToView:(UIView *)view
{
    InsideLoadingVIew *progressView = [[InsideLoadingVIew alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ccui getRH:133.0f], [ccui getRH:100])];
    progressView.layer.cornerRadius = [ccui getRH:15];
    progressView.layer.masksToBounds = YES;
    [progressView setCenter:view.center];
    [view addSubview:progressView];
    
    progressView.gifImageView = [[UIImageView alloc] initWithFrame:progressView.bounds];
    progressView.gifImageView.image = [UIImage sd_animatedGIFNamed:@"页面加载"];
    [progressView addSubview:progressView.gifImageView];

    
    return progressView;
}
-(void)stop
{
    [self.gifImageView stopAnimating];
    [self removeFromSuperview];
}
@end
