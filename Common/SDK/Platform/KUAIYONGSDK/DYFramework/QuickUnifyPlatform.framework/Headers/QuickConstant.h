//
//  QuickConstant.h
//  QuickConstant
//
//  Created by yuhao on 14-4-15.
//  Copyright (c) 2014年 QuickCompany All rights reserved.
//

#ifndef QuickUnifyPlatform_QUPConstant_h
#define QuickUnifyPlatform_QUPConstant_h

#import <Foundation/Foundation.h>

//验证URL
extern NSString * const kQUPLoginURL;
extern NSString * const kQUPSignLoginURL;
extern NSString * const kQUPOrderURL;
extern NSString * const kQUPPlistURL;

//调试验证URL
extern NSString * const kQUPDebugLoginURL;
extern NSString * const kQUPDebugSignLoginURL;
extern NSString * const kQUPDebugOrderURL;
extern NSString * const kQUPDebugPlistURL;


//消息通知
extern NSString * const kQUPSDKInitDidFinishNotification; //SDK初始化完成通知
extern NSString * const kQUPSDKLoginNotification;         //SDK登录完成通知
extern NSString * const kQUPSDKPayNotification;           //SDK支付结果通知
extern NSString * const kQUPSDKPauseDidExitNotification;  //SDK暂停页退出通知
extern NSString * const kQUPSDKLogoutNotification;        //SDK注销通知
extern NSString * const kQUPSDKCenterNotification;        //显示SDK中心页面通知
extern NSString * const kQUPSDKLeaveNotification;         //离开SDK平台页面通知

//消息通知参数
extern NSString * const kQUPSDKSuccessResult;              //发送通知的参数,成功
extern NSString * const kQUPSDKFailedResult;               //发送通知的参数,失败
extern NSString * const kQUPSDKUserCancelResult;           //发送通知的参数,用户取消/关闭,仅支付或者登录时候触发。

extern NSString * const kQUPLoginTokenKey;           //登录成功后返回的token值,在userinfo中
//错误信息key可以在userinfo中获取
extern NSString * const kQUPErrorShowKey;            //通知回调错误显示信息,NSString(中文)
extern NSString * const kQUPErrorInfoKey;            //通知回调错误详细信息,NSError对象或NSString(可能是英文)。

//错误信息
extern NSString * const kQUPInitError;               //SDK没有初始化或初始化错误
extern NSString * const kQUPNetError;                //网络连接错误
extern NSString * const kQUPJsonError;               //信息解析错误
extern NSString * const kQUPInfoError;               //获取信息错误
extern NSString * const kQUPProductError;            //商品信息不完整
extern NSString * const kQUPLoginError;              //登录失败
extern NSString * const kQUPLogoutError;             //用户没有登录
extern NSString * const kQUPSetError;                //渠道配置错误
extern NSString * const kQUPNoDefError;              //平台无此方法
extern NSString * const kQUPPayError;                //支付失败
extern NSString * const kQUPClosePayError;           //游戏已经关闭支付
extern NSString * const kQUPUnkonwError;             //未知错误

#endif
