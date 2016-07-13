//
//  ViewController.m
//  volumeView
//
//  Created by Misheral on 16/7/13.
//  Copyright © 2016年 Misheral. All rights reserved.
//

#import "ViewController.h"

#import "MVView.h"

@interface ViewController ()

@property (strong, nonatomic) MVView *mvview;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mvview = [[MVView alloc] init];
    [self.view addSubview:self.mvview];
    
    //修改颜色
//    self.mvview.roundColor = [UIColor whiteColor];
    
   self.timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(updateVolume) userInfo:nil repeats:YES];
    
}

//修改频度
- (void)updateVolume{
    CGFloat v = (float)arc4random_uniform(500)/500;
    self.mvview.volume = v;
}

@end
