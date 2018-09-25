//
//  GNoticeView.m
//  JCZJ
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//
#import "CC_NoticeView.h"

@implementation CC_NoticeView
@synthesize noticeString;

+(void)showErrorNetworkDisable
{
    [self showError:@"网络不可用,请检查后重试~"];
}

+ (void)showError:(NSString *)errorStr{
    
    if (errorStr.length<=0) {
        return;
    }
    UILabel *noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8, SCREEN_HEIGHT/2, SCREEN_WIDTH*6/8, [ccui getRH:40])];
    noticeLabel.backgroundColor=RGBA(0, 0, 0, .8);
    noticeLabel.layer.cornerRadius = [ccui getRH:10];
    noticeLabel.layer.masksToBounds = YES;
    noticeLabel.font=[ccui getRFS:12];
    noticeLabel.textColor=[UIColor whiteColor];
    noticeLabel.numberOfLines=0;
    noticeLabel.textAlignment=NSTextAlignmentCenter;
    [[UIApplication sharedApplication].windows.lastObject addSubview:noticeLabel];
    noticeLabel.text=[NSString stringWithFormat:@"%@",errorStr];
    CGRect rect = [errorStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-[ccui getRH:50], CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[ccui getRFS:12]} context:nil];
    if (rect.size.height>[ccui getRH:40]) {
        noticeLabel.size = CGSizeMake(SCREEN_WIDTH-[ccui getRH:12], rect.size.height);
    }else
    {
        noticeLabel.size = CGSizeMake(rect.size.width+[ccui getRH:30], [ccui getRH:40]);
    }
    noticeLabel.center = CGPointMake(SCREEN_WIDTH/2, noticeLabel.center.y);
    
    noticeLabel.alpha=0;
    [UIView animateWithDuration:.5f animations:^{
        noticeLabel.alpha=0.8;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            noticeLabel.alpha=.79;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.5f animations:^{
                noticeLabel.alpha=0;
            } completion:^(BOOL finished) {
                [noticeLabel removeFromSuperview];
            }];
        }];
    }];
}

+ (void)showError:(NSString *)errorStr atView:(UIView *)view{

    if (errorStr.length<=0) {
        return;
    }
    
    UILabel *noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(view.width/8, view.height/2, view.width*6/8, 40)];
    noticeLabel.backgroundColor=RGBA(0, 0, 0, .8);
    noticeLabel.layer.cornerRadius = [ccui getRH:10];
    noticeLabel.layer.masksToBounds = YES;
    noticeLabel.font=[ccui getRFS:12];
    noticeLabel.textColor=[UIColor whiteColor];
    noticeLabel.numberOfLines=0;
    noticeLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:noticeLabel];
    noticeLabel.text=[NSString stringWithFormat:@"%@",errorStr];
    if (errorStr.length*[ccui getRH:12]+[ccui getRH:30] > view.width-[ccui getRH:12]) {
        CGRect rect = [errorStr boundingRectWithSize:CGSizeMake(view.width-[ccui getRH:20], CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[ccui getRFS:12]} context:nil];
        noticeLabel.size = CGSizeMake(view.width-[ccui getRH:20], rect.size.height);
    }else
    {
        noticeLabel.size = CGSizeMake(errorStr.length*[ccui getRH:12]+[ccui getRH:30], [ccui getRH:40]);
    }
    noticeLabel.center = CGPointMake(view.width/2, noticeLabel.center.y);

    
    noticeLabel.alpha=0;
    [UIView animateWithDuration:.5f animations:^{
        noticeLabel.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            noticeLabel.alpha=.99;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.5f animations:^{
                noticeLabel.alpha=0;
            } completion:^(BOOL finished) {
                [noticeLabel removeFromSuperview];
            }];
        }];
    }];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UILabel *noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    noticeLabel.backgroundColor=RGBA(0, 0, 0, .8);
    noticeLabel.font=[UIFont systemFontOfSize:12];
    noticeLabel.textColor=[UIColor whiteColor];
    noticeLabel.numberOfLines=0;
    noticeLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:noticeLabel];
    noticeLabel.text=noticeString;
    
    [noticeLabel.layer setMasksToBounds:YES];
    [noticeLabel.layer setCornerRadius:2]; //设置矩形四个圆角半径
    
    noticeLabel.alpha=0;
    [UIView animateWithDuration:.5f animations:^{
        noticeLabel.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            noticeLabel.alpha=.99;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.5f animations:^{
                noticeLabel.alpha=0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }];
}


@end
