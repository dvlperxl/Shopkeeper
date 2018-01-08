//
//  GoodsCategoryPickerView.m
//  Shopkeeper
//
//  Created by xl on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsCategoryPickerView.h"

CGFloat const pickerViewH = 216.0f;
CGFloat const toolBarH = 40.0f;
CGFloat const pickerViewRowHeight = 36.0f;

@interface GoodsCategoryPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIView *containView;
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) UIToolbar *pickerToolBar;
@end

@implementation GoodsCategoryPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat pickerW = self.bounds.size.width;
    CGFloat pickerH = pickerViewH;
    CGFloat pickerX = 0;
    CGFloat pickerY = toolBarH;
    self.pickerView.frame = CGRectMake(pickerX, pickerY, pickerW, pickerH);
    self.pickerToolBar.frame = CGRectMake(pickerX, 0, pickerW, toolBarH);
}
- (void)showInController:(UIViewController *)viewController {
    UIView *supView = [UIApplication sharedApplication].keyWindow;
    if (viewController) {
        supView = viewController.view;
    }
    [supView endEditing:YES];
    CGFloat supH = supView.bounds.size.height;
    CGFloat supW = supView.bounds.size.width;
    self.frame = CGRectMake(0, supH, supW, pickerViewH + toolBarH);
    self.containView.frame = supView.frame;
    [supView addSubview:self.containView];
    [supView addSubview:self];
    
    [self.pickerView reloadAllComponents];
    [self pickerView:self.pickerView didSelectRow:[self.pickerView selectedRowInComponent:0] inComponent:0];
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat pickerY = supH - (pickerViewH + toolBarH);
        self.frame = CGRectMake(0, pickerY, supW, pickerViewH + toolBarH);
    } completion:nil];
}
#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return pickerViewRowHeight;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self.dataSource numberOfComponentsInPickerView:pickerView];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSource pickerView:pickerView numberOfRowsInComponent:component];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:viewForRow:forComponent:reusingView:)]) {
        return [self.delegate pickerView:pickerView viewForRow:row forComponent:component reusingView:view];
    }
    NSString *text = @"";
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 2;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:20]];
    [label setText:text];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [self.delegate pickerView:pickerView didSelectRow:row inComponent:component];
    }
}
#pragma mark - event
- (void)dismiss {
    [self dismissCompletion:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsPickerViewDidDismiss:)]) {
            [self.delegate goodsPickerViewDidDismiss:self];
        }
    }];
}
- (void)dismissCompletion:(void(^)(void))completion {
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat supH = self.superview.bounds.size.height;
        CGFloat supW = self.superview.bounds.size.width;
        self.frame = CGRectMake(0, supH, supW, pickerViewH + toolBarH);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
        [self removeFromSuperview];
        [self.containView removeFromSuperview];
    }];
}
- (void)doneClick {
    [self dismissCompletion:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsPickerView:pickerView:selectedRows:)]) {
            // 总列数
            NSInteger components = [self.pickerView numberOfComponents];
            NSMutableArray *array = @[].mutableCopy;
            for (int i = 0; i < components; i++) {
                NSInteger selectedRow = [self.pickerView selectedRowInComponent:i];
                [array addObject:@(selectedRow)];
            }
            [self.delegate goodsPickerView:self pickerView:self.pickerView selectedRows:array.copy];
        }
    }];
}
#pragma mark - getter
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        CGFloat pickerW = [UIScreen mainScreen].bounds.size.width;
        CGFloat pickerH = pickerViewH;
        CGFloat pickerX = 0;
        CGFloat pickerY = toolBarH;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        _pickerView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
    }
    return _pickerView;
}
- (UIToolbar *)pickerToolBar {
    if (!_pickerToolBar) {
        _pickerToolBar = [[UIToolbar alloc]init];
        _pickerToolBar.barTintColor = [UIColor whiteColor];
        UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
        UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
        lefttem.tintColor = right.tintColor = [UIColor colorWithHexString:@"#F29700"];
        _pickerToolBar.items = @[lefttem,centerSpace,right];
        [self addSubview:_pickerToolBar];
    }
    return _pickerToolBar;
}
- (UIView *)containView {
    if (!_containView) {
        UIView *contain = [[UIView alloc]init];
        contain.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [contain addGestureRecognizer:tap];
        _containView = contain;
    }
    return _containView;
}
@end
