//
//  RootTableViewController.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/1.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *viewControllers;
@end

@implementation RootTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画研究";
    self.navigationController.view.layer.cornerRadius = 10;
    self.navigationController.view.layer.masksToBounds = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

#pragma mark - lazyLoding

- (NSArray *)data{
    if (!_data) {
        _data = [@[@"uiview动画",@"Transform和KeyFrame",@"Masory约束动画",@"Masory约束动画1",@"支付宝咻一咻动画",@"弹性动画",@"购物车动画"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [@[@"ViewController",@"TransformAndkeViewController",@"MasoryAnimationViewController",@"MasoryAnimationViewController1",@"SoundWaveViewController",@"ElasticAnimationViewController",@"ShoppingAnimationViewController"] copy];
    }
    return _viewControllers;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   

    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init] animated:YES];
}


@end
