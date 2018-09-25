//
//  NOContentReminderView.h
//  视频横幅test
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NoContentStyle) {
    NoContentReminderConnectError
};
@interface NoContentReminderView : UIView


/**
 *@brief 方式一:通过传递内容创建
 *@param toView 将视图放在某个视图上面
 *@param imageTopY 图片与这个视图顶端的距离
 *@param image 图片
 *@param attributeString 图片下方的文字
 */
+(instancetype)showReminderViewToView:(UIView*)toView imageTopY:(CGFloat )imageTopY image:(UIImage *)image remindWords:(NSAttributedString *)attributeString;


/**
 *@brief 方式二:通过枚举创建
 *@param style 暂无类型
 *@return 一个实例
 */
-(instancetype)initWithFrame:(CGRect)frame withNoContentStyle:(NoContentStyle)style;


-(instancetype)initWithFrame:(CGRect)frame imageTopY:(CGFloat )imageTopY image:(UIImage *)image remindWords:(NSAttributedString *)attributeString;
/**
 修改图片下方的文字

 @param attributeString 文字
 */
-(void)updateRemindWords:(NSAttributedString *)attributeString numberOfLines:(NSInteger)numberOfLines;

@end
