//
//  CCRoleSelectVC.m
//  CCLoginKit
//
//  Created by 路飞 on 2018/9/27.
//

#import "CCRoleSelectVC.h"
//#import "CCRoleSelectTableViewCell.h"
#import "CCRoleSelectTableVCell.h"
//#import "CCRoleCreateViewController.h"
#import "CCRoleCreateVC.h"
#import "CCRoleRequest.h"
#import "MaskProgressHUD.h"
#import "CCLoginConfig.h"
#import "CC_NoticeView.h"
#import "CC_Share.h"
#import "UserStateManager.h"
#import "CC_CodeLib.h"
@interface CCRoleSelectVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain) UIView *displayV;
@property(nonatomic,retain) UITableView *roleTab;
@property(nonatomic,retain) NSMutableArray *roleMutArr;
@property(nonatomic,assign) NSUInteger selectedIndex;
@property(nonatomic,retain) CC_Button *defaultBt;
@property(nonatomic,assign) RoleEnterType VCType;

@end

@implementation CCRoleSelectVC

#pragma mark - lifeCycle
-(instancetype)initWithType:(RoleEnterType)VCType
{
    if (self = [super init]) {
        _VCType = VCType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self creatUI];
    [self requestRoles];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - method
-(void)initNav{
    [self setUserDefinedNavigationBarWhite];
    [self setUdNavBarTitle:@"选择角色"];
    self.UD_navigationBarView.backButton.hidden = YES;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    cancelBtn.frame = CGRectMake(10, 20, 40, 20);
    
    UIImage *backImage = [UIImage imageNamed:@"gray_navBack_arrow_icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    
    [cancelBtn setImage:backImage forState:UIControlStateNormal];
    
    cancelBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cancelBtn.frame=CGRectMake(10, STATUS_BAR_HEIGHT+10, backImage.size.width*24/backImage.size.height, 24);
    [self.UD_navigationBarView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(prePopAction) forControlEvents:UIControlEventTouchUpInside];
    
    CC_Button *addNewBt=[[CC_Button alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[ccui getRH:100], STATUS_AND_NAV_BAR_HEIGHT-[ccui getRH:40], [ccui getRH:100], [ccui getRH:40])];
    [self.UD_navigationBarView addSubview:addNewBt];
    [addNewBt setTitle:@"创建新角色" forState:UIControlStateNormal];
    addNewBt.titleLabel.font = [ccui getRFS:14];
    [addNewBt setTitleColor:UIColorFromHexStr(@"2A6FE0") forState:UIControlStateNormal];
    [addNewBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        [self requestCreateRole];
    }];
}
- (void)prePopAction{
    [[CC_CodeLib getRootNav] dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)creatUI{
    _displayV=[self setUdDisplayView];
    UIImageView* noticeImgV = [[UIImageView alloc]initWithFrame:CGRectMake([ccui getRH:15], [ccui getRH:15], [ccui getRH:15], [ccui getRH:15])];
    noticeImgV.image = [UIImage imageNamed:@"kk_role_notice" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    [_displayV addSubview:noticeImgV];
    
    UILabel* noticeLb = [[UILabel alloc]initWithFrame:CGRectMake([ccui getRH:40], [ccui getRH:5], [ccui getRH:300], [ccui getRH:35])];
    noticeLb.text = @"选择后，您可在“我的”菜单切换角色";
    noticeLb.textColor = UIColorFromHexStr(@"666666");
    noticeLb.font = [ccui getRFS:14];
    [_displayV addSubview:noticeLb];
    
    _roleTab = [[UITableView alloc]initWithFrame:CGRectMake(0, noticeLb.bottom+[ccui getRH:5], SCREEN_WIDTH, 0)];
    _roleTab.delegate=self;
    _roleTab.dataSource=self;
    _roleTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_displayV addSubview:_roleTab];
}
- (void)creatUI_roles{
    
    float height=[ccui getRH:50]*_roleMutArr.count;
    float maxHeight=[ccui getH]-self.udNavBarHeight-[ccui getRH:150];
    if (height>maxHeight) {
        height=maxHeight;
    }
    _roleTab.height=height;
    [_roleTab reloadData];
    
    _defaultBt = [[CC_Button alloc]initWithFrame:CGRectMake([ccui getRH:15], _roleTab.bottom+[ccui getRH:15], [ccui getRH:15], [ccui getRH:15])];
    [_defaultBt setBackgroundImage:[UIImage imageNamed:@"kk_regiest_agree_protocol" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
    [_defaultBt setBackgroundImage:[UIImage imageNamed:@"kk_regiest_unagree_protocol" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    _defaultBt.selected=YES;
    [_displayV addSubview:_defaultBt];
    
    UILabel* defaultLb = [[UILabel alloc]initWithFrame:CGRectMake([ccui getRH:40], _roleTab.bottom+[ccui getRH:16], [ccui getRH:150], [ccui getRH:15])];
    defaultLb.text = @"默认使用该角色登录";
    defaultLb.textColor = UIColorFromHexStr(@"666666");
    defaultLb.font = [ccui getRFS:14];
    [_displayV addSubview:defaultLb];
    
    CC_Button* defaultTapBt = [[CC_Button alloc]initWithFrame:CGRectMake([ccui getRH:15], _roleTab.bottom+[ccui getRH:5], [ccui getRH:200], [ccui getRH:30])];
    [_displayV addSubview:defaultTapBt];
    
    __weak typeof(self) weakSelf = self;
    [defaultTapBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        weakSelf.defaultBt.selected=!weakSelf.defaultBt.selected;
    }];
    
    CC_Button* loginBt = [[CC_Button alloc]initWithFrame:CGRectMake([ccui getRH:20], defaultLb.bottom+[ccui getRH:30], SCREEN_WIDTH-[ccui getRH:40], [ccui getRH:40])];
    [CC_CodeClass setBoundsWithRadius:20 view:loginBt];
    [loginBt setBackgroundColor:UIColorFromHexStr(@"FF0000")];
    [_displayV addSubview:loginBt];
    [loginBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        [self requestLogin];
    }];
    
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
}
#pragma mark - network
- (void)requestCreateRole{
    CCRoleCreateVC *create=[[CCRoleCreateVC alloc]init];
    
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
    [[UserStateManager shareInstance].authTask post:[CCLoginConfig loginHeadUrl] params:para model:nil finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        
        [HUD stop];
        if (error) {
            [CC_NoticeView showError:error atView:weakSelf.view];
        }else{
            weakSelf.roleMutArr=[[NSMutableArray alloc]initWithArray:resmodel.resultDic[@"response"][@"userSelectInfo"][@"userSimples"]];
            [weakSelf creatUI_roles];
        }
    }];
}
- (void)requestLogin{
    if (_VCType==RoleEnterLogin) {
        [CCRoleRequest requestLoginSelectedLoginUserId:_roleMutArr[_selectedIndex][@"userId"] resetDefaultUser:_defaultBt.selected controller:self type:LoginTypeLogin];
    }else if(_VCType == RoleEnterSwitch){
        
        [CCRoleRequest requestLoginSelectedLoginUserId:_roleMutArr[_selectedIndex][@"userId"] resetDefaultUser:_defaultBt.selected controller:self type:LoginTypeSwitch];
    }
    
}
#pragma mark - delegate
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
    CCRoleSelectTableVCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CCRoleSelectTableVCell alloc]
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
#pragma mark - property

@end
