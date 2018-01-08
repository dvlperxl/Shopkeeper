//
//  OrderDetailMerchandiseCell2.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/1.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderDetailMerchandiseCell2;
@class OrderDetailMerchandiseSubviewModel;

@protocol OrderDetailMerchandiseCell2Delegate <NSObject>

- (void)orderDetailMerchandiseCell2:(OrderDetailMerchandiseCell2*)aCell didSelectOpenButton:(BOOL)open retailId:(NSString*)retailId;


@end

@interface OrderDetailMerchandiseCell2 : UITableViewCell

@property(nonatomic,weak)id<OrderDetailMerchandiseCell2Delegate> delegate;

@end

@interface OrderDetailMerchandiseCell2Model : NSObject

@property(nonatomic,assign)BOOL open;
@property(nonatomic,copy)NSArray *preList;// title //content
@property(nonatomic,copy)NSString *retailId;

@end

@interface OrderDetailMerchandiseSubviewModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,assign)CGFloat height;

@end;


