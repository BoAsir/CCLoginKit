//
//  CCModifyPwdVC.m
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/16.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCModifyPwdVC.h"
#import "CCInfoTextTF.h"
#import "CCPhoneNOAndVerifyCodeVC.h"
#import "CC_Share.h"
#import "UserStateManager.h"
#import "MaskProgressHUD.h"
#import "CCLoginConfig.h"
#import "CC_NoticeView.h"
CGFloat CCModifyPwdVC_left_space = 20;

@interface CCModifyPwdVC ()
{
    CCInfoTextTF *_oldPwdTF;
    CCInfoTextTF *_newPwdTF;
    CCInfoTextTF *_repeatPwdTF;
    UIButton *_confirmButton;
    
}

@property(nonatomic,assign)CCModifyPwdVCType VCType;

@end

@implementation CCModifyPwdVC

-(instancetype)initWithType:(CCModifyPwdVCType)VCType
{
    if (self = [super init]) {
        _VCType = VCType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUserDefinedNavigationBar];
    NSArray *titleArray = @[@"修改登录密码",@"修改支付密码"];
    [self setUdNavBarTitle:titleArray[_VCType]];
    [self creatUI];
}

-(void)creatUI{
    CGFloat textFieldHeight = 95/2;
    NSArray *newPwdPlaceHolders = @[@"请输入新密码,6-20位区分大小写",@"请输入6位数字密码"];
    
    self.view.backgroundColor = UIColorFromRGB(0xebebeb);
    // 头部背景图.
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, textFieldHeight * [ccui getRH:3])];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    // 旧密码
    _oldPwdTF = [[CCInfoTextTF alloc]initWithFrame:CGRectMake([ccui getRH:CCModifyPwdVC_left_space], 0, whiteView.width - 2*[ccui getRH:CCModifyPwdVC_left_space], [ccui getRH:textFieldHeight])];
    [_oldPwdTF.inputTextField addTarget:self action:@selector(oldPwdChanged:) forControlEvents:UIControlEventEditingChanged];
    [_oldPwdTF setupWithIcon:@"kk_regist_lock" placeholder:@"请输入旧密码"];
    [whiteView addSubview:_oldPwdTF];
    
    // 新密码
    _newPwdTF = [[CCInfoTextTF alloc]initWithFrame:CGRectMake(_oldPwdTF.left, _oldPwdTF.bottom,_oldPwdTF.width, _oldPwdTF.height)];
    [_newPwdTF setupWithIcon:@"kk_regist_lock" placeholder:newPwdPlaceHolders[_VCType]];
    [_newPwdTF.inputTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [_newPwdTF.inputTextField addTarget:self action:@selector(newPwdChanged:) forControlEvents:UIControlEventEditingChanged];
    [whiteView addSubview:_newPwdTF];
    
    // 重复新密码
    _repeatPwdTF = [[CCInfoTextTF alloc]initWithFrame:CGRectMake(_oldPwdTF.left, _newPwdTF.bottom,_oldPwdTF.width, _oldPwdTF.height)];
    [_repeatPwdTF setupWithIcon:@"kk_regist_lock" placeholder:@"请再次输入新密码"];
    [_repeatPwdTF hiddenSeparateLine];
    [_repeatPwdTF.inputTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [_repeatPwdTF.inputTextField addTarget:self action:@selector(repeatPwdChanged:) forControlEvents:UIControlEventEditingChanged];
    [whiteView addSubview:_repeatPwdTF];
    
    // 忘记密码
    UIButton *forgetPwsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwsButton.frame = CGRectMake(0, whiteView.bottom , [ccui getRH:80], [ccui getRH:20]);
    forgetPwsButton.right = SCREEN_WIDTH -  [ccui getRH:CCModifyPwdVC_left_space];
    [forgetPwsButton setTitleColor:UIColorFromRGB(0x2a6fe0) forState:UIControlStateNormal];
    forgetPwsButton.titleLabel.font=[ccui getRFS:14];
    [forgetPwsButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPwsButton addTarget:self action:@selector(forgetPwsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwsButton];
    
    // 确定按钮
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = CGRectMake(_oldPwdTF.left, whiteView.bottom + [ccui getRH:30], _oldPwdTF.width, [ccui getRH:40]);
    _confirmButton.backgroundColor = UIColorFromRGB(0xfe5454);
    [_confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    _confirmButton.layer.cornerRadius = _confirmButton.height/2;
    _confirmButton.layer.masksToBounds = YES;
    [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmButton];
    
}


#pragma mark - target
-(void)oldPwdChanged:(UITextField *)tf{
    
}
-(void)newPwdChanged:(UITextField *)tf{
    
}

-(void)repeatPwdChanged:(UITextField *)tf{
    
}

-(void)confirmButtonClick:(UIButton *)sender{
    [self requestModifyPsd];
}

- (void)requestModifyPsd{
    
    NSString *oldPsdStr=_oldPwdTF.inputTextField.text;
    NSString *psdStr=_newPwdTF.inputTextField.text;
    NSString *repeatPsdStr=_repeatPwdTF.inputTextField.text;
    if (oldPsdStr.length==0) {
        [CC_NoticeView showError:@"请输入旧密码"];
        return;
    }
    if (psdStr.length==0) {
        [CC_NoticeView showError:@"请输入新密码"];
        return;
    }
    if (repeatPsdStr.length==0) {
        [CC_NoticeView showError:@"请再次输入密码"];
        return;
    }
    if (![psdStr isEqualToString:repeatPsdStr]) {
        [CC_NoticeView showError:@"两次密码输入不一致"];
        return;
    }
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    if (_VCType==CCModifyLoginPwdType) {
        
        [para setObject:@"CHANGE_LOGIN_PASSWORD" forKey:@"service"];
    }else{
        
        [para setObject:@"CHANGE_ACCOUNT_PASSWORD" forKey:@"service"];
    }
    [para setObject:oldPsdStr forKey:@"oldLoginPassword"];
    [para setObject:psdStr forKey:@"newLoginPassword"];
    
    MaskProgressHUD *HUD = [MaskProgressHUD hudStartAnimatingAndAddToView:self.view];
    [[UserStateManager shareInstance].authTask post:[CCLoginConfig loginHeadUrl] params:para model:nil finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        [HUD stop];
        if (error) {
            [CC_NoticeView showError:error atView:self.view];
        }else{
            [_oldPwdTF resignFirstResponder];
            [_newPwdTF resignFirstResponder];
            [_repeatPwdTF resignFirstResponder];
            
            int index=(int)[[self.navigationController viewControllers]indexOfObject:self];
            int toIndex;
            toIndex=index-1;
            [CC_NoticeView showError:@"修改成功" atView:self.navigationController.viewControllers[toIndex].view];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:toIndex]animated:YES];
        }
    }];
    
}

-(void)forgetPwsButtonClicked:(UIButton *)sender{
    if (_VCType==CCModifyLoginPwdType) {
        CCPhoneNOAndVerifyCodeVC *findLoginPwdVC = [[CCPhoneNOAndVerifyCodeVC alloc]initWithType:CCPhoneNOAndVerifyCodeFindLoginPwdVC];
        [self.navigationController pushViewController:findLoginPwdVC animated:YES];
    }else if (_VCType==CCModifypayPwdType){
        CCPhoneNOAndVerifyCodeVC *findLoginPwdVC = [[CCPhoneNOAndVerifyCodeVC alloc]initWithType:CCPhoneNOAndVerifyCodeFindPayPwdVC];
        [self.navigationController pushViewController:findLoginPwdVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
