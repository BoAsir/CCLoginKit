//
//  CCRoleSelectViewController.m
//  CCTribe
//
//  Created by yaya on 2018/7/25.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCRoleSelectViewController.h"
#import "CCRoleSelectTableViewCell.h"
#import "CCRoleCreateViewController.h"
#import "CCRoleRequest.h"
#import "MaskProgressHUD.h"
#import "CCLoginConfig.h"
#import "CC_NoticeView.h"
@interface CCRoleSelectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain) UIView *displayV;
@property(nonatomic,retain) UITableView *roleTab;
@property(nonatomic,retain) NSMutableArray *roleMutArr;
@property(nonatomic,assign) NSUInteger selectedIndex;
@property(nonatomic,retain) CC_Button *defaultBt;
@property(nonatomic,assign) RoleEnterType VCType;

@end

@implementation CCRoleSelectViewController

-(instancetype)initWithType:(RoleEnterType)VCType
{
    if (self = [super init]) {
        _VCType = VCType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUserDefinedNavigationBar];
    [self setUdNavBarTitle:@"选择角色"];
    
    [self creatUI];
    [self requestRoles];
}
 
- (void)creatUI{
    
    CC_Button *addNewBt=[CC_UIAtom initAt:self.view name:@"CCRoleSelectViewController_bt_add" class:[CC_Button class]];
    addNewBt.width=[ccui getRH:100];
    addNewBt.height=[ccui getRH:40];
    addNewBt.right=[ccui getW];
    addNewBt.bottom=self.udNavBarHeight;
    [addNewBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        [self requestCreateRole];
    }];
    
    _displayV=[self setUdDisplayView];
    [CC_UIAtom initAt:_displayV name:@"CCRoleSelectViewController_image_notice" class:[UIImageView class]];
    [CC_UIAtom initAt:_displayV name:@"CCRoleSelectViewController_label_notice" class:[CC_Label class]];
    
    _roleTab=[CC_UIAtom initAt:_displayV name:@"CCRoleSelectViewController_tab_roles" class:[UITableView class]];
    _roleTab.delegate=self;
    _roleTab.dataSource=self;
    _roleTab.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)requestCreateRole{
    CCRoleCreateViewController *create=[[CCRoleCreateViewController alloc]init];

    if (_VCType==RoleEnterSwitch) {
        create.type=CreateEnterSwitch;
    }else if(_VCType == RoleEnterLogin){
        create.type=CreateEnterLogin;
    }

    [self.navigationController pushViewController:create animated:YES];
}

- (void)requestRoles{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:@"USER_LIST_QUERY" forKey:@"service"];
    MaskProgressHUD *HUD = [MaskProgressHUD hudStartAnimatingAndAddToView:self.view];
    __weak typeof(self) weakSelf = self;
    [[CC_HttpTask getInstance]post:[CCLoginConfig loginHeadUrl] params:para model:nil finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        [HUD stop];
        if (error) {
            [CC_NoticeView showError:error atView:weakSelf.view];
        }else{
            weakSelf.roleMutArr=[[NSMutableArray alloc]initWithArray:resmodel.resultDic[@"response"][@"userSelectInfo"][@"userSimples"]];
            [weakSelf creatUI_roles];
        }
    }];
}

- (void)creatUI_roles{
    
    float height=[ccui getRH:50]*_roleMutArr.count;
    float maxHeight=[ccui getH]-self.udNavBarHeight-[ccui getRH:150];
    if (height>maxHeight) {
        height=maxHeight;
    }
    _roleTab.height=height;
    [_roleTab reloadData];
    
    _defaultBt=[CC_UIAtom initAt:_displayV name:@"CCRoleSelectViewController_bt_default" class:[CC_Button class]];
    [_defaultBt setBackgroundImage:[UIImage imageNamed:@"kk_regiest_agree_protocol"] forState:UIControlStateSelected];
    _defaultBt.selected=YES;
    
    [CC_UIAtom initAt:_displayV name:@"CCRoleSelectViewController_label_default" class:[CC_Label class]];
    
    CC_Button *defaultTapBt=[CC_UIAtom initAt:_displayV name:@"CCRoleSelectViewController_bt_tap" class:[CC_Button class]];
    __weak typeof(self) weakSelf = self;
    [defaultTapBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        weakSelf.defaultBt.selected=!weakSelf.defaultBt.selected;
    }];

    
    CC_Button *loginBt=[CC_UIAtom initAt:_displayV name:@"CCRoleSelectViewController_bt_login" class:[CC_Button class]];
    [CC_CodeClass setBoundsWithRadius:20 view:loginBt];
    [loginBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        [self requestLogin];
    }];
    
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
}

- (void)requestLogin{
    if (_VCType==RoleEnterLogin) {
        [CCRoleRequest requestLoginSelectedLoginUserId:_roleMutArr[_selectedIndex][@"userId"] resetDefaultUser:_defaultBt.selected controller:self type:LoginTypeLogin];
    }else if(_VCType == RoleEnterSwitch){
        
        [CCRoleRequest requestLoginSelectedLoginUserId:_roleMutArr[_selectedIndex][@"userId"] resetDefaultUser:_defaultBt.selected controller:self type:LoginTypeSwitch];
    }
    
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _roleMutArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ccui getRH:50];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    CCRoleSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CCRoleSelectTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [cell loadData:_roleMutArr[indexPath.row][@"loginName"] index:indexPath.row selectedIndex:_selectedIndex];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    _selectedIndex=indexPath.row;
    [_roleTab reloadData];
}

@end
