//
//  CCRoleSelectTableVCell.h
//  CCLoginKit
//
//  Created by 路飞 on 2018/9/27.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RoleSelectViewType)
{
    RoleSelectViewTypeNormal = 1,//显示角色名称
    RoleSelectViewTypeCreate = 2,//创建新角色
};

NS_ASSUME_NONNULL_BEGIN

@interface CCRoleSelectTableVCell : UITableViewCell

- (void)loadData:(NSString *)str index:(NSUInteger)index selectedIndex:(NSUInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END
