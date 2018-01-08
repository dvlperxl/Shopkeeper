//
//  ReceivePersonListTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceivePersonListTableViewCell : UITableViewCell

@end

@interface ReceivePersonListTableViewCellModel : BaseCellModel

@property(nonatomic,copy)NSString *receiveName;
@property(nonatomic,copy)NSString *receivePhone;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,assign)BOOL select;
@property(nonatomic,strong)RouterModel *editRouterModel;

@end
