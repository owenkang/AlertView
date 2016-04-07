//
//  ViewController.m
//  KZWAertView
//
//  Created by homer on 16/4/5.
//  Copyright © 2016年 Owen.kang. All rights reserved.
//

#import "ViewController.h"
#import "KZWAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (IBAction)buttonAction:(id)sender {
    [[KZWAlertView sharedInstance]addAlertViewToView:self.view type:AlertViewTypeSuccess image:[UIImage imageNamed:@"success_top"] title:@"友情提示" message:@"欢迎使用,此方法可以单独使用,放在单例类就可以了,可以全屏幕适配,使用sdAutolayout自动布局,block需要__weak修饰" leftButtonTitle:nil rightButtonTitle:@"确定" okButton:^{
        
    } canleButton:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
