//
//  RemarkTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/1.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemarkTableViewCell : UITableViewCell

@end

@interface RemarkTableViewCellModel : BaseCellModel

@property(nonatomic,strong)NSAttributedString *title;
@property(nonatomic,strong)NSAttributedString *content;

@end
