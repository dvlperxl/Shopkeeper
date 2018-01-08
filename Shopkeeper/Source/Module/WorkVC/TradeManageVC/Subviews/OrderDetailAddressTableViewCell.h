//
//  OrderDetailAddressTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailAddressTableViewCell : UITableViewCell

@end

@interface OrderDetailAddressTableViewCellModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *address;

@end
