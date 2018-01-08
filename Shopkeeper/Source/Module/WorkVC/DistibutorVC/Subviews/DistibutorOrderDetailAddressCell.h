//
//  DistibutorOrderDetailAddressCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistibutorOrderDetailAddressCell : UITableViewCell

@end

@interface DistibutorOrderDetailAddressCellModel : BaseCellModel

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *imageName;

@end
