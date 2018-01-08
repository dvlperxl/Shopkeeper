//
//  MemberDetailTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberDetailTableViewCell : UITableViewCell

@end

@interface MemberDetailTableViewCellModel : NSObject

@property(nonatomic,strong)NSString *iconName;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *desc;

@end
