//
//  MVView.m
//  volumeView
//
//  Created by Misheral on 16/7/13.
//  Copyright © 2016年 Misheral. All rights reserved.
//

#import "MVView.h"

@interface MVView ()

@property (strong, nonatomic) UIView *roundView;
@property (strong, nonatomic) UIView *volumeView;

@end

@implementation MVView


- (instancetype)init{
    return [self initWithFrame:CGRectMake(200, 200, 0, 0)];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (CGRectGetWidth(frame) <= 0 || CGRectGetHeight(frame) <= 0 ) {
        frame.size = CGSizeMake(200, 200);
    }
    self = [super initWithFrame:frame];
    [self configView];
    [self loadSubViews];
    [self updateVolume];
    return self;
}

- (void)updateVolume{
    self.volume = 0;
}

- (void)updateVolumeFrame:(float)volume{
    CGRect rect = self.volumeView.frame;
    CGFloat height = CGRectGetHeight(self.roundView.frame);
    //获取百分比
    float rate = volume;
    rect.size.height = height * rate;
    rect.origin.y = height - CGRectGetHeight(rect);
    self.volumeView.frame = rect;
}

- (void)configView{
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor darkGrayColor];
    self.roundColor = [UIColor whiteColor];
}

- (void)loadSubViews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.roundView = [[UIView alloc] initWithFrame:CGRectMake(100 - 20, 50, 40, 80)];
    self.roundView.backgroundColor = [UIColor clearColor];
    self.roundView.layer.borderColor = self.roundColor.CGColor;
    self.roundView.layer.borderWidth = 5;
    self.roundView.layer.cornerRadius = 20;
    self.roundView.clipsToBounds = YES;
    self.roundView.layer.shouldRasterize = YES;
    [self addSubview:self.roundView];
    
    self.volumeView = [[UIView alloc] initWithFrame:self.roundView.bounds];
    self.volumeView.backgroundColor = self.roundColor;
    [self.roundView addSubview:self.volumeView];
}

- (void)setRoundColor:(UIColor *)roundColor{
    _roundColor = roundColor;
    if (self.roundView) {
        self.roundView.layer.borderColor = roundColor.CGColor;
        self.volumeView.backgroundColor = roundColor;
    }
    
    [self setNeedsDisplay];
}

- (void)setVolume:(float)volume{
    _volume = volume;
    [self updateVolumeFrame:volume];
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 8);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 80, 170);
    CGContextAddLineToPoint(context, 80 + 40, 170);
    CGContextMoveToPoint(context, 80 + 20, 170);
    CGContextAddLineToPoint(context, 80 + 20, 170 - 20);
    CGContextMoveToPoint(context, 60, 100);
    CGContextAddLineToPoint(context, 60, 110);
    CGContextAddCurveToPoint(context, 60, 110, 60, 150, 100, 150);
    CGContextAddCurveToPoint(context, 100, 150, 140, 150, 140, 110);
    CGContextAddLineToPoint(context, 140, 100);
    [self.roundColor setStroke];
    CGContextStrokePath(context);
}

@end
