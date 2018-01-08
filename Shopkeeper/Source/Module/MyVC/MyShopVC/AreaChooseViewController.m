//
//  AreaChooseViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/25.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AreaChooseViewController.h"
#import "KKModelController.h"
#import "AreaDataModel.h"
#import "UIButton+Extensions.h"
#import "HNDataBase.h"


@interface AreaChooseViewController ()

<UITableViewDataSource,
UITableViewDelegate,
UIPickerViewDelegate,
UIPickerViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *pickerBgView;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)KKModelController *mc;
@property(nonatomic,strong)NSMutableArray *pickerDataSource;
@property(nonatomic,strong)NSArray *areaList;

@property(nonatomic,strong)UIView *areaChooseBgView;
@property(nonatomic,strong)UIButton *areaChooseButtton;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)NSMutableDictionary *cacheVillageMessage;
@property(nonatomic,strong)UILabel *desLab;

@end

@implementation AreaChooseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"选择区域";
    [self initSubviews];
    _cacheVillageMessage = @{}.mutableCopy;
    self.areaList =  [[HNDataBase share] areaList];
    
    if (self.areaId)
    {
        NSString *str = STRINGWITHOBJECT(self.areaId);
        if (str.length>6)
        {
            str = [str substringWithRange:NSMakeRange(0, 6)];
            self.areaId = @(str.longLongValue);
        }
        NSString *area = [AreaDataModel queryAreaName:self.areaList byArea:self.areaId.longValue];
        [self.areaChooseButtton setTitle:area forState:UIControlStateNormal];
        [self httpRequestVillageListWithareaId:self.areaId];
        self.desLab.text = @"切换";
    }
    
    [self setScrollViewInsets:@[self.tableView]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)httpRequestVillageListWithareaId:(NSNumber*)areaId
{
    [[APIService share]httpRequestVillageListWithareaId:areaId
                                                success:^(NSDictionary *responseObject) {
                                                    
                                                    [_cacheVillageMessage setObject:responseObject forKey:areaId];
                                                    self.dataSource = (NSArray*)responseObject;
                                                    [self.tableView reloadData];
                                                    
                                                } failure:^(NSNumber *errorCode,
                                                            NSString *errorMsg,
                                                            NSDictionary *responseObject) {
                                                    [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
                                                    
                                                    __weak typeof(self) weakSelf = self;
                                                    
                                                    [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                                                           tapBlock:^{
                                                                                                                               
                                                                                                                               [weakSelf httpRequestVillageListWithareaId:weakSelf.areaId];
                                                                                                                               
                                                                                                                           }] ];

                                                    
                                                }];
}

- (void)onPickerDataButton:(UIButton*)button
{
    if (self.pickerDataSource.count == 3) {
        
        if (button.tag == 1)
        {
            AreaDataModel *model0  = [self.pickerDataSource[0] objectAtIndex:[self.pickerView selectedRowInComponent:0]];
            AreaDataModel *model1  = [self.pickerDataSource[1] objectAtIndex:[self.pickerView selectedRowInComponent:1]];
            AreaDataModel *model2  = [self.pickerDataSource[2] objectAtIndex:[self.pickerView selectedRowInComponent:2]];
            self.areaId = @(model2.uid);
            if (_cacheVillageMessage[self.areaId])
            {
                self.dataSource = _cacheVillageMessage[self.areaId];
                [self.tableView reloadData];
            }else
            {
                [self httpRequestVillageListWithareaId:@(model2.uid)];
            }
            NSString*title = [NSString stringWithFormat:@"%@%@%@",model0.name,model1.name,model2.name];
            [_areaChooseButtton setTitle:title forState:UIControlStateNormal];
            self.desLab.text = @"切换";

        }
    }
    [_mc dismiss];
}

- (void)onChooseButtonAction
{
    KKModelController *p = [KKModelController presentationControllerWithContentView:self.pickerBgView];
    _mc = p;
    self.pickerDataSource = [AreaDataModel getDefaultDisplayData:self.areaList areaId:self.areaId].mutableCopy;
    
    NSString *areaIdStr = [NSString stringWithFormat:@"%@",self.areaId];

    if (self.areaId && areaIdStr.length>=6) {
        
        NSInteger i = 0;
        
        NSLog(@"%@",self.areaId);
        
        for (NSArray *data in self.pickerDataSource)
        {
            i+=2;
            
            NSLog(@"======");
            
            if (areaIdStr.length>=i)
            {
                NSPredicate *pre = [NSPredicate predicateWithFormat:@"uid = %d",[[areaIdStr substringToIndex:i]integerValue]];
                NSArray *result = [data filteredArrayUsingPredicate:pre];
                if (result.count==1)
                {
                    NSInteger row = [data indexOfObject:result.firstObject];
                    NSInteger component = (i-2)/2;
                    [self.pickerView selectRow:row inComponent:component animated:NO];
                    
                    NSLog(@"%@",@(row));
                    NSLog(@"%@",@(component));
                }
            }
            
        }
    }

    
    [p showInSuperView:self.navigationController.view];
    [self.pickerView reloadAllComponents];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickerDataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerDataSource[component] count];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)];
    AreaDataModel *model = self.pickerDataSource[component][row];
    myView.text = model.name;
    myView.textAlignment = NSTextAlignmentCenter;
    myView.font = APPFONT(15);
    myView.backgroundColor = [UIColor clearColor];
    
    return myView;
}


//- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    AreaDataModel *model = self.pickerDataSource[component][row];
//    return model.name;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerDataSource.count==3)
    {
        AreaDataModel *model = self.pickerDataSource[component][row];
        
        if (component == 0)
        {
            NSArray *result = [AreaDataModel queryAreaList:[HNDataBase share].areaList byPid:model.uid];
            [self.pickerDataSource replaceObjectAtIndex:1 withObject:result];
            [pickerView reloadComponent:1];
            
            AreaDataModel *m1 = result[[self.pickerView selectedRowInComponent:1]];
            if (m1) {
                NSArray *result1 = [AreaDataModel queryAreaList:[HNDataBase share].areaList byPid:m1.uid];
                [self.pickerDataSource replaceObjectAtIndex:2 withObject:result1];
            }
            [pickerView reloadComponent:2];
            
        }
        
        if (component == 1)
        {
            NSArray *result = [AreaDataModel queryAreaList:[HNDataBase share].areaList byPid:model.uid];
            [self.pickerDataSource replaceObjectAtIndex:2 withObject:result];
            [pickerView reloadComponent:2];
            
        }
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataSource[indexPath.row];
    [[CMRouter sharedInstance]backToViewController:self.backClassName param:@{@"callBack":dict}];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.areaChooseBgView];
    [self.view addSubview:self.areaChooseButtton];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.areaChooseBgView.mas_bottom).offset(10);
         make.left.right.bottom.offset(0);
     }];
    
    [self.areaChooseBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.left.offset(0);
        make.height.mas_equalTo(75);
        make.top.equalTo(self.navView.mas_bottom).offset(0);
        
    }];
    [self.areaChooseButtton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(77);
        make.right.offset(-80);
        make.height.mas_equalTo(34);
        make.centerY.equalTo(self.areaChooseBgView.mas_centerY);
        
    }];
}

- (UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = ColorWithRGB(216, 216, 216, 1);
    }
    return _pickerView;
}

- (UIView *)pickerBgView
{
    if (!_pickerBgView) {
        
        _pickerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
        _pickerBgView.backgroundColor = [UIColor whiteColor];
        
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [leftButton setTitleColor:ColorWithRGB(242, 151, 0, 1) forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(onPickerDataButton:) forControlEvents:UIControlEventTouchUpInside];
        leftButton.tag = 0;
        [_pickerBgView addSubview:leftButton];
        
        UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, 44)];
        [rightButton setTitle:@"完成" forState:UIControlStateNormal];
        [rightButton setTitleColor:ColorWithRGB(242, 151, 0, 1) forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(onPickerDataButton:) forControlEvents:UIControlEventTouchUpInside];
        rightButton.tag = 1;
        [_pickerBgView addSubview:rightButton];
        [_pickerBgView addSubview:self.pickerView];
        
    }
    return _pickerBgView;
}

- (UIButton *)areaChooseButtton
{
    if (!_areaChooseButtton) {
        
        _areaChooseButtton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_areaChooseButtton setTitle:@"区域选择" forState:UIControlStateNormal];
        [_areaChooseButtton setTitleColor:ColorWithHex(@"#333333") forState:UIControlStateNormal];
        _areaChooseButtton.titleLabel.font = APPFONT(18);
        [_areaChooseButtton setHitTestEdgeInsets:UIEdgeInsetsMake(0, -10, -10, -100)];
        _areaChooseButtton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        _areaChooseButtton.layer.masksToBounds = YES;
//        _areaChooseButtton.layer.cornerRadius = 10;
//        _areaChooseButtton.layer.borderColor = ColorWithHex(@"#a7a7a7").CGColor;
//        _areaChooseButtton.layer.borderWidth = 1;
//        _areaChooseButtton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        [_areaChooseButtton addTarget:self action:@selector(onChooseButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _areaChooseButtton;
}

- (UIView *)areaChooseBgView
{
    if (!_areaChooseBgView) {
        
        _areaChooseBgView = [[UIView alloc]init];
        _areaChooseBgView.backgroundColor = [UIColor whiteColor];
        UIImageView *icon = [[UIImageView alloc]initWithImage:Image(@"address_choose_icon")];
        [_areaChooseBgView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.height.mas_equalTo(50);
            make.left.offset(15);
            make.centerY.equalTo(_areaChooseBgView.mas_centerY);
        }];
        
        
        UIImageView *arrowImageV =  [[UIImageView alloc]initWithImage:Image(@"arrow_right")];
        [_areaChooseBgView addSubview:arrowImageV];

        [arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-16);
            make.centerY.equalTo(_areaChooseBgView.mas_centerY);
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(13);
            
        }];
        
        UILabel *desc = [[UILabel alloc]init];
        desc.textColor = ColorWithHex(@"#8F8E94");
        desc.textAlignment = NSTextAlignmentRight;
        desc.font = APPFONT(17);
        desc.text = @"请选择";
        _desLab = desc;
        [_areaChooseBgView addSubview:desc];
        
        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.offset(-35);
            make.centerY.equalTo(_areaChooseBgView.mas_centerY);
            make.height.mas_equalTo(19);

        }];
        
        
    }
    return _areaChooseBgView;
}


@end
