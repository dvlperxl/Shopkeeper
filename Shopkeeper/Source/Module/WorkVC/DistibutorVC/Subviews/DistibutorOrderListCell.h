//
//  DistibutorOrderListCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistibutorOrderListCell : UITableViewCell

@end

@interface DistibutorOrderListCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *imageName;

@end

