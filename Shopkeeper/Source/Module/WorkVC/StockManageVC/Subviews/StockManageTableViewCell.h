//
//  StockManageTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockManageTableViewCell : UITableViewCell

@end

@interface StockManageTableViewCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *status;

@end
