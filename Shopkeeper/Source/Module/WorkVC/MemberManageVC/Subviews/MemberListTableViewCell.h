//
//  MemberListTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberListTableViewCell : UITableViewCell

@end

@interface MemberListTableViewCellModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *score;
@property(nonatomic,copy)NSString *con;
@property(nonatomic,copy)NSString *credit;
@property(nonatomic,copy)NSNumber *customerId;

@end
