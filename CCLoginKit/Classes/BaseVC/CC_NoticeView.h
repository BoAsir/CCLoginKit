//
//  GNoticeView.h
//  JCZJ
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_NoticeView : UIView{
    NSString *noticeString;
}

@property (nonatomic, copy) NSString *noticeString;

+(void)showErrorNetworkDisable;

+ (void)showError:(NSString *)errorStr;
+ (void)showError:(NSString *)errorStr atView:(UIView *)view;


@end
