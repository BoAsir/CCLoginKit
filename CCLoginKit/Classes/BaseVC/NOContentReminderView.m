//
//  NOContentReminderView.m
//  视频横幅test
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NoContentReminderView.h"
#import "CC_UIHelper.h"
#import "CCMacros.h"
@interface NoContentReminderView()
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,assign) CGFloat imageTopY;
@property(nonatomic,strong)UILabel *textLab;
@property (nonatomic,strong) NSAttributedString *attributeString;
@end

@implementation NoContentReminderView
+(instancetype)showReminderViewToView:(UIView*)toView imageTopY:(CGFloat )imageTopY image:(UIImage *)image remindWords:(NSAttributedString *)attributeString
{
    NoContentReminderView *reminderView = [[NoContentReminderView alloc] initWithFrame:toView.bounds];
    reminderView.image = image;
    reminderView.imageTopY = imageTopY;
    [reminderView addViews];
    [reminderView updateRemindWords:attributeString numberOfLines:0];
    reminderView.userInteractionEnabled = NO;
    [toView addSubview:reminderView];
    return reminderView;
}

-(instancetype)initWithFrame:(CGRect)frame imageTopY:(CGFloat )imageTopY image:(UIImage *)image remindWords:(NSAttributedString *)attributeString
{
    if (self = [super initWithFrame:frame]) {
        self.image = image;
        self.imageTopY = imageTopY;
        [self addViews];
        [self updateRemindWords:attributeString numberOfLines:0];
        self.userInteractionEnabled = NO;
    }
    
    return self;
}




-(void)addViews
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, _imageTopY, [ccui getRH:584.0/3], [ccui getRH:417.0/3])];
    imageV.image = _image;
    imageV.contentMode = UIViewContentModeScaleAspectFit ;
    imageV.center = CGPointMake(self.center.x, imageV.center.y);
    [self addSubview:imageV];
    self.textLab = [[UILabel alloc] initWithFrame:CGRectMake(0,imageV.bottom,self.width,0)];
    self.textLab.numberOfLines = 0;
    self.textLab.textColor = RGB(153, 153, 153);
    self.textLab.font = [UIFont systemFontOfSize:14];
   [self addSubview:self.textLab];
}

#pragma mark -
-(instancetype)initWithFrame:(CGRect)frame withNoContentStyle:(NoContentStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        if (style == NoContentReminderConnectError) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64+[ccui getRH:40], [ccui getRH:584.0/3], [ccui getRH:417.0/3])];
            imageV.image = [UIImage imageNamed:@"网络连接错误"];
            imageV.center = CGPointMake(self.center.x, imageV.center.y);
            [self addSubview:imageV];
            
            UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(0,imageV.bottom,self.width,0)];
            textLab.numberOfLines = 0;
            textLab.textAlignment = NSTextAlignmentCenter;
            textLab.text = @"哎呀，页面飞走了\n我们正在努力找回中，请稍后重试";
            textLab.textColor = RGB(153, 153, 153);
            textLab.font = [ccui getRFS:13];
            [self addSubview:textLab];
            [textLab sizeToFit];
            textLab.center = CGPointMake(self.width/2, textLab.center.y);
        }
    }
    return self;
}




-(void)updateRemindWords:(NSAttributedString *)attributeString numberOfLines:(NSInteger)numberOfLines
{
    self.textLab.numberOfLines = numberOfLines;
    self.attributeString = attributeString;
    NSMutableAttributedString *muAttri = [[NSMutableAttributedString alloc] initWithAttributedString:_attributeString];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    [muAttri addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, muAttri.length)];
    
    self.textLab.attributedText = muAttri;
    [self.textLab sizeToFit];
    self.textLab.center = CGPointMake(self.width/2, self.textLab.center.y);
}

@end
