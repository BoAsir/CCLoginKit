//
//  KKLoginVC.m
//  KKTribe
//
//  Created by lidaoyuan on 2018/7/11.
//  Copy right © 2018年 杭州鼎代. All rights reserved.
//


#import "CCLoginVC.h"
#import "CCInfoTextTF.h"
#import "CCAccountAlertView.h"
#import "CCPhoneNOAndVerifyCodeVC.h"
#import "CCRoleSelectViewController.h"
#import "CCRoleRequest.h"
#import "CC_NoticeView.h"
#import "CCLoginConfig.h"
#import "MaskProgressHUD.h"
#import "UserStateManager.h"
#import "CC_Share.h"
CGFloat const left_edge = 35;

@interface CCLoginVC ()<CCAccountAlertViewDelegate>

@property (nonatomic, strong) UIScrollView *scroView;
@property (nonatomic, strong) CCInfoTextTF *phoneNumTF;
@property (nonatomic, strong) CCInfoTextTF *pwdTF;
@property (nonatomic, strong) UIButton *userDefaultRoleButton;

@end

@implementation CCLoginVC


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _scroView.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackgroundView];
    [self createSubViews];
}

-(void)createBackgroundView{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backDownImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImage *backDownImage = [UIImage imageNamed:@"login_bottom" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    backDownImageV.image = backDownImage;
    [self.view addSubview:backDownImageV];

    _scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scroView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+[ccui getRH:100]);
    _scroView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scroView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    [_scroView addGestureRecognizer:tap];
}

