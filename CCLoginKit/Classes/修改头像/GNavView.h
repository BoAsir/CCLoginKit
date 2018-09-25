//
//  GNavView.h
//  JCZJ
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNavView : UIView{
    NSString *titleString;
    UILabel *titleLabel;
}

@property(nonatomic,retain) NSString *titleString;
@property(nonatomic,retain) UILabel *titleLabel;

@end
