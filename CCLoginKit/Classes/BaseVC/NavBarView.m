//
//  NavBarView.m
//  HHSLive
//
//  Created by apple on 17/3/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NavBarView.h"
#import "CCMacros.h"

@implementation NavBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {

        self.frame=CGRectMake(0, 0, SCREEN_WIDTH,STATUS_AND_NAV_BAR_HEIGHT);
        _navBarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _navBarImageView.image = [UIImage imageNamed:@"NavBar64"];

        [self addSubview:_navBarImageView];
        _navBarImageView.hidden = YES;

        UIImage *backImage=UIIMAGE(@"white_navBack_arrow_icon");
        self.backgroundColor = RGB(246, 63, 63);
        _backButton=[CC_Button buttonWithType:UIButtonTypeCustom];

        [_backButton setImage:backImage forState:UIControlStateNormal];

        _backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _backButton.frame=CGRectMake(10, STATUS_BAR_HEIGHT+10, backImage.size.width*24/backImage.size.height, 24);
        [self addSubview:_backButton];


        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-150, STATUS_BAR_HEIGHT, 300, 44)];
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.font=[UIFont systemFontOfSize:19];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_titleLabel];

    }
    return self;
}

-(void)setNavBarBackgroundImage:(UIImage *)navBarBackgroundImage
{
    _navBarImageView.image = navBarBackgroundImage;
    _navBarImageView.hidden = NO;
}

-(void)setNavBarBackGroundColor:(UIColor *)color
{
    _navBarImageView.hidden = YES;
    self.backgroundColor = color;
}

-(void)setNavBarTitleColor:(UIColor *)color
{
    [_titleLabel setTextColor:color];
}
-(void)setNavBarTitleFont:(UIFont *)font
{
    [_titleLabel setFont:font] ;
}


-(void)hiddenBackButton
{
    self.backButton.hidden = YES;
}
-(void)dealloc
{

}
@end

