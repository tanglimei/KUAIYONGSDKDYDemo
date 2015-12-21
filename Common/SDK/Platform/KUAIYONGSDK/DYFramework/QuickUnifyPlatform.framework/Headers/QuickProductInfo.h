//
//  QuickProductInfo.h
//  QuickProductInfo
//
//  Created by yuhao on 14-11-19.
//  Copyright (c) 2014年 QuickCompany All rights reserved.
//

#import <Foundation/Foundation.h>

//游戏角色购买商品信息,所有属性不能为nil或者@""
@interface QuickProductInfo : NSObject
//@property(nonatomic, copy)NSString* union_id;//联盟ID
//@property(nonatomic, copy)NSString* game_id;//游戏唯一标识

@property(nonatomic, copy)NSString* server_id;//自定义游戏服务器编号
@property(nonatomic, copy)NSString* user_id;//用户id(从聚合服务器获取)
@property(nonatomic, copy)NSString* user_extend;//自定义用户扩展信息

@property(nonatomic, copy)NSString* order_id;//自定义订单号
@property(nonatomic, copy)NSString* product_id;//自定义商品id
@property(nonatomic, copy)NSString* product_name;//自定义商品名称
@property(nonatomic, copy)NSString* product_desc;//自定义商品描述
@property(nonatomic, copy)NSString* product_number;//自定义购买商品数量,数字
@property(nonatomic, copy)NSString* product_price;//自定义购买商品单价,数字或者小数,单位元(money=product_number*product_price)
@property(nonatomic, copy)NSString* money;//自定义总金额,数字或者小数,单位元

@end


