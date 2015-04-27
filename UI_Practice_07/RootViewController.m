//
//  ViewController.m
//  UI_Practice_07
//
//  Created by DukeMou on 15/4/27.
//  Copyright (c) 2015年 河南蓝鸥科技有限公司. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UIScrollViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建scrollView对象是使用UIView中继承而来的初始化方法
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //通过设置contentSize来确定内容区域的大小，只要其大小大于scrollView自身的大小就可以产生滑动
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.bounds) * 8, CGRectGetHeight(scrollView.bounds));
    
    for (int i = 0; i < 8; i++) {
        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(scrollView.bounds), 0, CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds))];
        aLabel.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
        aLabel.font = [UIFont systemFontOfSize:100];
        aLabel.adjustsFontSizeToFitWidth = YES;
        aLabel.text = [NSString stringWithFormat:@"第%d个label", i + 1];
        [scrollView addSubview:aLabel];
        [aLabel release];
    }
    
    //通过设置pagingEnabled属性可以控制scrollView的子视图按整屏翻动,默认为NO
    scrollView.pagingEnabled = YES;
    //通过修改内容区域的偏移量让指定子视图显示,offSet影响的是scrollView的bounds，而bounds影响的是scorllView产生的坐标系的位置，从而影响到子视图的位置
    scrollView.contentOffset = CGPointMake(CGRectGetWidth(scrollView.bounds), 0);
    //滑动视图的边界回弹动画，默认为YES。表示开启动画，设置为NO时，当滑动到边缘是就无效果
    scrollView.bounces = YES;
    //控制横向滑动指示器是否显示，默认为显示
    scrollView.showsHorizontalScrollIndicator = NO;
    //设置纵向滑动指示器是否显示，默认也为显示
    scrollView.showsVerticalScrollIndicator = NO;
    //滑动方向锁定，默认为NO，表示不锁定
    scrollView.directionalLockEnabled = YES;
    //默认为NO,当设置为YES时，可以运行content小于scrollView的bounds依然产生边界回弹
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.alwaysBounceVertical = YES;
    //默认只要scrollView的content大于其bounds就可产生滑动，默认为YES，但在某些情况下可以通过设置其为NO而不允许滑动
    scrollView.scrollEnabled = YES;
    
    //如果要成为scrollView的代理对象，需要为其delegate属性赋值
    scrollView.delegate = self;
    
    //设置tag
    scrollView.tag = 111;
    
    [self.view addSubview:scrollView];
    [scrollView release];
    
    //---------------UIPageControl------
    UIPageControl *pagControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 80, CGRectGetWidth(self.view.bounds), 40)];
    //设置其numberOfPages为对应要指示的视图个数
    pagControl.numberOfPages = 8;
    //设置其当前的页码，与数组下标类似，从0开始
    pagControl.currentPage = 1;
    pagControl.tag = 222;
    
    //pageControl作为控件需要在接收到点击事件后产生相应操作，通过targetAction来实现
    [pagControl addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
    //pageControl点击左半区域会让currentPage-1直到0，右半区域点击会让currentPage+1直到最大值，并不是点击小圆点来切换的
    pagControl.backgroundColor = [UIColor orangeColor];
    
    pagControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pagControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self.view addSubview:pagControl];
    [pagControl release];
}

- (void)handlePageControl:(UIPageControl *)sender {
    UIScrollView *scrolllView = (UIScrollView *)[self.view viewWithTag:111];
    CGPoint offset = CGPointMake(sender.currentPage * CGRectGetWidth(scrolllView.bounds), 0);
//    scrolllView.contentOffset = offset;
    [scrolllView setContentOffset:offset animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView Delegate -
//滑动视图将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%s", __FUNCTION__);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%s", __FUNCTION__);
    //该协议方法是当scrollView产生滑动时会响应的方法，如果在滑动过程中会持续响应该方法
    //scrollView本质是通过修改自己的bounds的origin来影响自身产生的坐标系的位置来模拟滑动的。但是一般情况下我们用contentOffset来描述偏移量的概念。偏移量实质上是指scrollView距离坐标系的大小
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //停止对scrollview的拖拽，将要开始减速
    NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    //scrollView将要开始减速
    NSLog(@"%s", __FUNCTION__);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //scrollView停止减速，该方法的执行也标志着scrollView滑动停止
    NSLog(@"%s", __FUNCTION__);
    //通过最终得到的offset值来确定pageControl当前应该指示第几个视图
    NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:222];
    //修改currentPage属性
    pageControl.currentPage = index;
}



@end
