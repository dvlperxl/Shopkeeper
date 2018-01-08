//
//  MallOrderInvoiceHeader.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderInvoiceHeader.h"

@interface MallOrderInvoiceHeader ()

@property (nonatomic,weak) UILabel *headerTitleLabel;
@property (nonatomic,weak) UISwitch *invoiceSwitch;
@end

@implementation MallOrderInvoiceHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.invoiceSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        NSMutableAttributedString *headerTitle = [[NSMutableAttributedString alloc]initWithString:@"是否需要发票" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#030303"],NSFontAttributeName:APPFONT(17)}];
        [headerTitle appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n发票7日内寄出" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:APPFONT(12)}]];
        self.headerTitleLabel.attributedText = headerTitle;
    }
    return self;
}
- (void)reloadData:(NSNumber *)model {
    self.invoiceSwitch.on = [model boolValue];
}
#pragma mark - event
- (void)switchAction:(UISwitch *)sender {
    BOOL isOn = [sender isOn];
    if (self.delegate && [self.delegate respondsToSelector:@selector(invoiceHeader:switchOn:)]) {
        [self.delegate invoiceHeader:self switchOn:isOn];
    }
}
#pragma mark - getter
- (UILabel *)headerTitleLabel {
    if (!_headerTitleLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.numberOfLines = 2;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(18);
        [self.contentView addSubview:name];
        _headerTitleLabel = name;
    }
    return _headerTitleLabel;
}
- (UISwitch *)invoiceSwitch {
    if (!_invoiceSwitch) {
        UISwitch *name = [[UISwitch alloc]init];
        name.onTintColor = [UIColor colorWithHexString:@"#F29700"];
        name.on = NO;
        [name addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:name];
        _invoiceSwitch = name;
    }
    return _invoiceSwitch;
}

@end
