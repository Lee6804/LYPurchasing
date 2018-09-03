//
//  LYHttpTool.m

//
//  Created by  on 16/8/19.
//  Copyright © 2016年  All rights reserved.
//

#import "LYHttpTool.h"

@interface LYHttpTool()<UIAlertViewDelegate>

@end

@implementation LYHttpTool

static LYHttpTool *httpRequest = nil;

+ (LYHttpTool *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (httpRequest == nil) {
            httpRequest = [[self alloc] init];
        }
    });
    return httpRequest;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (httpRequest == nil) {
            httpRequest = [super allocWithZone:zone];
        }
    });
    return httpRequest;
}
- (instancetype)copyWithZone:(NSZone *)zone
{
    return httpRequest;
}

/**
 *  get网络请求
 *
 *  @param url     请求透
 *  @param params  请求体
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSMutableArray *signArr = [[LYMethod sortArr:[params mutableCopy]] mutableCopy];
    NSString *timeStampStr = [LYMethod getCurrentTimeStamp];
    NSString *randomNum = [NSString stringWithFormat:@"%06d",arc4random() % 100000];
    NSString *requestId = [NSString stringWithFormat:@"%@%@",timeStampStr,randomNum];
    [signArr addObject:[NSString stringWithFormat:@"requestId=%@",requestId]];
    [signArr addObject:@"singKey=aaaaa!@#$%^&*"];
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer setValue:[LYMethod md5To32bit:[signArr componentsJoinedByString:@"&"]] forHTTPHeaderField:@"sign"];
    [manager.requestSerializer setValue:requestId forHTTPHeaderField:@"requestId"];
    //申明返回的结果是json类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    //发送网络请求(请求方式为GET)
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 *  post网络请求
 *
 *  @param url     请求头
 *  @param params  请求体
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    /*
    NSMutableArray *signArr = [[PhoneInfo sortArr:[params mutableCopy]] mutableCopy];
    NSString *timeStampStr = [PhoneInfo getCurrentTimeStamp];
    NSString *randomNum = [NSString stringWithFormat:@"%06d",arc4random() % 100000];
    NSString *requestId = [NSString stringWithFormat:@"%@%@",timeStampStr,randomNum];
    [signArr addObject:[NSString stringWithFormat:@"requestId=%@",requestId]];
    [signArr addObject:@"signKey=aaaaa!@#$%^&*"];
     */
//    NSLog(@"%@--%@",[signArr componentsJoinedByString:@"&"],[PhoneInfo md5To32bit:[signArr componentsJoinedByString:@"&"]]);
    
    NSLog(@"%@",params);
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    /*
    [manager.requestSerializer setValue:[PhoneInfo md5To32bit:[signArr componentsJoinedByString:@"&"]] forHTTPHeaderField:@"sign"];
    [manager.requestSerializer setValue:requestId forHTTPHeaderField:@"requestId"];
    */
    //申明返回的结果是json类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    //发送网络请求(请求方式为POST)
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 异步POST请求:以body方式,

 @param url url
 @param params params
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)postWithBody:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSMutableArray *signArr = [[LYMethod sortArr:[params mutableCopy]] mutableCopy];
    NSString *timeStampStr = [LYMethod getCurrentTimeStamp];
    NSString *randomNum = [NSString stringWithFormat:@"%06d",arc4random() % 100000];
    NSString *requestId = [NSString stringWithFormat:@"%@%@",timeStampStr,randomNum];
    [signArr addObject:[NSString stringWithFormat:@"requestId=%@",requestId]];
    [signArr addObject:@"signKey=aaaaa!@#$%^&*"];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    request.timeoutInterval= 5;
    [request setHTTPBody:[[LYMethod convertToJSONData:params] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:[LYMethod md5To32bit:[signArr componentsJoinedByString:@"&"]] forHTTPHeaderField:@"sign"];
    [request setValue:requestId forHTTPHeaderField:@"requestId"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            success(responseObject);
        } else {
            failure(error);
        }
    }] resume];
}

/**
 上传图片文件
 
 @param url url
 @param type image/video
 @param params params
 @param data data
 @param progress uploadProgress
 @param success successBlock
 @param failure failureBlock
 */
+ (void)uploadFiles:(NSString *)url type:(NSString *)type params:(NSDictionary *)params data:(NSData *)data progress:(void (^)(id uploadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    NSMutableArray *signArr = [[LYMethod sortArr:[params mutableCopy]] mutableCopy];
    NSString *timeStampStr = [LYMethod getCurrentTimeStamp];
    NSString *randomNum = [NSString stringWithFormat:@"%06d",arc4random() % 100000];
    NSString *requestId = [NSString stringWithFormat:@"%@%@",timeStampStr,randomNum];
    [signArr addObject:[NSString stringWithFormat:@"requestId=%@",requestId]];
    [signArr addObject:@"signKey=aaaaa!@#$%^&*"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[LYMethod md5To32bit:[signArr componentsJoinedByString:@"&"]] forHTTPHeaderField:@"sign"];
    [manager.requestSerializer setValue:requestId forHTTPHeaderField:@"requestId"];
    //设置接收类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",@"multipart/form-data",nil];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        NSString *fileNameType = [type isEqualToString:@"image"] ? @"%@.jpg" : @"%@.mp4";
        //        NSString *fileName = [NSString stringWithFormat:fileNameType, dateStr];
        NSString *fileName = [NSString stringWithFormat:@"%@%@",dateStr,fileNameType];
        //上传的参数(上传图片，以文件流的格式)
        NSString *mimeType = [type isEqualToString:@"image"] ? @"image/jpeg" : @"video/mp4";
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:fileName
                                mimeType:mimeType];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //上传成功
        success(responseObject);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
        failure(error);
    }];
}

// 判断网络类型
+ (void)getNetworkStates
{
    //创建网络监听管理者对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,//未识别的网络
     AFNetworkReachabilityStatusNotReachable     = 0,//不可达的网络(未连接)
     AFNetworkReachabilityStatusReachableViaWWAN = 1,//2G,3G,4G...
     AFNetworkReachabilityStatusReachableViaWiFi = 2,//wifi网络
     };
     */
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
//                [LYProgressHUD showWarn:@"未识别的网络"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"不可达的网络(未连接)");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络连接失败，请检测网络是否打开~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"2G,3G,4G...的网络");
//                if ([UserDefault objectForKey:@"NetworkStatus"]) {
//                    [LYProgressHUD showWarn:@"已连接到移动数据网络"];
//                    [UserDefault removeObjectForKey:@"NetworkStatus"];
//                }
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"wifi的网络");
//                [UserDefault setObject:@"wifi" forKey:@"NetworkStatus"];
            }
                break;
            default:
                break;
        }
    }];
    
    //开始监听
   [manager startMonitoring];
}

+(NSString *)getNetWorkStatesNameStr{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc] init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (netType) {
                case 0:
                    state = @"无网络"; //无网模式
                break;
                    
                case 1:
                    state = @"2G";
                break;
                    
                case 2:
                    state = @"3G";
                break;
                    
                case 3:
                    state = @"4G";
                break;
                    
                case 5: {
                    state = @"wifi";
                    break;
                    
                    default:
                    break;
                }
            }
        }
    }
    //根据状态选择
    return state;
}

@end
