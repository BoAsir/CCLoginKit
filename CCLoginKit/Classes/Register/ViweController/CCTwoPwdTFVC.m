//
//  CCTwoPwdTFVC.m
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/16.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCTwoPwdTFVC.h"
#import "CCInfoTextTF.h"
#import "CCTwoPwdTFVC.h"
#import "CCRegistSetUserInfoVC.h"
#import "CCRegistSetUserInfoVC.h"

CGFloat TwoPwdTFVC_left_space = 20;

@interface CCTwoPwdTFVC ()
{
    CCInfoTextTF *_pwdTF;
    CCInfoTextTF *_repeatTF;
    UIButton *_confirmButton;
    
}
@property(nonatomic,assign)CCTwoPwdTFVCType VCType;

@end

@implementation CCTwoPwdTFVC
-(instancetype)initWithType:(CCTwoPwdTFVCType)VCType
{
    if (self = [super init]) {
        _VCType = VCType;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [self setUserDefinedNavigationBar];
    NSArray *titleArray = @[@"注册",@"设置支付密码", @"找回登录密码",@"找回支付密码",@"实名认证"];
    [self setUdNavBarTitle:titleArray[_VCType]];
    [self creatUI];
}

-(void)creatUI {
    NSArray *pwdPlaceHolders = @[@"请输入密码,6-20位区分大小写",@"请输入6位数字密码",@"请输入新密码,6-20位区分大小写",@"请输入6位数字密码",@"请输入姓名"];
    NSArray *repeatPlaceHolders = @[@"请再次输入密码",@"请再次输入密码",@"请再次输入新密码",@"请再次输入新密码",@"请输入证件号"];
    
    self.view.backgroundColor = UIColorFromRGB(0xebebeb);
    // 头部背景图.
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, [ccui getRH:95])];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _pwdTF = [[CCInfoTextTF alloc]initWithFrame:CGRectMake( [ccui getRH:TwoPwdTFVC_left_space], 0, whiteView.width - 2*[ccui getRH:TwoPwdTFVC_left_space], whiteView.height/2)];
    [_pwdTF.inputTextField addTarget:self action:@selector(pwdChanged:) forControlEvents:UIControlEventEditingChanged];
    [_pwdTF setupWithIcon:@"kk_regist_lock" placeholder:pwdPlaceHolders[_VCType]];
    [whiteView addSubview:_pwdTF];

    _repeatTF = [[CCInfoTextTF alloc]initWithFrame:CGRectMake(_pwdTF.left, whiteView.height/2,_pwdTF.width, whiteView.height/2)];
    [_repeatTF hiddenSeparateLine];
    [_repeatTF setupWithIcon:@"kk_regist_lock" placeholder:repeatPlaceHolders[_VCType]];
    [_repeatTF.inputTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [_repeatTF.inputTextField addTarget:self action:@selector(repeadPwdChanged:) forControlEvents:UIControlEventEditingChanged];
    [whiteView addSubview:_repeatTF];
    
    if (self.VCType!=CCUserRealNameVerifyVC) {
        _pwdTF.inputTextField.secureTextEntry=YES;
        _repeatTF.inputTextField.secureTextEntry=YES;
    }

    if (_VCType==CCUserRealNameVerifyVC) {
        [_pwdTF setupWithIcon:@"kk_user" placeholder:pwdPlaceHolders[_VCType]];
        [_repeatTF setupWithIcon:@"kk_user_id" placeholder:repeatPlaceHolders[_VCType]];
    }

    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = CGRectMake(_pwdTF.left, whiteView.bottom + [ccui getRH:20], _pwdTF.width, [ccui getRH:40]);
    _confirmButton.backgroundColor = UIColorFromRGB(0xfe5454);
    [_confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    _confirmButton.layer.cornerRadius = _confirmButton.height/2;
    _confirmButton.layer.masksToBounds = YES;
    [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmButton];

}

#pragma mark - target
-(void)pwdChanged:(UITextField *)tf{
    
}

-(void)repeadPwdChanged:(UITextField *)tf{
    
}
-(void)confirmButtonClick:(UIButton *)sender{
    if (_VCType!=CCUserRealNameVerifyVC) {
        NSString *psdStr=_pwdTF.inputTextField.text;
        NSString *repeatPsdStr=_repeatTF.inputTextField.text;
        if (!psdStr) {
            [CC_NoticeView showError:@"请输入密码"];
            return;
        }
        if (!repeatPsdStr) {
            [CC_NoticeView showError:@"请再次输入密码"];
            return;
        }
        if (![psdStr isEqualToString:repeatPsdStr]) {
            [CC_NoticeView showError:@"两次密码输入不一致"];
            return;
        }
    }
    
    if (self.VCType == CCTwoPwdTFRegistVC) {
        if (![_pwdTF.inputTextField.text isEqualToString:_repeatTF.inputTextField.text]) {
            [CC_NoticeView showError:@"两次密码输入不一致"];
            return ;
        }
        CCRegistSetUserInfoVC *infoVC = [[CCRegistSetUserInfoVC alloc] init] ;
        infoVC.smsIdString = self.smsIdString ;
        infoVC.randomString = self.randomString ;
        infoVC.verifyCellSign = self.verifyCellSign ;
        infoVC.cell = self.cell ;
        infoVC.password = _repeatTF.inputTextField.text ;
        [self.navigationController pushViewController:infoVC animated:YES];

    }else if (self.VCType == CCTwoPwdTFSetPayPwdVC){
        [self requestSetPassword];
    }else if (self.VCType == CCTwoPwdTFFindLoginPwdVC){
        [self requestSetPassword];
    }else if (self.VCType == CCTwoPwdTFFindPayPwdVC){
        [self requestSetPassword];
    }else if (self.VCType == CCUserRealNameVerifyVC){
        [self requestSetPassword];
    }
}

- (void)requestSetPassword{
    
    NSString *psdStr=_pwdTF.inputTextField.text;
    NSString *repeatPsdStr=_repeatTF.inputTextField.text;
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    CCLOG(@"%lu",(unsigned long)_VCType);
    NSArray *services=@[@"INIT_ACCOUNT_PASSWORD",@"INIT_ACCOUNT_PASSWORD",@"FIND_LOGIN_PASSWORD_BY_CELL_SET_PASSWORD",@"FIND_ACCOUNT_PASSWORD_BY_CELL_SET_PASSWORD",@"USER_IDENTITY_COMPLETE"];
    [para setObject:services[_VCType] forKey:@"service"];
    if (_VCType==CCTwoPwdTFSetPayPwdVC) {
        [para setObject:psdStr forKey:@"accountPassword"];
    }else if (_VCType==CCUserRealNameVerifyVC) {
        [para setObject:psdStr forKey:@"realName"];
        [para setObject:repeatPsdStr forKey:@"certNo"];
    }else{
        [para setObject:psdStr forKey:@"newPassword"];
        [para setObject:_randomString forKey:@"randomString"];
        [para setObject:_verifyCellSign forKey:@"verifyCellSign"];
        [para setObject:_cell forKey:@"cell"];
    }
    MaskProgressHUD *HUD = [MaskProgressHUD hudStartAnimatingAndAddToView:self.view];
    ResModel *resModel = [[ResModel alloc]init];
    
    [[CC_HttpTask getInstance]post:[CCLoginConfig loginHeadUrl] params:para model:resModel finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        [HUD stop];
        if (error) {
            [CC_NoticeView showError:error];
        }else{
            if (self.VCType == CCTwoPwdTFRegistVC){
                
                int index=(int)[[self.navigationController viewControllers]indexOfObject:self];
                int toIndex=index-2;
                
                [CC_NoticeView showError:@"设置成功" atView:self.navigationController.viewControllers[toIndex].view];
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:toIndex]animated:YES];
            }else if (self.VCType == CCTwoPwdTFSetPayPwdVC){
                
                int index=(int)[[self.navigationController viewControllers]indexOfObject:self];
                int toIndex=index-2;
                
                [CC_NoticeView showError:@"设置成功" atView:self.navigationController.viewControllers[toIndex].view];
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:toIndex]animated:YES];
            }else if (self.VCType == CCTwoPwdTFFindLoginPwdVC){
                
                int index=(int)[[self.navigationController viewControllers]indexOfObject:self];
                int toIndex=index-2;
                
                [CC_NoticeView showError:@"修改成功" atView:self.navigationController.viewControllers[toIndex].view];
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:toIndex]animated:YES];
            }else if (self.VCType == CCTwoPwdTFFindPayPwdVC){
                
                int index=(int)[[self.navigationController viewControllers]indexOfObject:self];
                int toIndex=index-4;
                
                [CC_NoticeView showError:@"修改成功" atView:self.navigationController.viewControllers[toIndex].view];
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:toIndex]animated:YES];
            }else if (self.VCType == CCUserRealNameVerifyVC){
                
                int index=(int)[[self.navigationController viewControllers]indexOfObject:self];
                int toIndex=index-1;
                
                [CC_NoticeView showError:@"认证成功" atView:self.navigationController.viewControllers[toIndex].view];
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:toIndex]animated:YES];
            }
        }
    }];
}
    
@end
