//
//  OrderListTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>


@class OrderListTableViewCellModel;

@interface OrderListTableViewCell : UITableViewCell

//- (void)reloadData:(OrderListTableViewCellModel*)model;

@end


@interface OrderListTableViewCellModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *order;
@property(nonatomic,copy)NSAttributedString *amount;
@property(nonatomic,assign)BOOL isRefunds;
@property(nonatomic,copy)NSString *oid;

@end

