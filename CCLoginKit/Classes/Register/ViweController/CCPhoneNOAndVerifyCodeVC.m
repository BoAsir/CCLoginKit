//
//  CCPhoneNOAndVerifyCodeVC.m
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/16.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCPhoneNOAndVerifyCodeVC.h"
#import "CCInfoTextTF.h"
#import "CCPhoneNOAndVerifyCodeVC+Register.h"
#import "CCTwoPwdTFVC.h"
#import "CC_NoticeView.h"
#import "MaskProgressHUD.h"
#import "CCLoginConfig.h"
#import "NSDictionary+BBAdd.h"
#import "NSMutableDictionary+BBAdd.h"
CGFloat PhoneNOAndVerifyCodeVC_left_space = 20;

@interface CCPhoneNOAndVerifyCodeVC ()<UITextFieldDelegate>

@property (nonatomic, strong) CCInfoTextTF *phoneNumberTF;
@property (nonatomic, strong) CCInfoTextTF *vertifyCodeTF;
@property (nonatomic, strong) NSString *randomString;
@property (nonatomic, strong) NSString *verifyCellSign;
@property (nonatomic, strong) UIButton *getVertifyCodeButton;
@property (nonatomic, strong) UIButton *nextStepButton;

@property(nonatomic,assign) int verificationCodeTime;///<验证码倒计时
@property(nonatomic,strong) NSTimer *verificationCodeTimer;
@property(nonatomic,strong) NSString *smsIdString;//验证码
@property(nonatomic,assign) CCPhoneNOAndVerifyCodeVCType VCType;

@end

@implementation CCPhoneNOAndVerifyCodeVC

