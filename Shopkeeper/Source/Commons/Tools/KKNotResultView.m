//
//  KKNotResultView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "KKNotResultView.h"

#import "KKLoadFailureAndNotResultView.h"


@interface KKNotResultView ()

@property(strong,nonatomic)UIImageView * imageView;
@property(strong,nonatomic)UILabel * titleLab;
@property(strong,nonatomic)UILabel * descLab;

@end

@implementation KKNotResultView

+ (instancetype)noResultViewWithImageName:(NSString *)imageName;
{
    KKNotResultView *aView = [[KKNotResultView alloc]init];
    [aView initSubviews];
    [aView reloadDataWithImageName:imageName];
    return aView;
}

- (void)reloadDataWithImageName:(NSString*)imageName
{
    self.imageView.image = [UIImage imageNamed:imageName];
    NSDictionary *content = [self contentData:imageName];
    self.titleLab.text = content[@"title"];
    self.descLab.text = content[@"desc"];
}

- (void)reloadDataWithImageName:(NSString*)imageName title:(NSString *)title desc:(NSString*)desc
{
    self.imageView.image = [UIImage imageNamed:imageName];
    self.titleLab.text = title;
    self.descLab.text = desc;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.offset(50);
        make.width.mas_equalTo(195);
        make.height.mas_equalTo(150);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.imageView.mas_bottom).offset(0);
        make.centerX.equalTo(self.mas_centerX);
        //        make.height.mas_equalTo(42);
        make.left.offset(15);
        make.right.offset(-15);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        //        make.height.mas_equalTo(28);
        make.left.offset(15);
        make.right.offset(-15);
    }];
}


-(void)initSubviews
{
    self.backgroundColor = ColorWithHex(@"#ffffff");
    [self addSubview:self.imageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.descLab];
}

-(UIImageView *)imageView{
    
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
    }
    return _imageView;
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=APPFONT(18);
        _titleLab.textColor=ColorWithHex(@"#666666");
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

-(UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab=[[UILabel alloc]init];
        _descLab.font=APPFONT(15);
        _descLab.textColor=ColorWithHex(@"#999999");
        _descLab.textAlignment = NSTextAlignmentCenter;
        _descLab.numberOfLines = 0;
    }
    return _descLab;
}


- (NSDictionary*)contentData:(NSString*)imageName
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"imageName = %@",imageName];
    
    NSArray *messageList = @[
                             @{@"title":@"什么都没有",@"desc":@"去其他地方看看吧",@"imageName":Default_nodata},
                             @{@"title":@"没有找到相关内容",@"desc":@"换个关键词试试",@"imageName":Default_noresult},
                             @{@"title":@"糟糕，页面出错了",@"desc":@"",@"imageName":Default_pageerror},
                             @{@"title":@"网络不可用，网络加载失败",@"desc":@"请检查是否连接了WiFi或数据网络",@"imageName":Default_networkerror},
                             @{@"title":@"允许农丁掌柜访问你的\n手机通讯录",@"desc":@"",@"imageName":Default_contactsetting},
                             @{@"title":@"您还没有处方套餐～",@"desc":@"",@"imageName":Default_noproduct},
                             ];
    
    NSArray *result = [messageList filteredArrayUsingPredicate:pred];
    if (result.count>0)
    {
        return result.firstObject;
    }
    
    return messageList.firstObject;
}



@end
