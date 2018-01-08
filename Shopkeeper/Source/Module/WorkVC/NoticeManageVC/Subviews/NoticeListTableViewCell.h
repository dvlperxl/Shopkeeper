//
//  NoticeListTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/26.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeListTableViewCell : UITableViewCell

@end

@interface NoticeListTableViewCellModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSAttributedString *status;
@property(nonatomic,copy)NSString *time;


@end
