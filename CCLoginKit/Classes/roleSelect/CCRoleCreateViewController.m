//
//  CCRoleCreateViewController.m
//  CCTribe
//
//  Created by gwh on 2018/7/30.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCRoleCreateViewController.h"
#import "CCRoleRequest.h"
#import "CC_NoticeView.h"
#import "MaskProgressHUD.h"
#import "CCLoginConfig.h"
#import "CC_Share.h"
#import "UserStateManager.h"
@interface CCRoleCreateViewController (){
    
}
@property(nonatomic,retain) CCInfoTextTF *nickNameTF;
@property(nonatomic,retain) UIView *displayV;
@property(nonatomic,retain) CC_Button *defaultBt;

@end

@implementation CCRoleCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUserDefinedNavigationBar];
    [self setUdNavBarTitle:@"创建新角色"];
    [self creatUI];
}

- (void)creatUI{
    _displayV=[self setUdDisplayView];
    //昵称
    _nickNameTF = [[CCInfoTextTF alloc] initWithFrame:CGRectMake(0, 0, [ccui getW], [ccui getRH:50])];
    [_nickNameTF setupWithIcon:@"kk_role_create" placeholder:@"请输入昵称"];
    [_nickNameTF hiddenSeparateLine];
    _nickNameTF.inputTextField.font = [ccui getRFS:14];
    _nickNameTF.backgroundColor = UIColorFromRGB(0xffffff);
    [_displayV addSubview:_nickNameTF];
    _nickNameTF.cas_styleClass=@"CCRoleCreateViewController_view_input";
    
    _defaultBt=[CC_UIAtom initAt:_displayV name:@"CCRoleCreateViewController_bt_default" class:[CC_Button class]];
    [_defaultBt setBackgroundImage:[UIImage imageNamed:@"kk_regiest_agree_protocol" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    _defaultBt.selected=YES;
    
    [CC_UIAtom initAt:_displayV name:@"CCRoleCreateViewController_label_default" class:[CC_Label class]];
    
    CC_Button *defaultTapBt=[CC_UIAtom initAt:_displayV name:@"CCRoleCreateViewController_bt_tap" class:[CC_Button class]];
    WS(weakSelf);
    [defaultTapBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        weakSelf.defaultBt.selected=!weakSelf.defaultBt.selected;
    }];
    
    CC_Button *loginBt=[CC_UIAtom initAt:_displayV name:@"CCRoleCreateViewController_bt_login" class:[CC_Button class]];
    [CC_CodeClass setBoundsWithRadius:20 view:loginBt];
    [loginBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        [self requestCreate];
    }];
}

- (void)requestCreate{
    NSString *textStr=_nickNameTF.inputTextField.text;
    if (textStr.length<=0) {
        [CC_NoticeView showError:@"请输入昵称"];
        return;
    }
    if (textStr.length<2) {
        [CC_NoticeView showError:@"不足2个字"];
        return;
    }
    if (textStr.length>12) {
        [CC_NoticeView showError:@"超出12字"];
        return;
    }
    {
        NSString * regex = @"^[A-Za-z0-9]{2,12}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:textStr];
        if (isMatch==0) {
            
            {
                NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                BOOL isMatch = [pred evaluateWithObject:textStr];
                if (isMatch==0) {
                    [CC_NoticeView showError:@"只能包括中文字、英文字母、数字和下划线"];
                    return;
                }
            }
        }
    }
    
    [_nickNameTF.inputTextField resignFirstResponder];
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:@"USER_CREATE" forKey:@"service"];
    [para setObject:textStr forKey:@"loginName"];
    MaskProgressHUD *HUD = [MaskProgressHUD hudStartAnimatingAndAddToView:self.view];
    WS(weakSelf);
    [[UserStateManager shareInstance].authTask post:[CCLoginConfig loginHeadUrl] params:para model:nil finishCallbackBlock:^(NSString *error, ResModel *resmodel) {

        [HUD stop];
        if (error) {
            [CC_NoticeView showError:error];
        }else{
                if (weakSelf.type==CreateEnterLogin) {
                    [CCRoleRequest requestLoginSelectedLoginUserId:resmodel.resultDic[@"response"][@"createUserId"] resetDefaultUser:weakSelf.defaultBt.selected controller:weakSelf type:LoginTypeCreate];
                }else if (weakSelf.type==CreateEnterSwitch){
                    [CCRoleRequest requestLoginSelectedLoginUserId:resmodel.resultDic[@"response"][@"createUserId"] resetDefaultUser:weakSelf.defaultBt.selected controller:weakSelf type:LoginTypeSwitch];
                }
        }
    }];
}

- (void)requestLogin{
    
}

@end
