//
//  AppDelegate.m
//  LocalDataDemo
//
//  Created by shen on 15/10/26.
//  Copyright © 2015年 shen. All rights reserved.
//

#import "AppDelegate.h"
#import "SCAppCache.h"
#import "CHKeychain.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //本地NSString缓存举例
    [SCAppCache setStoreValue:@"hangzhou" forKey:StoreKeyCityId];
    NSLog(@"%@",[SCAppCache storeValueForKey:StoreKeyCityId]);
    
    //本地对象的缓存同上，自己定义一个类就行
    NSDictionary *dic=@{@"key1":@"value1"};
    [SCAppCache setStoreObject:dic forKey:ObjectKeyMember];
    
    
    NSDictionary *localDic=(NSDictionary *)[SCAppCache storeObjectForKey:ObjectKeyMember];
    NSLog(@"%@",[localDic objectForKey:@"key1"]);
    
    [self GetUUID];
    return YES;
}

#pragma mark--获取设备UUID
-(NSString*)GetUUID{
    //根据key获得
    if ([CHKeychain load:@"DEVICE_UUID"]) {
        NSString *result = [CHKeychain load:@"DEVICE_UUID"];
        NSLog(@"已存在手机UUID：%@",result);
        return result;
    }
    else
    {
        CFUUIDRef puuid = CFUUIDCreate(nil);
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        [CHKeychain save:@"DEVICE_UUID" data:result];
        NSLog(@"初次创建手机UUID：%@",result);
        return result;
    }
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
