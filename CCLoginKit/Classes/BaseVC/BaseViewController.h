//
//  BaseViewController.h
//  HHSLive
//
//  Created by mac on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoContentReminderView.h"
#import "InsideLoadingVIew.h"
#import "UIViewController+Base.h"

@interface BaseViewController : UIViewController

typedef NS_ENUM(NSInteger,ContentType)
{
    TALK, //说说
    COLOUMN, //专栏
    VIDEO, //视频
    COMMENT, //评论
    BONUS, //红包
    ROCKET, //火箭
    DECREE, //圣旨
    LOTTERY, //幸运抽奖
    GIFT //礼物
};

@property (nonatomic,strong) NoContentReminderView *connectErrorReminder;///<网络错误提示
@property (nonatomic,strong) InsideLoadingVIew *insideLoadingView;///<页面内加载中

@property (nonatomic,assign) ContentType contentType; //内容类型

@property (nonatomic,strong) NSString *fromStr; 

@property (nonatomic,strong) NSString *toStr;

@property (nonatomic,strong) NSString *selfViewDBName;

//- (UIStatusBarStyle)preferredStatusBarStyle;
-(UIStatusBarStyle)getStatusBarStyle;

-(void)pressBackButton;
@end
