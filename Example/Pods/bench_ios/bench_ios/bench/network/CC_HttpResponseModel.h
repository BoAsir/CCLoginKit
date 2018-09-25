//
//  CC_HttpResponseModel.h
//  bench_ios
//
//  Created by gwh on 2018/3/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResModel : NSObject

/**
 *  在线下debug配置1，错误会弹窗提示打印，会根据服务名缓存上一次成功的数据，会记录成功的请求列表
 */
@property(nonatomic,assign) BOOL debug;


/**
 *  请求接口的服务名
 */
@property(nonatomic,retain) NSString *serviceStr;
/**
 *  请求的头、域名
 */
@property(nonatomic,retain) NSString *requestUrlStr;
/**
 *  完整的请求链接
 */
@property(nonatomic,retain) NSString *requestStr;


/**
 *  响应结果
 *  响应的字符串
 */
@property(nonatomic,retain) NSString *resultStr;
/**
 *  响应结果
 *  响应的json字符串装换成字典
 */
@property(nonatomic,retain) NSDictionary *resultDic;

/**
 *  英文错误
 */
@property(nonatomic,retain) NSString *errorNameStr;
/**
 *  中文错误
 */
@property(nonatomic,retain) NSString *errorMsgStr;


/**
 *  响应时间显示格式
 */
@property(nonatomic,retain) NSString *responseDateFormatStr;
/**
 *  响应的时间
 *  Thu, 19 Apr 2018 02:18:39 GMT
 */
@property(nonatomic,retain) NSDate *responseDate;

- (void)parsingError:(NSError *)error;
- (void)parsingResult:(NSString *)resultStr;

@end
