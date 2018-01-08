//
//  HNFirstToastView.m
//  Dev
//
//  Created by xl on 2017/12/14.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "HNFirstToastView.h"


@interface HNFirstToastView ()

@property (nonatomic,strong) UIImageView *popupImageView;
@property (nonatomic,strong) UILabel *contentLabel;
@end

@implementation HNFirstToastView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(12);
            make.right.offset(-6);
            make.top.offset(8);
            make.bottom.offset(-8);
        }];
        [self.popupImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset(0);
            make.bottom.equalTo(self.contentLabel.mas_bottom).with.offset(8);
        }];
        [self bringSubviewToFront:self.contentLabel];
    }
    return self;
}
- (void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = content;
}

#pragma mark - getter
- (UIImageView *)popupImageView {
    if (!_popupImageView) {
        _popupImageView = [[UIImageView alloc]init];
        _popupImageView.image = [UIImage imageNamed:@"popup_new_bk"];
//    stretchableImageWithLeftCapWidth:33.0f topCapHeight:33.0f];
        [self addSubview:_popupImageView];
    }
    return _popupImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = APPFONT(12);
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}
@end
