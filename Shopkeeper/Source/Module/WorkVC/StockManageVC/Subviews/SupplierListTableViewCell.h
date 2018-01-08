//
//  SupplierListTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierListTableViewCell : UITableViewCell

@end

@interface SupplierListTableViewCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,strong)NSNumber *uid;

@end
