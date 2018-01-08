//
//  VillageChooseView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/25.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "VillageChooseView.h"

@interface VillageChooseView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)CMTextField *textField;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,copy)NSArray *dataSource;

@end

@implementation VillageChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH-50, 100);
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)reloadData:(NSArray*)dataSource
{
    self.dataSource = dataSource;
    [self.tableView reloadData];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH-50, self.dataSource.count*44+44);
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.dataSource[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(villageChooseViewDidChooseVillage:)]) {
        
        [self.delegate villageChooseViewDidChooseVillage:dict[@"name"]];
    }
}

- (void)onBtnAction
{
    if (_textField.text.length>0)
    {
        if ([self.delegate respondsToSelector:@selector(villageChooseViewDidChooseVillage:)]) {
            
            [self.delegate villageChooseViewDidChooseVillage:_textField.text];
        }
        
    }else
    {
        [[KKToast makeToast:@"请输入正确的村"] show];
        
    }
}


#pragma mark - initSubviews


- (void)initSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.btn];
    [self addSubview:self.textField];

    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.offset(-5);
        make.top.offset(5);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(34);

    }];

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.offset(5);
        make.left.offset(15);
        make.height.mas_equalTo(34);
        make.right.equalTo(self.btn.mas_left).offset(-5);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.left.right.offset(0);
        make.top.offset(44);
    }];
    

    
}



- (UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}


- (CMTextField *)textField
{
    if (!_textField) {
        
        _textField = [[CMTextField alloc]init];
        _textField.placeholder = @"请输入村";
        
    }
    return _textField;
}

- (UIButton *)btn
{
    if (!_btn) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn setTitle:@"确定" forState:UIControlStateNormal];
        _btn.layer.cornerRadius = 5;
        _btn.layer.masksToBounds = YES;
        _btn.layer.borderColor = _btn.tintColor.CGColor;
        [_btn addTarget:self action:@selector(onBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _btn.layer.borderWidth = 1.0;
    }
    return _btn;
}

@end
