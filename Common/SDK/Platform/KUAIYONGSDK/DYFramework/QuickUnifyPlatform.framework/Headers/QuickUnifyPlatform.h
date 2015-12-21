//
//  QuickUnifyPlatform.h
//  QuickUnifyPlatform
//
//  Created by yuhao on 15/7/13.
//  Copyright (c) 2015年 QuickCompany All rights reserved.
//  SDK Ver 1.0.0

#import <UIKit/UIKit.h>
#import "QuickProductInfo.h"
#import "QuickConstant.h"
#import "QuickPlatformName.h"

//qupOnPause 没有接入显示弹窗，qupHandleWithapplication没有接入显示弹窗

#define QUPLog(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

@interface QuickUnifyPlatform : NSObject


+(id)getInstance;

//以下接口必须接入(1,2,3,4,5,6)
/**
 *  1.初始化,require
 *
 */
-(void)qupInit;

/**
 *  2.登陆,require
 *
 */

-(void)qupLogin;

/**
 *  3.注销账户,require
 *
 */
-(void)qupLogout;

/**
 *  4.支付,require
 *
 */

-(void)qupPayWithProductInfo:(QuickProductInfo*)productInfo;

/**
 *  5.程序暂停,optional,在- (void)applicationWillEnterForeground:(UIApplication *)application中调用,没有此方法，不用任何处理。
 */
-(void)qupOnPause;

/**
 *  6.处理支付宝回调数据,optional,在application openURL中调用
 */
-(void)qupHandleWithapplication:(id)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;



//以下接口可选接入(7,8,9,10,11,12,13)
/**
 *  7.显示个人中心,optional,主动调用时候，SDK没有此方法时候自己处理
 */
- (void)qupShowCenter;

/*
 *  8.默认显示,隐藏工具图标,optional,主动调用时候，SDK没有此方法时候自己处理
 */
- (void)qupHideToolBar:(BOOL)hidden;

/**
 *  9.显示用户信息,require,可以判读不为空代表用户已经登录过SDK，不一定是SDK现在的登录状态。
 *  uid
 *  session
 */
- (NSDictionary *)qupUserInfo;

/**
 *  10.显示平台配置信息,require
 */
- (NSDictionary *)qupSettingInfo;

/**
 *  11.获取SDK的版本,require
 */
- (NSString *)qupSDKVersion;

/**
 *  12.获取Quick封装的名称,require,实际值为平台编号
 */
- (QuickPlatformName)qupPlatformName;

/**
 *  13.判断方法在平台的SDK中是否存在,require,此方法适用于其他optional方法。
 */
- (BOOL)qupRespondsToSelector:(SEL)platformSel;


//一下系统调用，用户不可调用。(14,15)
/**
 *  14.是否显示日志,在plist配置文件里的islog体现
 */
- (BOOL)qupIsOpenLog;

/**
 *  15.显示平台的信息,字符串无规律。
 */
- (NSString *)qupPlatformInfo;

@end