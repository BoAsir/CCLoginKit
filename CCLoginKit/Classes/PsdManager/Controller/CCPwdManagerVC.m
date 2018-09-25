//
//  CCPwdManagerVC.m
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/17.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCPwdManagerVC.h"
#import "CCModifyPwdVC.h"
#import "CCPhoneNOAndVerifyCodeVC.h"
#import "CCTwoPwdTFVC.h"
#import "UserStateManager.h"
NSString *const kk_pwd_manager_cell_id = @"kk_pwd_manager_cell_id";

@interface CCPwdManagerVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)CCPwdManagerVCType VCType;

@property(nonatomic,copy)NSArray *cellTextArray;

@property(nonatomic,strong)UITableView *pwdManagerTabeleView;

@end

@implementation CCPwdManagerVC


-(instancetype)initWithType:(CCPwdManagerVCType)VCType
{
    if (self = [super init]) {
        _VCType = VCType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUserDefinedNavigationBar];
    
    NSArray *titleArray = @[@"登录密码管理",@"支付密码管理"];
    [self setUdNavBarTitle:titleArray[_VCType]];
    
    _hasSetPayPwd=[UserStateManager shareInstance].accountPasswordSet;
    if (_VCType == CCPwdManagerVCType_PayPwd) {
        if (_hasSetPayPwd) {
            self.cellTextArray = @[@"修改密码",@"找回密码"];
        }else{
            self.cellTextArray = @[@"设置密码"];
        }
    }else{
        self.cellTextArray = @[@"修改密码",@"找回密码"];
    }
    [self creatUI];
}

-(void)creatUI{
    self.view.backgroundColor = UIColorFromRGB(0xebebeb);
    _pwdManagerTabeleView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    _pwdManagerTabeleView.delegate = self;
    _pwdManagerTabeleView.dataSource = self;
    [_pwdManagerTabeleView registerClass:[UITableViewCell class] forCellReuseIdentifier:kk_pwd_manager_cell_id];
    _pwdManagerTabeleView.backgroundColor = UIColorFromRGB(0xebebeb);
    [self.view addSubview:_pwdManagerTabeleView];
    
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = UIColorFromRGB(0xebebeb);
    _pwdManagerTabeleView.tableFooterView = footView;
}

#pragma mark - uitableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellTextArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kk_pwd_manager_cell_id];
    cell.textLabel.text = [self.cellTextArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0,20, 0, 20);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_VCType == CCPwdManagerVCType_LoginPwd) {
        switch (indexPath.row) {
            case 0:
            {
                CCModifyPwdVC *modifyLoginPwdVC = [[CCModifyPwdVC alloc]initWithType:CCModifyLoginPwdType];
                [self.navigationController pushViewController:modifyLoginPwdVC animated:YES];
            }
                break;
            case 1:
            {
                CCPhoneNOAndVerifyCodeVC *findLoginPwdVC = [[CCPhoneNOAndVerifyCodeVC alloc]initWithType:CCPhoneNOAndVerifyCodeFindLoginPwdVC];
                [self.navigationController pushViewController:findLoginPwdVC animated:YES];
            }
                break;
            default:
                break;
        }
    }else if(_VCType == CCPwdManagerVCType_PayPwd){
        if (self.hasSetPayPwd) {
            switch (indexPath.row) {
                case 0:
                {
                    CCModifyPwdVC *modifyLoginPwdVC = [[CCModifyPwdVC alloc]initWithType:CCModifypayPwdType];
                    [self.navigationController pushViewController:modifyLoginPwdVC animated:YES];
                }
                    break;
                case 1:
                {
                    CCPhoneNOAndVerifyCodeVC *findLoginPwdVC = [[CCPhoneNOAndVerifyCodeVC alloc]initWithType:CCPhoneNOAndVerifyCodeFindPayPwdVC];
                    [self.navigationController pushViewController:findLoginPwdVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }else{
            CCTwoPwdTFVC *setPayPwdVC = [[CCTwoPwdTFVC alloc]initWithType:CCTwoPwdTFSetPayPwdVC];
            [self.navigationController pushViewController:setPayPwdVC animated:YES];
        }
    }
}


@end
