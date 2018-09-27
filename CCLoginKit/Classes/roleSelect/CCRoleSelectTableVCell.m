//
//  CCRoleSelectTableVCell.m
//  CCLoginKit
//
//  Created by 路飞 on 2018/9/27.
//

#import "CCRoleSelectTableVCell.h"
#import "CC_Share.h"
#import "CCMacros.h"

@interface CCRoleSelectTableVCell()
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UIImageView *selectedImageV;
@property (nonatomic, strong)UIImageView *addImageV;
@property (nonatomic, strong)UILabel *addLab;
@property (nonatomic, strong)UIView *lineV;

@end
@implementation CCRoleSelectTableVCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        //type1
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake([ccui getRH:15], [ccui getRH:5], SCREEN_WIDTH-[ccui getRH:30], [ccui getRH:45])];
        _nameLab.textColor = UIColorFromHexStr(@"666666");
        _nameLab.font = [ccui getRFS:16];
        [self addSubview:_nameLab];
        
        _selectedImageV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[ccui getRH:35], [ccui getRH:15], [ccui getRH:20], [ccui getRH:20])];
        _selectedImageV.image = [UIImage imageNamed:@"kk_role_check" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        [self addSubview:_selectedImageV];
        
        //type2
        _addImageV = [[UIImageView alloc]initWithFrame:CGRectMake([ccui getRH:20], [ccui getRH:20], [ccui getRH:15], [ccui getRH:15])];
        _addImageV.image = [UIImage imageNamed:@"kk_role_add" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        [self addSubview:_addImageV];
        _addLab = [[UILabel alloc]initWithFrame:CGRectMake([ccui getRH:10], [ccui getRH:10], [ccui getRH:300], [ccui getRH:35])];
        _addLab.textColor = UIColorFromHexStr(@"2A6FE0");
        _addLab.font = [ccui getRFS:14];
        _addLab.text = @"创建新角色";
        [self addSubview:_addLab];
        
        //all
        _lineV = [[UIView alloc]initWithFrame:CGRectMake([ccui getRH:15], _nameLab.bottom, SCREEN_WIDTH-[ccui getRH:15], 1)];
        _lineV.backgroundColor = UIColorFromHexStr(@"ECECEC");
        [self addSubview:_lineV];
    }
    return self;
}

- (void)loadData:(NSString *)str index:(NSUInteger)index selectedIndex:(NSUInteger)selectedIndex{
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
