//
//  TrasitionRootViewController.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/5.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "TrasitionRootViewController.h"
/**
 1.我们需要自定义一个遵循的<UIViewControllerAnimatedTransitioning>协议的动画过渡管理对象，并实现两个必须实现的方法：
 //返回动画事件
 - (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
 //所有的过渡动画事务都在这个方法里面完成
 - (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;

 2.我们还需要自定义一个继承于UIPercentDrivenInteractiveTransition的手势过渡管理对象，我把它成为百分比手势过渡管理对象，因为动画的过程是通过百分比控制的
 
 3.成为相应的代理，实现相应的代理方法，返回我们前两步自定义的对象就OK了 ！
 模态推送需要实现如下4个代理方法，iOS8新的那个方法我暂时还没有发现它的用处，所以暂不讨论
 //返回一个管理prenent动画过渡的对象
 - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
 //返回一个管理pop动画过渡的对象
 - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
 //返回一个管理prenent手势过渡的对象
 - (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
 //返回一个管理pop动画过渡的对象
 - (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;
 
 导航控制器实现如下2个代理方法
 //返回转场动画过渡管理对象
 - (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
 interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0);
 //返回手势过渡管理对象
 - (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
 animationControllerForOperation:(UINavigationControllerOperation)operation
 fromViewController:(UIViewController *)fromVC
 toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
 
 标签控制器也有相应的两个方法
 //返回转场动画过渡管理对象
 - (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
 interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0);
 //返回手势过渡管理对象
 - (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
 animationControllerForTransitionFromViewController:(UIViewController *)fromVC
 toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
 
 */
@interface TrasitionRootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *viewControllers;
@end

@implementation TrasitionRootViewController
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转场动画";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupUi];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 懒加载
- (NSArray *)data{
    if (!_data) {
        _data = [@[@"头条评论present动画"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [@[@"PresentOneViewController"] copy];
    }
    return _viewControllers;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self ;
        _tableView.delegate = self ;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

#pragma mark - 设置UI
- (void)setupUi{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}
#pragma mark - 加载数据
#pragma mark  - delegate
#pragma mark  tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init] animated:YES];
}
#pragma mark  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
@end
