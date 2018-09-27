//
//  DPTitleTableViewCell.m
//  JCZJ
//
//  Created by sunny_ios on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DPTitleTableViewCell.h"
#import "Masonry.h"

@implementation DPTitleTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.lineLab];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView).offset(18);
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.width.and.height.mas_equalTo(38);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.iconView.mas_right).offset(10);
            make.right.equalTo(self.contentView);
        }];
        
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-20);
            make.width.and.height.mas_equalTo(25);
        }];
        
        [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.iconView.mas_bottom).offset(6);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

-(UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
//        _iconView.backgroundColor = [UIColor greenColor];
    }
    
    return _iconView;
}
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.backgroundColor = [UIColor cyanColor];
        _titleLabel.textColor = [UIColor blackColor];
    }
    
    return _titleLabel;
}

-(UIButton *)selectBtn{
    if (_selectBtn == nil) {
        _selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"选择图片_下拉_勾" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
//        _selectBtn.backgroundColor = [UIColor orangeColor];
    }
    return _selectBtn;
}
-(UILabel *)lineLab{
    if (_lineLab == nil) {
        _lineLab = [[UILabel alloc] init];
        _lineLab.backgroundColor = [UIColor colorWithRed:202 / 255.0 green:203 / 255.0 blue:204 / 255.0 alpha:1];
    }
    return _lineLab;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
