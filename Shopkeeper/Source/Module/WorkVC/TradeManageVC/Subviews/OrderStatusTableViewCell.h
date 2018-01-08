//
//  OrderStatusTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStatusTableViewCell : UITableViewCell

@end

@interface OrderStatusTableViewCellModel : NSObject

@property(nonatomic,copy)NSString *orderStatus;
@property(nonatomic,copy)NSString *orderTime;

@end

