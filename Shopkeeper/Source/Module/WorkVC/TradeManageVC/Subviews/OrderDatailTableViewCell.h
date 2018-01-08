//
//  OrderDatailTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDatailTableViewCell : UITableViewCell

@end

@interface OrderDatailTableViewCellModel : NSObject

@property(nonatomic,copy)NSAttributedString *title;
@property(nonatomic,copy)NSAttributedString *content;

@end
