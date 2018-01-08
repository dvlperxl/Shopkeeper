//
//  DailyCheckListTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyCheckListTableViewCell : UITableViewCell

@end

@interface DailyCheckListTableViewCellModel : NSObject

@property(nonatomic,copy)NSString *iconName;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *title1;
@property(nonatomic,copy)NSString *title2;
@property(nonatomic,copy)NSAttributedString *content1;
@property(nonatomic,copy)NSAttributedString *content2;

@end
