//
//  BBAccountAlertView.m
//  BananaBall
//
//  Created by 万耀辉 on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CCAccountAlertView.h"
#import "CCMacros.h"
#import "Masonry.h"
#import "CC_UIViewExt.h"
@implementation CCAccountAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithTitleString:(NSString *)titleString Second:(NSString *)secondString third:(NSString *)thirdString ButtonContent:(NSString *)buttString
{
    
    self=[super init];
    if (self) {
        
        self.backgroundColor=RGBA(0, 0, 0, .5);
        self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        NSInteger defaultHeight = 141;
        if (titleString.length > 0 && secondString.length > 0) {
            defaultHeight = 181;
        }
        
        self.destView = [[UIView alloc] init];
        self.destView.backgroundColor = [UIColor whiteColor];
        [self.destView.layer setMasksToBounds:YES];
        [self.destView.layer setCornerRadius:8.0];
        [self addSubview:self.destView];
        
        [self.destView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(30);
            make.top.equalTo(self.mas_top).offset(200);
            make.right.equalTo(self.mas_right).offset(-30);
            make.height.mas_equalTo(defaultHeight);
        }];
        
        UIImageView * topImageView = [[UIImageView alloc] init];
        topImageView.image =[UIImage imageNamed:@"打赏未设置密码"];
        [self addSubview:topImageView];
        
        [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH/2-30);
            make.top.equalTo(self.mas_top).offset(170);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(60);
        }];
        
        if (titleString.length > 0 && secondString.length > 0) {
            
            UILabel * titleLabel=[[UILabel alloc] init];
            titleLabel.textColor=RGB(51, 51, 51);
            titleLabel.font=[UIFont systemFontOfSize:14];
            titleLabel.text=titleString;
            [self.destView addSubview:titleLabel];
            
            UILabel * secondLabel=[[UILabel alloc] init];
            secondLabel.textColor=RGB(51, 51, 51);
            secondLabel.font=[UIFont systemFontOfSize:14];
            secondLabel.numberOfLines = 2;
            secondLabel.text=secondString;
            [self.destView addSubview:secondLabel];
            
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.destView.mas_left).offset(15);
                make.right.equalTo(self.destView.mas_right).offset(-15);
                make.top.equalTo(self.destView.mas_top).offset(40);
                make.height.mas_equalTo(25);
            }];
            
            [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.destView.mas_left).offset(15);
                make.right.equalTo(self.destView.mas_right).offset(-15);
                make.top.equalTo(titleLabel.mas_bottom).offset(5);
                make.height.mas_equalTo(40);
            }];
            
        }

        
        if (thirdString.length > 0) {
            
            UILabel * thirdLabel=[[UILabel alloc] init];
            thirdLabel.textColor=RGB(51, 51, 51);
            thirdLabel.font=[UIFont systemFontOfSize:14];
            thirdLabel.text=thirdString;
            [self.destView addSubview:thirdLabel];
            
            
            if (titleString.length <= 0 && secondString.length <= 0) {
                thirdLabel.textAlignment = NSTextAlignmentCenter;
            }
            [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.destView.mas_left).offset(15);
                make.right.equalTo(self.destView.mas_right).offset(-15);
                 make.top.equalTo(self.destView.mas_top).offset(defaultHeight-70);
                if (titleString.length <= 0 && secondString.length <= 0) {
                    make.top.equalTo(self.destView.mas_top).offset(defaultHeight-90);
                }
               
                make.height.mas_equalTo(20);
            }];
        }
        
        
        UIView *lline1 = [[UIView alloc]init];
        lline1.backgroundColor= RGB(220, 220, 220);
        [self.destView addSubview:lline1];
        
        [lline1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.destView.mas_left).offset(15);
            make.right.equalTo(self.destView.mas_right).offset(-15);
            make.top.equalTo(self.destView.mas_top).offset(defaultHeight-45);
            make.height.mas_equalTo(1);
        }];
        
        
        UIButton * confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmButton setTitle:buttString forState:UIControlStateNormal];
        confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [confirmButton setTitleColor:RGB(246, 63, 63) forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(AccountAlertViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.destView addSubview:confirmButton];
        
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.destView.mas_left).offset(15);
            make.right.equalTo(self.destView.mas_right).offset(-15);
            make.top.equalTo(lline1.mas_top).offset(1);
            make.height.mas_equalTo(40);
        }];
        
        
    }

    return self;
}



- (void)AccountAlertViewButtonClick:(UIButton *)button{
//    BBLOG(@"tag=%ld",(long)button.tag);
    
    [self.delegate AccountAlertViewButtonClickPassValue:button AccountAlertView:self];
    [self removeFromSuperview];
}

- (void)dealloc
{
//    self.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)screenOrientationChange
{
    self.destView.frame = CGRectMake(SCREEN_WIDTH/2-150, SCREEN_HEIGHT/2-self.destView.height/2, self.destView.width, self.destView.height);
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
@end
