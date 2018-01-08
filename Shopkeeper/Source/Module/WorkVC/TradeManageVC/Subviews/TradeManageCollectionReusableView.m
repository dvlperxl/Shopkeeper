//
//  TradeManageCollectionReusableView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "TradeManageCollectionReusableView.h"

@interface TradeManageCollectionReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation TradeManageCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

- (void)reloadData:(NSString*)title
{
    self.titleLab.text = title;
}

@end
