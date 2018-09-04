//
//  SecondViewController.m
//  SingletonTimerDemo
//
//  Created by YLG on 2018/9/4.
//  Copyright © 2018年 YLG. All rights reserved.
//

#import "SecondViewController.h"
#import "CaptchaTimerManager.h"
#import "UIColor+Hex.h"
#import "UIImage+Color.h"
#import "ThirdViewController.h"

#define kLeftCountTime 60
@interface SecondViewController ()
@property (nonatomic,strong) NSTimer *timer; // 定时器
@property(nonatomic,copy) __block NSString *tringTimeStr;
@property(nonatomic,assign) __block int timeout;

@property(nonatomic,strong) UIButton *Btn;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"sendView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initButtons];
    // Do any additional setup after loading the view.
}

-(void)initButtons{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGSize btnSize = CGSizeMake(width-2*40, 50);
    
    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(40, height/2-100, width-2*40, 50)];
    [Btn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [Btn setTitle:@"开始" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2aaa26] size:btnSize] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xa5dda4] size:btnSize] forState:UIControlStateDisabled];
    [Btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2a9826] size:btnSize] forState:UIControlStateHighlighted];
    Btn.layer.cornerRadius = 4.f;
    Btn.layer.masksToBounds= YES;
    Btn.tag = 0;
    [self.view addSubview:Btn];
    self.Btn = Btn;
    
    
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
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:
            _timeout = kLeftCountTime;
            [self timerCountDown];
            break;
        case 1:
            [self pushToSecondPage];
            break;
            
        default:
            break;
    }
    
}

-(void)pushToSecondPage{
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:thirdVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    
    CaptchaTimerManager *manager = [CaptchaTimerManager sharedTimerManager];
    int temp = manager.timeout;
    if (temp >0) {
        _timeout= temp;//倒计时时间
        [self timerCountDown];
    }
    
}



-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timeout >0) {
        CaptchaTimerManager *manager = [CaptchaTimerManager sharedTimerManager];
        if (manager.timeout ==0) {
            manager.timeout =_timeout;
            [manager countDown];
        }
        _timeout = 0;//置为0，释放controller
    }
}

- (void)timerCountDown {
    //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(_timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _tringTimeStr = nil;
                [self.Btn setTitle:@"开始" forState:UIControlStateNormal];
                self.Btn.enabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _tringTimeStr = [NSString stringWithFormat:@"%d s重试",_timeout];
                [self.Btn setTitle:_tringTimeStr forState:UIControlStateNormal];
                self.Btn.enabled = NO;
                _timeout--;
            });
        }
    });
    dispatch_resume(_timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