-(void)createSubViews
{
    //icon
    UIImageView *loginIconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-[ccui getRH:40], [ccui getRH:53], [ccui getRH:80], [ccui getRH:80])];
    loginIconImageV.image = [UIImage imageNamed:@"kk_regist_upload_portrait_image_add" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    [self.view addSubview:loginIconImageV];
    
    //手机号
    _phoneNumTF = [[CCInfoTextTF alloc] initWithFrame:CGRectMake([ccui getRH:left_edge], loginIconImageV.bottom+[ccui getRH:50], SCREEN_WIDTH-[ccui getRH:left_edge] * 2, [ccui getRH:35])];
    [_phoneNumTF setupWithIcon:@"kk_login_phone" placeholder:@"请输入手机号"];
    _phoneNumTF.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumTF.inputTextField.font = [ccui getRFS:14];
    [_phoneNumTF.inputTextField addTarget:self action:@selector(phoneNumDidChanged:) forControlEvents: UIControlEventEditingChanged];
    _phoneNumTF.backgroundColor = UIColorFromRGB(0xffffff);
    [self.view addSubview:_phoneNumTF];
    
    //密码
    _pwdTF = [[CCInfoTextTF alloc] initWithFrame:CGRectMake(_phoneNumTF.left, _phoneNumTF.bottom+[ccui getRH:10], _phoneNumTF.width, [ccui getRH:35])];
    
    [_pwdTF setupWithIcon:@"kk_regist_lock" placeholder:@"请输入密码"];
    _pwdTF.inputTextField.secureTextEntry=YES;
    _pwdTF.inputTextField.keyboardType = UIKeyboardTypeDefault;
    _pwdTF.inputTextField.font = [ccui getRFS:14];
    [_pwdTF.inputTextField addTarget:self action:@selector(pwdDidChange:) forControlEvents: UIControlEventEditingChanged];
    _pwdTF.backgroundColor = UIColorFromRGB(0xffffff);
    [self.view addSubview:_pwdTF];
    
    //睁眼
    CC_Button *eyeBtn = [[CC_Button alloc] initWithFrame:CGRectMake(0, 0, [ccui getRH:40], [ccui getRH:40])];
    [eyeBtn setImage:[UIImage imageNamed:@"kk_login_pwd_cant_see" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"kk_login_pwd_can_see" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    eyeBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [_pwdTF setRightView:eyeBtn];
    
    __weak typeof(self)weakSelf = self;
    [eyeBtn addTappedBlock:^(UIButton *button) {
        __strong typeof(self) strongSelf = weakSelf;
        button.selected = !button.selected;
        if (button.selected) {
            strongSelf.pwdTF.inputTextField.secureTextEntry = NO;
        }else{
            strongSelf.pwdTF.inputTextField.secureTextEntry = YES;
        }
    }];
    //默认角色登录
    _userDefaultRoleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _userDefaultRoleButton.frame = CGRectMake([ccui getRH:left_edge], _pwdTF.bottom + [ccui getRH:20], [ccui getRH:40], [ccui getRH:40]);
    _userDefaultRoleButton.imageEdgeInsets =UIEdgeInsetsMake(10, 10, 10, 10);
    [_userDefaultRoleButton setImage:[UIImage imageNamed:@"kk_regiest_unagree_protocol" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [_userDefaultRoleButton setImage:[UIImage imageNamed:@"kk_regiest_agree_protocol" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    _userDefaultRoleButton.selected = YES;
    [_userDefaultRoleButton addTarget:self action:@selector(userDefaultRoleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_userDefaultRoleButton];
    
    UILabel *userDefaultRoleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_userDefaultRoleButton.right, _userDefaultRoleButton.top, 150,_userDefaultRoleButton.height)];
    userDefaultRoleLabel.textAlignment = NSTextAlignmentLeft;
    userDefaultRoleLabel.font = [ccui getRFS:12];
    userDefaultRoleLabel.textColor = UIColorFromRGB(0xA6A6A6);
    userDefaultRoleLabel.text = @"使用默认角色登录";
    [self.view addSubview:userDefaultRoleLabel];
    
    //登录
    CC_Button *loginBtn = [CC_Button buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(_pwdTF.left,_userDefaultRoleButton.bottom+[ccui getRH:20], SCREEN_WIDTH - 2*_pwdTF.left, [ccui getRH:44]);
    loginBtn.backgroundColor = UIColorFromRGB(0xef5454);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [ccui getRFS:15];
    loginBtn.layer.cornerRadius = loginBtn.height / 2;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    
    __block UITextField *phoneNumTF = _phoneNumTF.inputTextField;
    __block UITextField *pwdTF = _pwdTF.inputTextField;
    __weak typeof(self) ws = self;
    [loginBtn addTappedBlock:^(UIButton *button) {
        __strong typeof(ws) strongSelf = ws;
        
        NSString *psd=strongSelf.pwdTF.inputTextField.text;
        if (psd.length>20) {
            [CC_NoticeView showError:@"密码超过20字"];
            return ;
        }
        
        if (phoneNumTF.text.length == 11) {
            NSString *regex = @"^[1][0-9]\\d{9}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            if ([pred evaluateWithObject:phoneNumTF.text]) {
                if (pwdTF.text.length==0) {
                    BBLOG(@"请输入密码");
                    [CC_NoticeView showError:@"请输入密码"];
                }else {
                    [strongSelf loginrequestCell:phoneNumTF.text andPwd:pwdTF.text fromRegister:NO];
                }
            }else {
                BBLOG(@"请输入正确的手机号");
                [CC_NoticeView showError:@"请输入正确的手机号"];
            }
        }else if (phoneNumTF.text.length == 0){
            BBLOG(@"请输入手机号");
            [CC_NoticeView showError:@"请输入手机号"];
        }else {
            BBLOG(@"输入的手机号有误");
            [CC_NoticeView showError:@"请输入正确的手机号"];
        }
    }];
    
    CC_Button *registBtn = [CC_Button buttonWithType:UIButtonTypeCustom];
    [registBtn setTitle:@"注册" forState:0];
    registBtn.frame = CGRectMake(_pwdTF.left, loginBtn.bottom+[ccui getRH:12], [ccui getRH:85], [ccui getRH:40]);
    registBtn.titleLabel.font = [ccui getRFS:14];
    registBtn.titleLabel.textAlignment =  NSTextAlignmentLeft;
    [registBtn setTitleColor:RGBA(153, 153, 153, 1) forState:0];
    [self.view addSubview:registBtn];
    [registBtn addTappedBlock:^(UIButton *button) {
        __strong typeof(ws) strongSelf = ws;
        [strongSelf goToRegisterVC];
    }];
    
    CC_Button *forgetPwdBtn = [CC_Button buttonWithType:UIButtonTypeCustom];
    [forgetPwdBtn setTitle:@"忘记密码?" forState:0];
    forgetPwdBtn.frame = CGRectMake(0, registBtn.top, [ccui getRH:85], [ccui getRH:40]);
    forgetPwdBtn.right = loginBtn.right;
    forgetPwdBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    forgetPwdBtn.titleLabel.font = [ccui getRFS:14];
    [forgetPwdBtn setTitleColor:RGBA(153, 153, 153, 1) forState:0];
    [forgetPwdBtn addTappedBlock:^(UIButton *button) {
        __strong typeof(ws) strongSelf = ws;
         [strongSelf goToFindPwdVC];
    }];
    [self.view addSubview:forgetPwdBtn];
    
    //若为半开放，显示按钮
    if ([CCLoginConfig isHalfOpen]) {
        CC_Button *closeBt = [CC_Button buttonWithType:UIButtonTypeCustom];
        closeBt.frame = CGRectMake([ccui getW]/2-[ccui getRH:100],forgetPwdBtn.bottom, [ccui getRH:200], [ccui getRH:40]);
        [closeBt setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
        [closeBt setTitle:@"【暂不登录，随便看看】" forState:UIControlStateNormal];
        closeBt.titleLabel.font = [ccui getRFS:15];
        [self.view addSubview:closeBt];
        [closeBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
            
            [weakSelf.phoneNumTF.inputTextField resignFirstResponder];
            [weakSelf.pwdTF.inputTextField resignFirstResponder];
            
            //半开放登录成功
            [[NSNotificationCenter defaultCenter] postNotificationName:CCLoginConfigHalfOpenDidLoginSuccess object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

#pragma mark - target
-(void)phoneNumDidChanged:(UITextField *)textField{
    if (textField.text.length>11) {
        textField.text = [textField.text substringToIndex:11];
    }
}

-(void)pwdDidChange:(UITextField *)textField{
    
}
//默认角色那个勾
-(void)userDefaultRoleButtonClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

#pragma mark 手机号登录
-(void)loginrequestCell:(NSString *)cell andPwd:(NSString*)pwd fromRegister:(BOOL)fromRegister{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:@"ONE_AUTH_LOGIN" forKey:@"service"];
    [para setObject:pwd forKey:@"loginPassword"];
    [para setObject:cell forKey:@"cell"];
    [para setObject:@(_userDefaultRoleButton.selected) forKey:@"selectedDefaultUserToLogin"];
    MaskProgressHUD *HUD = [MaskProgressHUD hudStartAnimatingAndAddToView:self.view];
    ResModel *resModel = [[ResModel alloc]init];
    WS(weakSelf);
    [[CC_HttpTask getInstance]post:[CCLoginConfig loginHeadUrl] params:para model:resModel finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        [HUD stop];
        if (error) {
            if ([error isEqualToString:@"登录密码错误"]) {
                [CC_NoticeView showError:@"账号或密码有误"];
            }else if([error isEqualToString:@"重试次数太多，拒绝认证"]){
                [CC_NoticeView showError:resmodel.resultDic[@"response"][@"detailMessage"]];
            }else{
                [CC_NoticeView showError:error];
            }

            if ([resmodel.resultDic[@"response"][@"error"][@"name"] isEqualToString:@"LOGIN_FORBIDDEN"]) {
                NSDictionary *responseDic = [resmodel.resultDic objectForKey:@"response"];
                NSString *forBidReasonStr = [NSString stringWithFormat:@"冻结理由：%@",[responseDic[@"resultMap"] objectForKey:@"forbiddenReason"]];
                NSString *gmtExpiredTimeStr = [NSString stringWithFormat:@"解冻时间：%@",[responseDic[@"resultMap"] objectForKey:@"gmtEnd"]];

                CCAccountAlertView * alert =[[CCAccountAlertView alloc] initWithTitleString:@"抱歉！您的账号已被冻结" Second:forBidReasonStr third:gmtExpiredTimeStr ButtonContent:@"确定"];
                alert.delegate = self;
                [self.view addSubview:alert];
            }
            if (self.userloginSuccessBlock) {
                self.userloginSuccessBlock(nil);
            }
        }else{
            [self.phoneNumTF.inputTextField resignFirstResponder];
            [self.pwdTF.inputTextField resignFirstResponder];
            
            NSDictionary *resultDic = resModel.resultDic;
            NSDictionary *result = [resultDic objectForKey:@"response"];
                
            //存储登录信息
            {
                NSDictionary *response = resmodel.resultDic[@"response"];
                [UserStateManager shareInstance].oneAuthId=response[@"oneAuthPlatformLogin"][@"oneAuthId"];
//                [ccs saveDefaultKey:@"oneAuthId" andV:response[@"oneAuthPlatformLogin"][@"oneAuthId"]];
//                [[CC_HttpTask getInstance]setExtreDic:@{@"oneAuthId":response[@"oneAuthPlatformLogin"][@"oneAuthId"]}];
                [UserStateManager shareInstance].oneAuth_signKey=response[@"oneAuthPlatformLogin"][@"signKey"];
                [UserStateManager shareInstance].oneAuth_loginKey=response[@"oneAuthPlatformLogin"][@"loginKey"];
                [ccs saveDefaultKey:@"oneAuthId" andV:[UserStateManager shareInstance].oneAuthId];
                [ccs saveDefaultKey:@"oneAuth_signKey" andV:[UserStateManager shareInstance].oneAuth_signKey];
                [ccs saveDefaultKey:@"oneAuth_loginKey" andV:[UserStateManager shareInstance].oneAuth_loginKey];
                [[UserStateManager shareInstance]setAuthSignKey];
            }
            
            if ([result[@"gotoUserList"] boolValue]&&fromRegister==0) {
                //是否跳转到角色列表
                CCRoleSelectViewController *roleS=[[CCRoleSelectViewController alloc]init];
                [self.navigationController pushViewController:roleS animated:YES];
            }else{
                [CC_NoticeView showError:@"登录成功" ];
                [CCRoleRequest saveLoginInfo:resmodel.resultDic[@"response"]];
                //确保已登录↑
                if ([UserStateManager shareInstance].authedUserId) {
                    weakSelf.scroView.hidden = YES;
                    //登陆成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:CCLoginConfigDidLoginSuccess object:nil userInfo:@{@"fromRegister":@(fromRegister)}];
                }
            }
            
            NSDictionary*dic = [[NSDictionary alloc] initWithDictionary:result];
            if (self.userloginSuccessBlock) {
                self.userloginSuccessBlock(dic);
            }
            
        }
    }];
}
-(void)closeKeyBoard{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [_scroView endEditing:YES];
}

-(void)goToRegisterVC{
    CCPhoneNOAndVerifyCodeVC *registVC = [[CCPhoneNOAndVerifyCodeVC alloc]initWithType:CCPhoneNOAndVerifyCodeRegisterVC];
    [self.navigationController pushViewController:registVC animated:YES];
}

-(void)goToFindPwdVC{
    CCPhoneNOAndVerifyCodeVC *findLoginPwdVC = [[CCPhoneNOAndVerifyCodeVC alloc]initWithType:CCPhoneNOAndVerifyCodeFindLoginPwdVC];
    [self.navigationController pushViewController:findLoginPwdVC animated:YES];
}

#pragma mark bbAcountAlertDelegate
-(void)AccountAlertViewButtonClickPassValue:(UIButton *)button AccountAlertView:(UIView *)AccountAlertView{
    _phoneNumTF.inputTextField.text = @"";
    _pwdTF.inputTextField.text = @"";
    
    [[UserStateManager shareInstance] logoutAndSetNil];
}

-(void)dealloc{
    BBLOG(@"loginVC-dealloc");
}

@end
