//
//  KKLoadFailureAndNotResultView.h
//  kakatrip
//
//  Created by CaiMing on 2017/5/12.
//  Copyright © 2017年 kakatrip. All rights reserved.
//


#define LoadFailureViewRectFrame(y) CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT - y)
#define LoadFailureViewRectDefaultFrame  CGRectMake(0, 64, SCREEN_WIDTH, 0)

#define LoadFailureViewDescWifi @"未连接到网络\n建议检查网络设置"
#define LoadFailureViewDescSystemError  @"挂了，系统有点小情绪\n没吐出什么信息"


extern NSString *const Default_comingsoon;//敬请期待
extern NSString *const Default_networkerror;//无网络
extern NSString *const Default_noassistant;//无门店
extern NSString *const Default_nocontent;//购物车优惠券奖品无内容
extern NSString *const Default_nodata;// 无数据、公告 会员 订单
extern NSString *const Default_noproduct;//无商品
extern NSString *const Default_noresult;//搜索无结果
extern NSString *const Default_notable;//图标无数据
extern NSString *const Default_pageerror;//404
extern NSString *const Default_contactsetting;//通讯录授权

#import <UIKit/UIKit.h>
typedef void(^KKLoadFailureAndNotResultViewTapBloack)(void);

@interface KKLoadFailureAndNotResultView : UIView

+ (instancetype)noResultViewWithDesc:(NSString*)desc frame:(CGRect)frame;
+ (instancetype)noResultViewWithTitle:(NSString *)title desc:(NSString*)desc;

+ (instancetype)noResultViewWithImageName:(NSString *)imageName;

- (void)reloadDataWithImageName:(NSString*)imageName;
- (void)reloadDataWithImageName:(NSString*)imageName title:(NSString *)title desc:(NSString*)desc;


+ (instancetype)loadFailViewWithErrorCode:(NSInteger)errorCode tapBlock:(KKLoadFailureAndNotResultViewTapBloack)tapBlock;


+(instancetype)loadFailViewWithFrame:(CGRect)frame errorCode:(NSInteger)errorCode tapBlock:(KKLoadFailureAndNotResultViewTapBloack)tapBlock;
+ (instancetype)loadFailViewWithTapBlock:(KKLoadFailureAndNotResultViewTapBloack)tapBlock;

+(instancetype)loadFailViewWithImageName:(NSString*)imageName title:(NSString *)title desc:(NSString*)desc btnTitle:(NSString*)btnTitle  tapBlock:(KKLoadFailureAndNotResultViewTapBloack)tapBlock;



@end
