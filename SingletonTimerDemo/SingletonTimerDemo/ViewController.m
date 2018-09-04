//
//  ViewController.m
//  SingletonTimerDemo
//
//  Created by YLG on 2018/9/4.
//  Copyright © 2018年 YLG. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

#import "CaptchaTimerManager.h"
#import "UIColor+Hex.h"
#import "UIImage+Color.h"

#define kLeftCountTime 60


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FirstView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initButtons];
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)initButtons{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGSize btnSize = CGSizeMake(width-2*40, 50);
    
    
    
    
    UIButton *pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, height/2, width-2*40, 50)];
    [pushBtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [pushBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pushBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2aaa26] size:btnSize] forState:UIControlStateNormal];
    [pushBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xa5dda4] size:btnSize] forState:UIControlStateDisabled];
    [pushBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2a9826] size:btnSize] forState:UIControlStateHighlighted];
    pushBtn.tag = 1;
    pushBtn.layer.cornerRadius = 4.f;
    pushBtn.layer.masksToBounds= YES;
    [self.view addSubview:pushBtn];
}

-(void)BtnClicked:(id)sender{
    [self pushToSecondPage];
}

-(void)pushToSecondPage{
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
