//
//  TradeManageHomeCollectionViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "TradeManageHomeCollectionViewCell.h"


@interface TradeManageHomeCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation TradeManageHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

- (void)reloadData:(TradeManageHomeCollectionViewCellModel*)model
{
    if (model.iconImage)
    {
        self.iconImageView.image = Image(model.iconImage);
    }else
    {
        self.iconImageView.image = nil;
    }
    self.titleLab.text = model.title;
}

@end

@implementation TradeManageHomeCollectionViewCellModel

@end;

