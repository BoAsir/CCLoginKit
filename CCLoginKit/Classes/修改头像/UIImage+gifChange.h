//
//  UIImage+gifChange.h
//  KKTribe
//
//  Created by 路飞  on 2018/7/12.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (gifChange)

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
