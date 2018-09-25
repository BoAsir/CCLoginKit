//
//  CCRoleSelectTableViewCell.m
//  CCTribe
//
//  Created by yaya on 2018/7/25.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCRoleSelectTableViewCell.h"
#import "CC_Share.h"
@interface CCRoleSelectTableViewCell()
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UIImageView *selectedImageV;
@property (nonatomic, strong)UIImageView *addImageV;
@property (nonatomic, strong)UILabel *addLab;
@property (nonatomic, strong)UILabel *lineV;

@end

@implementation CCRoleSelectTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        //type1
        _nameLab=[CC_UIAtom initAt:self name:@"CCRoleSelectTableViewCell_label_name" class:[CC_Label class]];
        _selectedImageV=[CC_UIAtom initAt:self name:@"CCRoleSelectTableViewCell_image_selected" class:[UIImageView class]];
        
        //type2
        _addImageV=[CC_UIAtom initAt:self name:@"CCRoleSelectTableViewCell_image_add" class:[UIImageView class]];
        _addLab=[CC_UIAtom initAt:self name:@"CCRoleSelectTableViewCell_label_add" class:[CC_Label class]];
        
        //all
        _lineV=[CC_UIAtom initAt:self name:@"CCRoleSelectTableViewCell_view_line" class:[CC_View class]];
    }
    return self;
}

- (void)loadData:(NSString *)str index:(NSUInteger)index selectedIndex:(NSUInteger)selectedIndex{
//    if (type == RoleSelectViewTypeNormal) {
//        _nameLab.hidden=NO;
//        _selectedImageV.hidden=NO;
//        _addImageV.hidden=YES;
//        _addLab.hidden=YES;
//    }else{
//        _nameLab.hidden=YES;
//        _selectedImageV.hidden=YES;
//        _addImageV.hidden=NO;
//        _addLab.hidden=NO;
//    }
    _nameLab.hidden=NO;
    _addImageV.hidden=YES;
    _addLab.hidden=YES;
    _nameLab.text=str;
    if (selectedIndex==index) {
        _selectedImageV.hidden=NO;
    }else{
        _selectedImageV.hidden=YES;
    }
}

@end
