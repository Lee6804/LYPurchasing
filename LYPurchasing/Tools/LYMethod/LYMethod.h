//
//  LYMethod.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface LYMethod : NSObject

/**
 *  手机 OpenUUID
 *
 *  @return 手机 OpenUUID
 */
+(NSString *)getIMEI;


/**
 MD5加密
 
 @return MD5加密字符串
 */
+ (NSString *)md5To32bit:(NSString *)str;

/**
 获取当前时间
 
 @return 当前时间
 */
+(NSString*)getCurrentTimes;

/**
 根据date获取时间
 
 @param date date
 @return 时间
 */
+(NSString*)getTimesWithDate:(NSDate *)date;


/**
 获取当前时间戳
 
 @return 当前时间戳
 */
+(NSString *)getCurrentTimeStamp;



/**
 时间戳转换成时间
 
 @return 时间戳
 */
+ (NSString *)getTimeFromTimestamp;


/**
 获取日期对应的星期
 
 @param inputDate 时间
 @return 星期
 */
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/**
 获取星座
 
 @param m_ 月
 @param d_ 日
 @return 星座
 */
+(NSString *)getConstellationWithMonth:(int)m_ day:(int)d_;


/**
 根据当前时间得到年龄多少岁
 
 @param birthDate 选择的时间
 @return 岁数
 */
+(int)getAge:(NSDate *)birthDate;

/**
 容错处理  将返回为null的对象置换成空string
 
 @param obj 某个位置对象
 @return 为null则返回空string 反之取其本身
 */
+(NSString *)changeNullToEmptyWithObj:(id)obj;


/**
 *  ** 在当前日期时间加上 某个时间段(传负数即返回当前时间之前x月x日的时间)
 *
 *  @param year   当前时间若干年后 （传负数为当前时间若干年前）
 *  @param month  当前时间若干月后  （传0即与当前时间一样）
 *  @param day    当前时间若干天后
 *  @param hour   当前时间若干小时后
 *  @param minute 当前时间若干分钟后
 *  @param second 当前时间若干秒后
 *
 *  @return 处理后的时间字符串
 */
+(NSString *)dateStringAfterlocalDateForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second;

//传入 秒 得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

/**
 获取lable宽高
 
 @param lessWidth 两边距和
 @param str 字符串
 @return size
 */
+ (CGRect)getSize:(CGFloat)lessWidth str:(NSString *)str;

// 读取本地JSON文件
+ (id)readLocalFileWithName:(NSString *)name;

//字典转Json字符串
+ (NSString*)convertToJSONData:(id)infoDict;

//JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//数组转json
+ (NSString *)arrayToJSONString:(NSArray *)array;

//将时间后面截取掉用0补齐
+ (NSString *) changeTimeWithZero:(NSString *)string;
//将时间后面加至23:59:59
+ (NSString *) changeTimeToBig:(NSString *)string;

//拨打电话
+ (void)callTelephone:(NSString *)phoneNum;

//邮箱验证
+ (BOOL)validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;

//密码验证 8~16位数字+字母
+ (BOOL)validatePassword:(NSString *)passWord;

//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

//字典按照ASCII码升序排列后（key=value）加入数组
+ (NSArray *)sortArr:(NSMutableDictionary*)dict;

/**清除缓存和cookie*/
+ (void)cleanCacheAndCookie;

//SD缓存
+ (NSString *)caCheSize;


/**
 切圆角
 
 @param corners 方位角
 @param cornerRadii 圆角大小
 @param frame 视图frame
 @return 处理之后的shapeLayer
 */
+ (CAShapeLayer *)dealWithViewCorner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii viewFrame:(CGRect)frame;

@end
