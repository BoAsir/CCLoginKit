//
//  DPNavigationTitleButton.m
//  JCZJ
//
//  Created by sunny_ios on 15/12/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DPNavigationTitleButton.h"

@interface DPNavigationTitleButton ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowView;


@end

@implementation DPNavigationTitleButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.arrowView];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self).offset(-6);
        }];
        [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@15);
            make.height.equalTo(@15);
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLabel.mas_right).offset(2);
        }];
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.arrowView.highlighted = selected ;
}


#pragma mark - getter

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

- (UIImageView *)arrowView {
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] init];
        _arrowView.image = [UIImage imageNamed:@"购彩记录上拉"] ;
        _arrowView.highlightedImage = [UIImage imageNamed:@"购彩记录下拉"] ;
     }
    return _arrowView;
}

- (NSString *)titleText {
    return self.titleLabel.text;
}

- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}

- (UIColor *)titleColor {
    return self.titleLabel.textColor;
}

@end
