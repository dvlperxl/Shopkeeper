//
//  MemberDetailAddressCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberDetailAddressCell.h"


@interface MemberDetailAddressCell : UITableViewCell

@end


@interface MemberDetailAddressCellModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *level;
@property(nonatomic,assign)BOOL showVip;

@end


