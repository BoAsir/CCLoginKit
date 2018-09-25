//
//  CCInfoTextTF.m
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/13.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCInfoTextTF.h"
#import "CCMacros.h"
#import "CC_UIViewExt.h"
#import "CC_UIHelper.h"
#import "HHObjectCheck.h"
CGFloat const CCInfoTextTF_left_space = 5;

@implementation CCInfoTextTF


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        self.backgroundColor = UIColorFromRGB(0xffffff);
        _iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(CCInfoTextTF_left_space, 0 , [ccui getRH:20], [ccui getRH:20])];
        _iconImg.top = (frame.size.height - _iconImg.height)  /2;
        
        [self addSubview:_iconImg];
        
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(_iconImg.right + CCInfoTextTF_left_space, _iconImg.top, width - CGRectGetMaxX(_iconImg.frame) - CCInfoTextTF_left_space, _iconImg.height)];
        _inputTextField.textColor = [UIColor whiteColor];
        _inputTextField.font = [UIFont systemFontOfSize:13];
        _inputTextField.backgroundColor = [UIColor clearColor];
        _inputTextField.textColor = [UIColor blackColor];
        [self addSubview:_inputTextField];
        
        UITapGestureRecognizer* rg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
        [self addGestureRecognizer:rg];
        
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(10, height - 2, width - 20, 1)];
        line.backgroundColor = UIColorFromRGB(0xe3e0e0);
        _separateLine = line;
        [self addSubview:_separateLine];
    }
    return self;
}

-(NSString *)text
{
    return _inputTextField.text;
}

-(void)setText:(NSString *)text
{
    _inputTextField.text = text;
}

-(void)setRightView:(UIView *)rightView
{
    rightView.right = self.width - CCInfoTextTF_left_space;
    rightView.top = (self.height - rightView.height)/2;
    [self addSubview:rightView];
    _inputTextField.width = CGRectGetMinX(rightView.frame) - 5 - CGRectGetMinX(_inputTextField.frame);
    
}


-(void)hiddenSeparateLine
{
    self.separateLine.hidden = YES;
}

-(void)setupWithIcon:(NSString *)iconName placeholder:(NSString *)holderString
{
    if (![HHObjectCheck isEmpty:iconName]) {
        self.iconImg.image = [UIImage imageNamed:iconName];
    }
    self.inputTextField.placeholder = holderString;
}


- (BOOL)resignFirstResponder {
    [_inputTextField resignFirstResponder];
    return [super resignFirstResponder];
}
-(BOOL)becomeFirstResponder
{
    [_inputTextField becomeFirstResponder];
    return [super becomeFirstResponder];
}
- (void)onTap {
    [_inputTextField becomeFirstResponder];
}

@end
