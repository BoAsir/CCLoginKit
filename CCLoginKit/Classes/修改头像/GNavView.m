//
//  GNavView.m
//  JCZJ
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GNavView.h"

@implementation GNavView
@synthesize titleString,titleLabel;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIView *navBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAV_BAR_HEIGHT
                                                               )];
    navBarView.backgroundColor=RGB(246, 63, 63);
    [self addSubview:navBarView];
    
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-150, STATUS_BAR_HEIGHT, 300, 44)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [navBarView addSubview:titleLabel];
    titleLabel.text=titleString;
}

@end
