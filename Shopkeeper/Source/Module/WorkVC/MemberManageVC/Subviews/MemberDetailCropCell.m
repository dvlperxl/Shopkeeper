//
//  MemberDetailCropCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberDetailCropCell.h"


@interface MemberDetailCropView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;

@end

@implementation MemberDetailCropView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(MemberDetailCropViewModel*)model
{
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
}

- (void)initSubviews
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = ColorWithRGB(235, 235, 235, 1).CGColor;
    self.layer.borderWidth = 1;
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(21);
        make.height.mas_equalTo(18);
        make.left.right.offset(0);
        
    }];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-16);
        make.height.mas_equalTo(14);
        make.left.right.offset(0);
    }];

}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = APPFONT(18);
        
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.font = APPFONT(12);
    }
    return _contentLab;
}

@end

@implementation MemberDetailCropViewModel

@end


@interface MemberDetailCropCell ()

@property(nonatomic,strong)NSArray *cropList;

@end

@implementation MemberDetailCropCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
    
}

- (void)reloadData:(NSArray*)modelList
{
    for (NSInteger i = 0; i<3; i++)
    {
        MemberDetailCropView *cropView = self.cropList[i];
        if (i<modelList.count)
        {
            cropView.hidden = NO;
            [cropView reloadData:modelList[i]
             ];
        }else
        {
            cropView.hidden = YES;
        }
    }
}

- (void)initSubviews
{
    NSMutableArray *cropList = @[].mutableCopy;
    CGFloat width = (SCREEN_WIDTH - 50)/3;
    CGFloat x = 15;
    CGFloat space = 10;
    
    for (NSInteger i = 0; i<3; i++)
    {
        MemberDetailCropView *cropView = [[MemberDetailCropView alloc]init];
        cropView.frame = CGRectMake(x+(width+space)*i, 0, width, 75);
        [cropList addObject:cropView];
        [self addSubview:cropView];
    }
    self.cropList = cropList.copy;
}


@end
