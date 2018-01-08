//
//  OrderDetailMerchandiseCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailMerchandiseCell : UITableViewCell

@end

@interface OrderDetailMerchandiseCellModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *brand;
@property(nonatomic,copy)NSString *count;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,assign)BOOL hideLine;


@end