-(instancetype)initWithType:(CCPhoneNOAndVerifyCodeVCType)VCType
{
    if (self = [super init]) {
        _VCType = VCType;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUserDefinedNavigationBar];
    NSArray *titleArray = @[@"注册",@"找回登录密码",@"找回支付密码"];
    [self setUdNavBarTitle:titleArray[_VCType]];

    [self creatUI];

}
-(void)creatUI
{
    self.view.backgroundColor = UIColorFromRGB(0xebebeb);
    // 头部背景图.
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, [ccui getRH:95])];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _phoneNumberTF = [[CCInfoTextTF alloc]initWithFrame:CGRectMake( [ccui getRH:PhoneNOAndVerifyCodeVC_left_space], 0, whiteView.width - 2*[ccui getRH:PhoneNOAndVerifyCodeVC_left_space], whiteView.height/2)];
    [_phoneNumberTF setupWithIcon:@"kk_login_phone" placeholder:@"请输入手机号"];
    _phoneNumberTF.inputTextField.keyboardType=UIKeyboardTypeNumberPad;
    [whiteView addSubview:_phoneNumberTF];
    _phoneNumberTF.inputTextField.delegate = self;
    
    _vertifyCodeTF = [[CCInfoTextTF alloc]initWithFrame:CGRectMake( [ccui getRH:PhoneNOAndVerifyCodeVC_left_space], whiteView.height/2, whiteView.width - 2*[ccui getRH:PhoneNOAndVerifyCodeVC_left_space], whiteView.height/2)];
    // 验证码
    [_vertifyCodeTF hiddenSeparateLine];
    [_vertifyCodeTF setupWithIcon:@"kk_login_vertifyCode" placeholder:@"请输入验证码"];
    [_vertifyCodeTF.inputTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [_vertifyCodeTF.inputTextField addTarget:self action:@selector(vertifyCodeChanged:) forControlEvents:UIControlEventEditingChanged];
    [whiteView addSubview:_vertifyCodeTF];
    
    UIButton *requestVertifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    requestVertifyCodeBtn.frame = CGRectMake(0, 0, [ccui getRH:100], [ccui getRH:40]);
    requestVertifyCodeBtn.titleLabel.font = [ccui getRFS:13];
    [requestVertifyCodeBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
    [requestVertifyCodeBtn setTitleColor:UIColorFromRGB(0xfc5447) forState:UIControlStateNormal];
    [requestVertifyCodeBtn setBackgroundColor:[UIColor whiteColor]];
    requestVertifyCodeBtn.layer.borderColor = [UIColor clearColor].CGColor;
    requestVertifyCodeBtn.layer.borderWidth = 1;
    requestVertifyCodeBtn.layer.cornerRadius = 3;
    requestVertifyCodeBtn.layer.masksToBounds = YES;
    [requestVertifyCodeBtn addTarget:self action:@selector(requestFirstVertifyCode:) forControlEvents:UIControlEventTouchUpInside];
    _getVertifyCodeButton = requestVertifyCodeBtn;
    [_vertifyCodeTF setRightView:requestVertifyCodeBtn];
    
    
    CGFloat Y = whiteView.bottom;
    
    if (_VCType == CCPhoneNOAndVerifyCodeRegisterVC){
        Y = [self addRegistProtocolUITopY:Y];
    }
    
    _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextStepButton.frame = CGRectMake(_phoneNumberTF.left, Y + [ccui getRH:20], _phoneNumberTF.width, [ccui getRH:40]);
    _nextStepButton.backgroundColor = UIColorFromRGB(0xfe5454);
    [_nextStepButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    _nextStepButton.layer.cornerRadius = _nextStepButton.height/2;
    _nextStepButton.layer.masksToBounds = YES;
    [_nextStepButton addTarget:self action:@selector(firstStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextStepButton];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length>10) {
        if (string.length==0) {
            return YES;
        }
        return NO;
    }
    return YES;
}

#pragma mark - terget
-(void)vertifyCodeChanged:(UITextField *)tf
{
    if (tf.text.length>11) {
        tf.text = [tf.text substringToIndex:11];
    }
}
-(void)requestFirstVertifyCode:(UIButton *)button
{
    if (_VCType == CCPhoneNOAndVerifyCodeRegisterVC&&self.agreeRegistProtocolButton.selected==NO){
        [CC_NoticeView showError:@"请同意协议"];
        return;
    }
    NSString *cellStr=_phoneNumberTF.inputTextField.text;
    if (cellStr.length==0) {
        [CC_NoticeView showError:@"请输入手机号"];
        return;
    }
    if (cellStr.length!=11) {
        [CC_NoticeView showError:@"请输入正确的手机号"];
        return;
    }
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    CCLOG(@"%lu",(unsigned long)_VCType);
    NSArray *services=@[@"REGISTER_SEND_SMS_ACK",@"FIND_LOGIN_PASSWORD_BY_CELL_SEND_SMS_ACK",@"FIND_ACCOUNT_PASSWORD_BY_CELL_SEND_SMS_ACK"];
    [para setObject:services[_VCType] forKey:@"service"];
    [para setObject:@"registerednumber_verification_obtain_null_null_null" forKey:@"from"];
    [para setObject:cellStr forKey:@"cell"];
    MaskProgressHUD *HUD = [MaskProgressHUD hudStartAnimatingAndAddToView:self.view];
    ResModel *resModel = [[ResModel alloc]init];
    
    __weak typeof(self) weakSelf = self;
    [[CC_HttpTask getInstance]post:[CCLoginConfig loginHeadUrl] params:para model:resModel finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        [HUD stop];
        if (error) {
            if ([error isEqualToString:@"手机号格式错误"]) {
                [CC_NoticeView showError:@"请输入正确的手机号"];
            }else{
                [CC_NoticeView showError:error];
            }
        }else{
            NSDictionary *resultDic = resModel.resultDic;
            if (resultDic && [resultDic objectForKey:@"response"]) {
                NSDictionary *result = [resultDic objectForKey:@"response"];
                button.enabled=NO;
                weakSelf.smsIdString=[NSString stringWithFormat:@"%@",[result objectForKey:@"smsId"]];
                weakSelf.verificationCodeTime=[[result  objectForKey:@"waitNextPrepareSeconds"]intValue];
                weakSelf.verificationCodeTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shengchengTimer:) userInfo:button repeats:YES];
            }
        }
    }];
}

- (void)shengchengTimer:(NSTimer*)timer{
    UIButton *button = (UIButton*)(timer.userInfo);
    _verificationCodeTime--;
    if (_verificationCodeTime<=0) {
        button.enabled=YES;
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verificationCodeTimer invalidate];
        _verificationCodeTimer = nil;
    }else{
        button.enabled = NO;
        [button setTitle:[NSString stringWithFormat:@"%ds",_verificationCodeTime] forState:UIControlStateNormal];
    }
}

