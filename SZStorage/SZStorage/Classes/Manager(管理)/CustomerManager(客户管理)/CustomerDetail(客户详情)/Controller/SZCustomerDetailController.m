//
//  SZCustomerDetailController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCustomerDetailController.h"
#import "SZCustomerItem.h"

@interface SZCustomerDetailController ()
@property (weak, nonatomic) IBOutlet UITextField *cuetomerNameFiled;
@property (weak, nonatomic) IBOutlet UITextField *connectPersonFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
//客户标签
@property (weak, nonatomic) IBOutlet UILabel *customerTag;
@property (weak, nonatomic) IBOutlet UITextField *addressFiled;

@end

@implementation SZCustomerDetailController

- (void)setValue:(id)value
 forUndefinedKey:(NSString *)key
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
    self.navigationItem.title = @"客户详情";
}

- (IBAction)customerBtnClick
{

}

- (void)setItem:(SZCustomerItem *)item
{
    if (item) {
        _cuetomerNameFiled.text = item.customer_name;
        _phoneFiled.text = item.customer_mobile;
        //TODO:其他参数
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
