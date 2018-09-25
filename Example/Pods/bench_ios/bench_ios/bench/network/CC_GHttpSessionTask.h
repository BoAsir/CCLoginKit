//
//  GHttpSessionTask.h
//  NSURLSessionTest
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 apple. All rights reserved.
//

/*
 需求：
 1、配置http头
    setHttpHeader
 2、登录成功后配置signKeyStr，额外参数extreDic
 3、添加其他地方登录回调
 */

#import <Foundation/Foundation.h>
#import "CC_HttpResponseModel.h"

@interface CC_HttpTask : NSObject<NSURLSessionDelegate>{
    void (^finishCallbackBlock)(NSString *errorStr, ResModel *model); // 执行完成后回调的block
}

+ (instancetype)getInstance;

/**
 *  不传时间戳字段
 */
@property(nonatomic,assign) BOOL forbiddenTimestamp;

/**
 *  不传埋点路径操作数据
 */
@property(nonatomic,assign) BOOL forbiddenSendHookTrack;

/**
 *  获取 根据response里返回的http头部的时间 即服务端相应发送时间
 */
@property(nonatomic,assign) BOOL needResponseDate;

/**
 *  设置http请求头部
 */
@property(nonatomic,retain) NSDictionary *requestHTTPHeaderFieldDic;

/**
 *  设置登录后拿到的signKey
 */
@property(nonatomic,retain) NSString *signKeyStr;

/**
 *  设置一次 额外的 每个接口都要发送的数据
 *  可放入 比如 authedUserId timestamp
 */
@property(nonatomic,retain) NSDictionary *extreDic;

/**
 *  超时时间
 */
@property(nonatomic,assign) NSTimeInterval httpTimeoutInterval;

@property(strong) void (^finishCallbackBlock)(NSString *error,ResModel *result);
/**
 *  设置通用响应结果特殊处理回调集合
 */
@property(nonatomic,retain) NSMutableDictionary *logicBlockMutDic;

/**
 *  添加额外参数
 */
- (void)addExtreDic:(NSDictionary *)dic;

/**
 * url NSString 或者 NSURL
 * paramsDic的关键字
 * getDate 可以获取时间
 */
- (void)post:(id)url params:(id)paramsDic model:(ResModel *)model finishCallbackBlock:(void (^)(NSString *, ResModel *))block;
- (void)get:(id)url params:(id)paramsDic model:(ResModel *)model finishCallbackBlock:(void (^)(NSString *, ResModel *))block;

/**
 *  设置通用响应结果特殊处理回调逻辑
 *  logicName  给这个逻辑处理起一个名字
 *  logicStr  判断条件语句  提供两种判断
    可连续配置多种不同的特殊处理回调逻辑用‘,’分隔嵌套字段
    1 根据响应某字段aaa=bbb   如response,error=third
    2 根据响应有无某字段aaa    如response,error
 *  stop 是否立即停止只跑回调方法 即正常的回调不再回调过去
    应用场景：弹出其他地方登录后 黑底白字的提示不用弹 统一不回调回去 stop=YES
 *  popOnce 是否只回调一次
    应用场景：进入一个页面连续调3个接口 3个接口回调都会报在其他地方登录 只要一次回调弹窗提示 需要过滤其他两个时 popOnce=YES
 *  logicBlock 符合条件后的回调，回调的逻辑，需要在appDelegate里配置
 *
 *  例子:
 *  [[CC_HttpTask getInstance] addResponseLogic:@"PARAMETER_ERROR" logicStr:@"response,error,name=PARAMETER_ERROR" stop:YES popOnce:YES logicBlock:^(NSDictionary *resultDic) {
    //在这里添加处理代码
    }];
 */
- (void)addResponseLogic:(NSString *)logicName logicStr:(NSString *)logicStr stop:(BOOL)stop popOnce:(BOOL)popOnce logicBlock:(void (^)(NSDictionary *resultDic))block;
/**
 *  logicName  添加时起的名字
 *  重置只回调一次的设置
 *  应用场景：其他地方登陆后点确定后需重置 因为下一次调就又要弹窗了
 *
 *  例子：
 *  [[CC_HttpTask getInstance]resetResponseLogicPopOnce:@"PARAMETER_ERROR"];
 */
- (void)resetResponseLogicPopOnce:(NSString *)logicName;

@end
