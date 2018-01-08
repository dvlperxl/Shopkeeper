//
//  ReicpePackageAddCropReusableHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddCropReusableHeaderView.h"

@interface ReicpePackageAddCropReusableHeaderView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *descLab;

@end

@implementation ReicpePackageAddCropReusableHeaderView

- (void)hideNoResult:(BOOL)hide
{
    self.imageView.hidden = hide;
    self.descLab.hidden = hide;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.offset(60);
        make.width.mas_equalTo(195);
        make.height.mas_equalTo(150);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        //        make.height.mas_equalTo(42);
        make.left.offset(15);
        make.right.offset(-15);
    }];
}

- (UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(15);
        _titleLab.textColor = ColorWithHex(@"#999999");
        _titleLab.text = @"你可能用到的作物";
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

-(UIImageView *)imageView{
    
    if (!_imageView)
    {
        _imageView=[[UIImageView alloc]initWithImage:Image(Default_nodata)];
        [self addSubview:_imageView];
    }
    return _imageView;
}

-(UILabel *)descLab{
    
    if (!_descLab) {
        
        _descLab=[[UILabel alloc]init];
        _descLab.font=APPFONT(18);
        _descLab.textColor=ColorWithHex(@"#666666");
        _descLab.textAlignment = NSTextAlignmentCenter;
        _descLab.numberOfLines = 0;
        _descLab.text = @"暂无你可能用到的作物";
        [self addSubview:_descLab];

    }
    return _descLab;
}

@end
