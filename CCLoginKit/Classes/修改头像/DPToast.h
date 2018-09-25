//
//  DPToast.h
//  JCZJ
//
//  Created by sunny_ios on 16/1/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPToast : UIView

@property (nonatomic, strong, readonly) UILabel *textLabel;

+ (instancetype)sharedToast;
+ (instancetype)makeText:(NSString *)text;
- (void)dismiss;
- (void)show;
- (void)showWithOffset:(CGFloat) offsetY;

@end
