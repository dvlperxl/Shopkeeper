//
//  GoodsChooseAlertView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsChooseAlertViewModel;

@protocol GoodsChooseAlertViewDelegate <NSObject>

- (void)goodsChooseAlertViewDidSelectButton:(NSInteger)index price:(NSString*)price count:(NSString*)count total:(NSString*)total;

@end

@interface GoodsChooseAlertView : UIView

@property(nonatomic,weak)id<GoodsChooseAlertViewDelegate> delegate;

+ (instancetype)goodsChooseAlertView:(GoodsChooseAlertViewModel*)model;

@end

@interface GoodsChooseAlertViewModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *unit;
@property(nonatomic,assign) BOOL priceEnable;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *pricePlaceholder;
@property(nonatomic,copy)NSString *count;
@property(nonatomic,copy)NSString *countPlaceholder;
@end
