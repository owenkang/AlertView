//
//  TangXSSingleton.m
//  TangXSLiCai
//
//  Created by homer on 15/5/29.
//  Copyright (c) 2015年 owen.kang. All rights reserved.
//

#import "KZWAlertView.h"
#import "UIView+SDAutoLayout.h"
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kHeightRatio kScreenHeight/2208
@interface KZWAlertView()
@property (nonatomic, copy)okBlock okBlock;
@property (nonatomic, copy)canleBlock canleBlock;
@end

@implementation KZWAlertView {
    UIView *_tempView;
}

+(KZWAlertView *)sharedInstance {
    static KZWAlertView *iYaoInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iYaoInstance = [[KZWAlertView alloc] init];
    });
    return iYaoInstance;
}


- (void)addAlertViewToView:(UIView *)aView
                      type:(AlertViewType)type
                     image:(UIImage *)image
                     title:(NSString *)title
                   message:(NSString *)message
           leftButtonTitle:(NSString *)leftString
          rightButtonTitle:(NSString *)rightString
                  okButton:(okBlock)okBlock
               canleButton:(canleBlock)canleBlock
{
    CGFloat titleFontSize = 14;//标题字体大小
    CGFloat messageFontSize = 14;//信息字体大小
    CGFloat maxHeight = 200;//信息最大高度
    
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];

    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.masksToBounds=YES;
    bgView.layer.cornerRadius=5;
    
    [backView addSubview:bgView];
    
    bgView.sd_layout
    .centerXEqualToView(backView)
    .centerYEqualToView(backView)
    .widthRatioToView(backView,0.75);

    
    UIImageView *iconImageView=[[UIImageView alloc]init];
    iconImageView.image= image;
    
    [bgView addSubview:iconImageView];
    
    iconImageView.sd_layout
    .topSpaceToView(bgView,55*kHeightRatio)
    .centerXEqualToView(bgView)
    .widthIs(150*kHeightRatio)
    .heightIs(150*kHeightRatio);
    
   
    UILabel *label1=[[UILabel alloc]init];
    label1.font=[UIFont systemFontOfSize:titleFontSize];
    label1.text= title;
    label1.textAlignment=1;
    label1.textColor=[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    [bgView addSubview:label1];
    
    label1.sd_layout
    .topSpaceToView(iconImageView,10)
    .centerXEqualToView(iconImageView)
    .widthRatioToView(bgView,0.8)
    .heightIs(55*kHeightRatio);
    
    //系统返回提示语label
    if(leftString ==nil)
    {
        label1.frame = CGRectZero;
    }
    [label1 sizeToFit];
    UILabel *label2=[[UILabel alloc]init];
    label2.numberOfLines = 0;
    label2.font=[UIFont systemFontOfSize:messageFontSize];
    label2.text=message;
    label2.textAlignment= NSTextAlignmentCenter;
    label2.textColor=[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    [bgView addSubview:label2];
    label2.sd_layout
    .leftSpaceToView(bgView,10)
    .rightSpaceToView(bgView,10)
    .topSpaceToView(label1,10)
    .autoHeightRatio(0)
    .maxHeightIs(maxHeight);//设置自适应
    [label2 updateLayout];
    UIView *line = [UIView new];
    [bgView addSubview:line];
    line.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1] ;
    line.sd_layout
    .topSpaceToView(label2,10)
    .leftEqualToView(bgView)
    .rightEqualToView(bgView)
    .heightIs(1);
    
#warning ----用空改下使用划线-----
     //[ToolMethod drawLineWithFrame:CGRectMake(0, lineHeiht, kScreenWidth, 2) SuperView:bgView];
    //[ToolMethod drawLineWithFrame:CGRectMake(0, lineHeiht, kScreenWidth, 2) SuperView:bgView LineColor:[UIColor redColor]];
       if (AlertViewTypeSuccess == type)
    {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 1005;
        [button setTitle:rightString forState:UIControlStateNormal];
        [button setTitleColor:[self hexStringToColor:@"eb4936"] forState:UIControlStateNormal];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=4;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
        button.sd_layout
        .centerXEqualToView(bgView)
        .topSpaceToView(line,0)
        .widthRatioToView(bgView,0.7)
        .heightIs(120*kHeightRatio);
        //设置根据子视图高度自适应
        [bgView setupAutoHeightWithBottomView:button bottomMargin:10];
       
    }
    else if (AlertViewTypeSelect == type)
    {
        NSArray *titleArray = @[leftString,rightString];
        for (int i = 0; i < 2; i ++)
        {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = 1004+ i;
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            button.backgroundColor=[UIColor colorWithRed:0.92 green:0.28 blue:0.21 alpha:1];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.masksToBounds=YES;
            button.layer.cornerRadius=4;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:button];
            if (i == 0)
            {
                button.sd_layout
                .leftSpaceToView(bgView,10)
                .topSpaceToView(line,0)
                .widthRatioToView(bgView,0.4)
                .heightIs(120*kHeightRatio);

            }
            else
            {
                button.sd_layout
                .rightSpaceToView(bgView,10)
                .topSpaceToView(line,0)
                .widthRatioToView(bgView,0.4)
                .heightIs(120*kHeightRatio);
            }
            [bgView setupAutoHeightWithBottomView:button bottomMargin:15];
        }
    }
    [bgView updateLayout];
    [aView addSubview:backView];
    _tempView = backView;
    
    self.okBlock = okBlock;
    self.canleBlock = canleBlock;
}

- (void)buttonAction:(UIButton *)btn {
    if (btn.tag == 1004){
        if (self.canleBlock)
        {
            if (_tempView)
            {
                [_tempView removeFromSuperview];
                
            }
            self.canleBlock();
        }
        
    }else if (btn.tag == 1005){
        if (self.okBlock)
        {
            if (_tempView)
            {
                [_tempView removeFromSuperview];
                
            }
            self.okBlock();
        }
    }
}

//  十六进制颜色
-(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



@end
