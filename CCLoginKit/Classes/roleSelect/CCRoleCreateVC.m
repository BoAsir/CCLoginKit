//
//  CCRoleCreateVC.m
//  CCLoginKit
//
//  Created by 路飞 on 2018/9/27.
//

#import "CCRoleCreateVC.h"
#import "CCRoleRequest.h"
#import "CC_NoticeView.h"
#import "MaskProgressHUD.h"
#import "CCLoginConfig.h"
#import "CC_Share.h"
#import "UserStateManager.h"

@interface CCRoleCreateVC ()

@property(nonatomic,retain) CCInfoTextTF *nickNameTF;
@property(nonatomic,retain) UIView *displayV;
@property(nonatomic,retain) CC_Button *defaultBt;

@end

@implementation CCRoleCreateVC

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
    
    _defaultBt = [[CC_Button alloc]initWithFrame:CGRectMake([ccui getRH:15], _nickNameTF.bottom+[ccui getRH:15], [ccui getRH:15], [ccui getRH:15])];
    [_displayV addSubview:_defaultBt];
    [_defaultBt setBackgroundImage:[UIImage imageNamed:@"kk_regiest_agree_protocol" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    [_defaultBt setBackgroundImage:[UIImage imageNamed:@"kk_regiest_unagree_protocol" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    _defaultBt.selected=YES;
    
    UILabel* defaultLb = [[UILabel alloc]initWithFrame:CGRectMake([ccui getRH:40], _nickNameTF.bottom+[ccui getRH:16], [ccui getRH:150], [ccui getRH:15])];
    defaultLb.text = @"默认使用该角色登录";
    defaultLb.textColor = UIColorFromHexStr(@"666666");
    defaultLb.font = [ccui getRFS:14];
    [_displayV addSubview:defaultLb];
    
    CC_Button* defaultTapBt = [[CC_Button alloc]initWithFrame:CGRectMake([ccui getRH:15], _nickNameTF.bottom+[ccui getRH:5], [ccui getRH:200], [ccui getRH:30])];
    [_displayV addSubview:defaultTapBt];
    
    WS(weakSelf);
    [defaultTapBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        weakSelf.defaultBt.selected=!weakSelf.defaultBt.selected;
    }];
    CC_Button *loginBt = [[CC_Button alloc]initWithFrame:CGRectMake([ccui getRH:20], defaultLb.bottom+[ccui getRH:30], SCREEN_WIDTH-[ccui getRH:40], [ccui getRH:40])];
    [loginBt setTitle:@"确定" forState:UIControlStateNormal];
    [loginBt setBackgroundColor:UIColorFromHexStr(@"FF0000")];
    [loginBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBt.titleLabel.font = [ccui getRFS:16];
    [_displayV addSubview:loginBt];
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
