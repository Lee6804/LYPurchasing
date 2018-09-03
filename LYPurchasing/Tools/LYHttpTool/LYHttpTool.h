//
//  LYHttpTool.h
//
//  Created by  on 16/8/19.
//  Copyright © 2016年 All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LYHttpTool : NSObject


+ (LYHttpTool *)sharedInstance;

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)postWithBody:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)uploadFiles:(NSString *)url type:(NSString *)type params:(NSDictionary *)params data:(NSData *)data progress:(void (^)(id uploadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

// 判断网络类型
+(void)getNetworkStates;
// 获取具体网络名称
+(NSString *)getNetWorkStatesNameStr;


@end
