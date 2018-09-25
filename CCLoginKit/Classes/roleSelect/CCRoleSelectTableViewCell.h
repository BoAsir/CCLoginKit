//
//  CCRoleSelectTableViewCell.h
//  CCTribe
//
//  Created by yaya on 2018/7/25.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RoleSelectViewType)
{
    RoleSelectViewTypeNormal = 1,//显示角色名称
    RoleSelectViewTypeCreate = 2,//创建新角色
};

@interface CCRoleSelectTableViewCell : UITableViewCell

- (void)loadData:(NSString *)str index:(NSUInteger)index selectedIndex:(NSUInteger)selectedIndex;

@end
