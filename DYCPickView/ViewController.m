//
//  ViewController.m
//  DYCPickView
//
//  Created by DYC on 15/9/10.
//  Copyright (c) 2015年 DYC. All rights reserved.
//

#import "ViewController.h"
#import "DYCAddress.h"
#import "DYCAddressPickerView.h"
#import "Address.h"
@interface ViewController ()<DYCAddressDelegate,DYCAddressPickerViewDelegate>
@property (weak,nonatomic) UILabel *province;
@property (weak,nonatomic) UILabel *city;
@property (weak,nonatomic) UILabel *county;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DYCAddress *address = [[DYCAddress alloc] init];
    address.dataDelegate = self;
    [address handlerAddress];
    UILabel *province = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width / 3, 50)];
    [province setFont:[UIFont systemFontOfSize:14]];
    province.adjustsFontSizeToFitWidth = YES;
    province.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:province];
    _province = province;
    
    UILabel *city = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, 300, self.view.frame.size.width / 3, 50)];
    [city setFont:[UIFont systemFontOfSize:14]];
    city.adjustsFontSizeToFitWidth = YES;
    city.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:city];
    _city = city;
    
    UILabel *county = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 2 / 3, 300, self.view.frame.size.width / 3, 50)];
    [county setFont:[UIFont systemFontOfSize:14]];
    county.adjustsFontSizeToFitWidth = YES;
    county.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:county];
    _county = county;
}
-(void)addressList:(NSArray *)array
{
    DYCAddressPickerView *pickerView = [[DYCAddressPickerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) withAddressArray:array];
    pickerView.DYCDelegate = self;
    pickerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:pickerView];
}
-(void)selectAddressProvince:(Address *)province andCity:(Address *)city andCounty:(Address *)county
{
    [_province setText:province.name];
    [_city setText:city.name];
    [_county setText:county.name];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
