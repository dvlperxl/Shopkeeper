//
//  OrderListTableHeaderView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTableHeaderView : UITableViewHeaderFooterView

@end

@interface OrderListTableHeaderViewModel : BaseCellModel

@property(nonatomic,copy)NSString *title;

@end
