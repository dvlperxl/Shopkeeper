//
//  MyQRCodeView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/31.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MyQRCodeView.h"

@interface MyQRCodeView ()

@property(nonatomic,strong)UIView *bgView1;
@property(nonatomic,strong)UIView *bgView2;
@property(nonatomic,strong)UIImageView *qrImageView;
@property(nonatomic,strong)UIImageView *slogonImageView;
@property(nonatomic,strong)UIButton *closeButton;

@end


@implementation MyQRCodeView

+(instancetype)myQRCodeWithContent:(NSString*)content
{
    MyQRCodeView *codeView = [[MyQRCodeView alloc]initWithFrame:SCREEN_BOUNDS];
    
    codeView.qrImageView.image = [codeView createQRForString:content withSize:238*SCREEN_SCALE];

    return codeView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorWithRGB(0, 0, 0, 0.5);
        [self initSubviews];
    }
    return self;
}


#pragma mark - InterpolatedUIImage
- (UIImage *)createQRForString:(NSString *)qrString withSize:(CGFloat) size {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CGRect extent = CGRectIntegral(qrFilter.outputImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:qrFilter.outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)onCloseButtonAction
{
    [self removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(340);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(260);
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.offset(-30);
    }];
    
    [self.slogonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(38);
        make.centerX.equalTo(self.mas_centerX);
        make.top.offset(15);
    }];
    
    [self.qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(238);
        make.centerX.equalTo(self.bgView2.mas_centerX);
        make.centerY.equalTo(self.bgView2.mas_centerY);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(50);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.bgView1.mas_bottom).offset(21);
    }];
}

- (void)initSubviews
{
    [self addSubview:self.bgView1];
    [self.bgView1 addSubview:self.bgView2];
    [self.bgView2 addSubview:self.qrImageView];
    [self.bgView1 addSubview:self.slogonImageView];
    [self addSubview:self.closeButton];
}

- (UIView *)bgView1
{
    if (!_bgView1) {
        
        _bgView1 = [[UIView alloc]init];
        _bgView1.backgroundColor = [UIColor whiteColor];
        _bgView1.layer.masksToBounds = YES;
        _bgView1.layer.cornerRadius = 12;
    
    }
    return _bgView1;
}

- (UIView *)bgView2
{
    if (!_bgView2) {
        
        _bgView2 = [[UIView alloc]init];
        _bgView2.backgroundColor = ColorWithHex(@"#F29700");
        _bgView2.layer.masksToBounds = YES;
	
    }
    return _bgView2;
}

- (UIImageView *)slogonImageView
{
    if (!_slogonImageView) {
        
        _slogonImageView = [[UIImageView alloc]initWithImage:Image(@"code_bk")];
        
    }
    return _slogonImageView;
}

- (UIImageView *)qrImageView
{
    if (!_qrImageView) {
        
        _qrImageView = [[UIImageView alloc]init];
        
    }
    return _qrImageView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton addTarget:self action:@selector(onCloseButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setImage:Image(@"popup_icon_close") forState:UIControlStateNormal];
        
        
    }
    return _closeButton;
}

@end