-(void)firstStep:(UIButton *)sender{
    if (_phoneNumberTF.inputTextField.text.length == 11) {
        NSString *regex = @"^[1][0-9]\\d{9}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([pred evaluateWithObject:_phoneNumberTF.inputTextField.text]) {
            if (_vertifyCodeTF.inputTextField.text.length==0){
                [CC_NoticeView showError:@"请输入验证码"];
            }else{
                [self requestRegisterInVerifySms];
            }
        }else{
            [CC_NoticeView showError:@"输入的手机号有误"];
        }
    }else if(_phoneNumberTF.inputTextField.text.length == 0){
        [CC_NoticeView showError:@"请输入手机号"];
    }else{
        [CC_NoticeView showError:@"输入的手机号有误"];
    }
}

-(void)requestRegisterInVerifySms{
    if (_VCType == CCPhoneNOAndVerifyCodeRegisterVC&&self.agreeRegistProtocolButton.selected==NO){
        [CC_NoticeView showError:@"请同意协议"];
        return;
    }
    NSString *vertifyCodeStr=_vertifyCodeTF.inputTextField.text;
    if (vertifyCodeStr.length==0) {
        [CC_NoticeView showError:@"请输入验证码"];
        return;
    }
    NSArray *services=@[@"REGISTER_VALIDATE_SMS_ACK",@"FIND_LOGIN_PASSWORD_BY_CELL_VALIDTE_SMS_ACK",@"FIND_ACCOUNT_PASSWORD_BY_CELL_VALIDTE_SMS_ACK"];
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:services[_VCType] forKey:@"service"];
    
    [para setObject:@"registerednumber_next_sure_null_null_null" forKey:@"from"];
    [para setObject:@"registeredpassword" forKey:@"to"];
    
    [para setObject:_phoneNumberTF.inputTextField.text forKey:@"cell"];
    [para setObject:_vertifyCodeTF.inputTextField.text forKey:@"cellValidateCode"];
    [para setObject:_smsIdString forKey:@"smsId"];
    [para setObject:vertifyCodeStr forKey:@"validateCode"];
    [para safe_setObject:_smsIdString forKey:@"smsId"];

    MaskProgressHUD *HUD = [MaskProgressHUD hudStartAnimatingAndAddToView:self.view];
    ResModel *resModel = [[ResModel alloc]init];
    WS(weakSelf);
    [[CC_HttpTask getInstance]post:[CCLoginConfig loginHeadUrl] params:para model:resModel finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        [HUD stop];
        if (error) {
            [CC_NoticeView showError:error];
        }else{
            NSDictionary *resultDic = resModel.resultDic;
            if (resultDic && [resultDic objectForKey:@"response"]) {
                NSDictionary *result = [resultDic objectForKey:@"response"];
                weakSelf.randomString = [NSString stringWithFormat:@"%@",result[@"randomString"]];
                weakSelf.verifyCellSign = [NSString stringWithFormat:@"%@",result[@"verifyCellSign"]];
                
                CCTwoPwdTFVC *setPwdVC ;
                if (self.VCType == 0) {
                    setPwdVC = [[CCTwoPwdTFVC alloc] initWithType:CCTwoPwdTFRegistVC] ;
                }else if(self.VCType == 1){
                    setPwdVC = [[CCTwoPwdTFVC alloc] initWithType:CCTwoPwdTFFindLoginPwdVC] ;

                }else if(self.VCType == 2){
                    setPwdVC = [[CCTwoPwdTFVC alloc] initWithType:CCTwoPwdTFFindPayPwdVC] ;
                }
                setPwdVC.randomString = weakSelf.randomString;
                setPwdVC.verifyCellSign = weakSelf.verifyCellSign;
                setPwdVC.smsIdString = weakSelf.smsIdString;
                setPwdVC.cell = weakSelf.phoneNumberTF.inputTextField.text;
                [self.navigationController pushViewController:setPwdVC animated:YES];
            }
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
