//
//  ZoomViewController.m
//  UI_Practice_07
//
//  Created by DukeMou on 15/4/27.
//  Copyright (c) 2015年 河南蓝鸥科技有限公司. All rights reserved.
//

#import "ZoomViewController.h"

@interface ZoomViewController ()<UIScrollViewDelegate>
@end

@implementation ZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //设置代理
    scrollView.delegate = self;
    //设置最小缩放比例
    scrollView.minimumZoomScale = 0.3;
    //设置最大缩放比例
    scrollView.maximumZoomScale = 3;
    //当前比例,默认为1，表示不缩放
    scrollView.zoomScale = 1;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 250)];
    imageView.image = [UIImage imageNamed:@"image"];
    imageView.center = CGPointMake( CGRectGetWidth(scrollView.frame) / 2, CGRectGetHeight(scrollView.frame) / 2);
    
    imageView.tag = 212;
    
    [scrollView addSubview:imageView];
    [imageView release];
    
    [self.view addSubview:scrollView];
    [scrollView release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//为滑动视图指定要缩放的视图对象
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView viewWithTag:212];
}
//当scrollView正在缩放时会频繁响应该方法
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //x和y轴的增量为：当scrollView自身的宽度或者高度大于其contentSize的宽度或者高度时，增量为：自身宽度或者高度减去contentSize宽度或者高度除以2，否则为0
    CGFloat delta_x = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) / 2 : 0;
    CGFloat delta_y = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) / 2 : 0;
    UIImageView *imageView = (UIImageView *)[scrollView viewWithTag:212];
    //实时修改imageView的center属性，让其保持居中
    imageView.center = CGPointMake(scrollView.contentSize.width / 2 + delta_x, scrollView.contentSize.height / 2 + delta_y);
    
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
