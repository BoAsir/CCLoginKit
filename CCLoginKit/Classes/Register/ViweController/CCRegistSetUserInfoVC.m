//
//  CCRegistSetUserInfoVC.m
//  CCTribe
//
//  Created by lidaoyuan on 2018/7/16.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "CCRegistSetUserInfoVC.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "DPImageSelectVC.h"
#import "ALAsset+DPSelectImage.h"
#import "CCLoginVC.h"

@interface CCRegistSetUserInfoVC ()
@property (nonatomic, strong) UIImageView *uploadPortraitImg;
@property (nonatomic, strong) UIImageView *addIcon;
@property (nonatomic, strong) UITextField *nickNameTF;

@property (nonatomic, strong) UIButton *maleSelectButton;
@property (nonatomic, strong) UIButton *femaleSelectButton;
@property (nonatomic, strong) UIImageView *sexSelectIcon;
@property (nonatomic, strong) CC_Button *confirmButton;

@property (nonatomic, strong) NSString *sexStr ;
@property (nonatomic, strong) NSString *imageUploadStr ;
@property (nonatomic, strong) NSData *imageData ;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end

@implementation CCRegistSetUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUserDefinedNavigationBar];
    _imageUploadStr = @"NO" ;
    [self setUdNavBarTitle:@"注册"];
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    [self creatUI];
    
}
-(void)creatUI{
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    // 上传头像
    _uploadPortraitImg = [[UIImageView alloc] init];
    _uploadPortraitImg.frame = CGRectMake(0,STATUS_AND_NAV_BAR_HEIGHT + [ccui getRH:40], 100, 100);
    _uploadPortraitImg.left = SCREEN_WIDTH/2 - _uploadPortraitImg.width/2;
    _uploadPortraitImg.image = [UIImage imageNamed:@"kk_regist_upload_portrait_image"] ;
    _uploadPortraitImg.userInteractionEnabled = YES ;
    [self.view addSubview:_uploadPortraitImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(speechTapped:)];
    _uploadPortraitImg.clipsToBounds = YES ;
    _uploadPortraitImg.layer.cornerRadius = 50 ;
    [_uploadPortraitImg addGestureRecognizer:tap];
    
    _addIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    _addIcon.center = CGPointMake(_uploadPortraitImg.right - 15, _uploadPortraitImg.bottom - 15);
    _addIcon.image = [UIImage imageNamed:@"kk_regist_upload_portrait_image_add"];
    [self.view addSubview:_addIcon];
    
    NSDictionary *attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0x999999), NSFontAttributeName:[ccui getRFS:15]};
    
    // 昵称
    _nickNameTF =  [[UITextField alloc]initWithFrame:CGRectMake([ccui getRH:40], _uploadPortraitImg.bottom + [ccui getRH:25], SCREEN_WIDTH - 2*[ccui getRH:40], [ccui getRH:35])];
    _nickNameTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入昵称" attributes:attribute];
    _nickNameTF.backgroundColor = [UIColor clearColor];
    [_nickNameTF addTarget:self action:@selector(nickNameTFDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_nickNameTF];
    
    //分割线
    UIView *separateLine = [[UIView alloc]initWithFrame:CGRectMake(_nickNameTF.left, _nickNameTF.bottom + 2, _nickNameTF.width, 1)];
    separateLine.backgroundColor = UIColorFromRGB(0xe2e2e2);
    [self.view addSubview:separateLine];
    
    UILabel *chooseSexLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nickNameTF.left, separateLine.bottom + 5 , 150,[ccui getRH:30])];
    chooseSexLabel.textAlignment = NSTextAlignmentLeft;
    chooseSexLabel.attributedText = [[NSAttributedString alloc]initWithString:@"请选择你的性别" attributes:attribute];
    [self.view addSubview:chooseSexLabel];
    
    //男性
    _maleSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _maleSelectButton.frame = CGRectMake([ccui getRH:80],chooseSexLabel.bottom + [ccui getRH:39], [ccui getRH:90], [ccui getRH:90]);
    _maleSelectButton.right = SCREEN_WIDTH/2 - [ccui getRH:25];
    [_maleSelectButton setImage:[UIImage imageNamed:@"icon_regist_upload_male_unselected"] forState:UIControlStateNormal];
    [_maleSelectButton setImage:[UIImage imageNamed:@"icon_regist_upload_male_selected"] forState:UIControlStateSelected];
    [_maleSelectButton addTarget:self action:@selector(maleSelectButtonClick:)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_maleSelectButton];
    
    // 选择女性
    _femaleSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _femaleSelectButton.frame = CGRectMake(SCREEN_WIDTH/2 + [ccui getRH:25],_maleSelectButton.top, _maleSelectButton.width, _maleSelectButton.height);
    [_femaleSelectButton setImage:[UIImage imageNamed:@"icon_regist_upload_female_unselected"] forState:UIControlStateNormal];
    [_femaleSelectButton setImage:[UIImage imageNamed:@"icon_regist_upload_female_selected"] forState:UIControlStateSelected];
    [_femaleSelectButton addTarget:self action:@selector(femaleSelectButtonClick:)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_femaleSelectButton];
    
    
    
    _sexSelectIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [ccui getRH:20], [ccui getRH:20])];
    _sexSelectIcon.image = [UIImage imageNamed:@"kk_regist_sex_select"];
    _sexSelectIcon.hidden = YES;
    [self.view addSubview:_sexSelectIcon];
    
    
    [self maleSelectButtonClick:_maleSelectButton];
    
    _confirmButton = [CC_Button buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = CGRectMake([ccui getRH:25], _maleSelectButton.bottom + [ccui getRH:40], SCREEN_WIDTH - [ccui getRH:50], [ccui getRH:40]);
    _confirmButton.backgroundColor = UIColorFromRGB(0xfe5454);
    [_confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [_confirmButton setTitle:@"完成注册" forState:UIControlStateNormal];
    _confirmButton.layer.cornerRadius = _confirmButton.height/2;
    _confirmButton.layer.masksToBounds = YES;
    WS(weakSelf);
    [_confirmButton addTappedOnceDelay:4 withBlock:^(UIButton *button) {
        [weakSelf confirmButtonClick:button];
    }];
    [self.view addSubview:_confirmButton];
}

#pragma mark - target
-(void)nickNameTFDidChanged:(UITextField *)tf{
    
}
-(void)speechTapped:(UIGestureRecognizer *) gesture{
    [self setUpPicker] ;
}
-(void)uploadPortraitButtonClick:(UIImage *)images{
    UIImage * image =images;
    _imageData =UIImageJPEGRepresentation(image,1);
    UIImage *newiamge=[UIImage imageWithData:_imageData];
    _uploadPortraitImg.image = newiamge ;
    _imageUploadStr = @"YES" ;
}

-(void)maleSelectButtonClick:(UIButton *)sender{
    _sexSelectIcon.hidden = NO;
    _sexSelectIcon.center = CGPointMake(sender.right - [ccui getRH:15], sender.top + [ccui getRH:15]);
    _sexStr = @"F" ;
}

-(void)femaleSelectButtonClick:(UIButton *)sender{
    _sexSelectIcon.hidden = NO;
    _sexSelectIcon.center = CGPointMake(sender.right - [ccui getRH:15], sender.top + [ccui getRH:15]);
    _sexStr = @"M" ;
}

-(void)confirmButtonClick:(UIButton *)sender{
    
    NSString *nameStr = _nickNameTF.text ;
    if (nameStr.length<=0) {
        [CC_Note showAlert:@"请输入昵称"];
        return;
    }
    
    MaskProgressHUD *HUD = [MaskProgressHUD hudStartAnimatingAndAddToView:self.view];
    HUD.titleStr =@"注册中";
    
    NSMutableDictionary * Customer = [[NSMutableDictionary alloc] init];
    [Customer setObject:@"REGISTER" forKey:@"service"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStringUTF8 = [nameStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * string =[NSString stringWithFormat:@"%@service=REGISTER&verifyPassword=%@&verifyCellSign=%@&randomString=%@&sex=%@&imageUpload=%@&password=%@&cell=%@&nickName=%@&checkCode=%@&from=registeredrole_next_sure_null_null_null&to=columnlist",[CCLoginConfig loginHeadUrl],self.password,self.verifyCellSign,self.randomString,_sexStr,_imageUploadStr,self.password,self.cell,urlStringUTF8,self.smsIdString];
    WS(weakSelf);
    [manager POST:string parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        //上传的参数(上传图片，以文件流的格式)
        if (weakSelf.imageData) {
            [formData appendPartWithFileData:weakSelf.imageData
                                        name:@"image"
                                    fileName:fileName
                                    mimeType:@"image/jpg"];
        }
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //上传成功
        [HUD stop];
        
        NSDictionary * dic =responseObject;
        
        if ([dic[@"response"][@"success"] boolValue]) {
            [CC_NoticeView showError:[NSString stringWithFormat:@"注册成功"]];
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [weakSelf.nickNameTF resignFirstResponder];
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[CCLoginVC class]]) {
                        CCLoginVC *loginVc = (CCLoginVC *)vc;
                        [loginVc loginrequestCell:weakSelf.cell andPwd:weakSelf.password fromRegister:YES];
                    }
                }
            });
        } else {
            [CC_NoticeView showError:dic[@"response"][@"error"][@"message"]];
        }
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
        [HUD stop];
        [CC_NoticeView showError:@"注册失败"];
    }];
}
//设置头像
- (void)setUpPicker {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"本应用无访问照片的权限，如需访问，可在设置中修改" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return;
    }
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] &&
         [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])) {
        __weak typeof(self) weakSelf = self;
        [self loadAssetsGroup:^(NSArray *assetsGroups) {
            
            DPImageSelectVC *imagePickerController = [[DPImageSelectVC alloc] init];
            imagePickerController.assertsGroupArray = assetsGroups;
            imagePickerController.isFromPersonal = YES;
            
            [imagePickerController setSelectFinishHandle:^(BOOL isCanceled, BOOL isCamera, NSArray *assets) {
                if (!isCanceled) {
                    if (!isCamera) {
                    } else {
                        if (assets) {
                            [weakSelf uploadPortraitButtonClick:[assets lastObject]];
                        }
                    }
                }
            }];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
            [weakSelf presentViewController:navigationController animated:YES completion:NULL];
            
        }];
    }
}
#pragma mark - 获取相册数据
- (void)loadAssetsGroup:(void (^)(NSArray *assetsGroups))completion {
    NSArray *groupTypes = @[ @(ALAssetsGroupSavedPhotos),
                             @(ALAssetsGroupPhotoStream),
                             @(ALAssetsGroupAlbum) ];
    
    __block NSMutableArray *assetsGroups = [NSMutableArray array];
    __block NSUInteger numberOfFinishedTypes = 0;
    
    for (NSNumber *type in groupTypes) {
        [self.assetsLibrary enumerateGroupsWithTypes:[type unsignedIntegerValue]
                                          usingBlock:^(ALAssetsGroup *assetsGroup, BOOL *stop) {
                                              
                                              if (assetsGroup) {
                                                  // Filter the assets group
                                                  [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
                                                  
                                                  if (assetsGroup.numberOfAssets > 0) {
                                                      // Add assets group
                                                      [assetsGroups addObject:assetsGroup];
                                                  }
                                              } else {
                                                  numberOfFinishedTypes++;
                                              }
                                              
                                              // Check if the loading finished
                                              if (numberOfFinishedTypes == groupTypes.count) {
                                                  // Sort assets groups
                                                  NSArray *sortedAssetsGroups = [self sortAssetsGroups:(NSArray *)assetsGroups typesOrder:groupTypes];
                                                  
                                                  // Call completion block
                                                  if (completion) {
                                                      completion(sortedAssetsGroups);
                                                  }
                                              }
                                          }
                                        failureBlock:^(NSError *error) {
                                            BBLOG (@"Error: %@", [error localizedDescription]);
                                        }];
    }
}
#pragma mark - 对相册进行排序
- (NSArray *)sortAssetsGroups:(NSArray *)assetsGroups typesOrder:(NSArray *)typesOrder {
    NSMutableArray *sortedAssetsGroups = [NSMutableArray array];
    
    for (ALAssetsGroup *assetsGroup in assetsGroups) {
        if (sortedAssetsGroups.count == 0) {
            [sortedAssetsGroups addObject:assetsGroup];
            continue;
        }
        
        ALAssetsGroupType assetsGroupType = [[assetsGroup valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
        NSUInteger indexOfAssetsGroupType = [typesOrder indexOfObject:@(assetsGroupType)];
        
        for (NSInteger i = 0; i <= sortedAssetsGroups.count; i++) {
            if (i == sortedAssetsGroups.count) {
                [sortedAssetsGroups addObject:assetsGroup];
                break;
            }
            
            ALAssetsGroup *sortedAssetsGroup = sortedAssetsGroups[i];
            ALAssetsGroupType sortedAssetsGroupType = [[sortedAssetsGroup valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
            NSUInteger indexOfSortedAssetsGroupType = [typesOrder indexOfObject:@(sortedAssetsGroupType)];
            
            if (indexOfAssetsGroupType < indexOfSortedAssetsGroupType) {
                [sortedAssetsGroups insertObject:assetsGroup atIndex:i];
                break;
            }
        }
    }
    
    return [sortedAssetsGroups copy];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES] ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
