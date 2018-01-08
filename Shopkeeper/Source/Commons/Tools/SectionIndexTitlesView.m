//
//  SectionIndexTitlesView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SectionIndexTitlesView.h"

@interface SectionIndexTitlesView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)NSArray *dataSource;

@end

@implementation SectionIndexTitlesView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)reloadData:(NSArray *)list
{
    _dataSource = list;
    self.tableView.frame = CGRectMake(0,(self.frame_height-_dataSource.count*15)/2, self.frame_width, _dataSource.count*15);
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indexCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 15)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = ColorWithHex(@"#666666");
        [cell addSubview:titleLabel];
        titleLabel.tag = 11;
    }
    
    UILabel *titleLabel = [cell viewWithTag:11];
    titleLabel.text = [_dataSource objectAtIndex:indexPath.row];
    titleLabel.font = APPFONT(11);
    
    return cell;
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 15.0f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(sectionIndexTitlesViewDidSelectTitle:withIndex:)]) {
        
        [self.delegate sectionIndexTitlesViewDidSelectTitle:[_dataSource objectAtIndex:indexPath.row] withIndex:indexPath.row];
        
    }
}


- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    
    return _tableView;
}

@end
