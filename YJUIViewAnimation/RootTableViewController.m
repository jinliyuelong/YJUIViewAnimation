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
        _data = [@[@{@"Uivew动画":@[@{@"uiview动画":@"ViewController"},
                                       @{@"Transform和KeyFrame":@"TransformAndkeViewController"},
                                       @{@"Masory约束动画":@"MasoryAnimationViewController"},
                                  @{@"Masory约束动画1":@"MasoryAnimationViewController1"}]},
                   @{@"Coranimation动画":@[@{@"支付宝咻一咻动画":@"SoundWaveViewController"},
                                     @{@"弹性动画":@"ElasticAnimationViewController"},
                                         @{@"购物车动画":@"ShoppingAnimationViewController"},
                                          @{@"maskview动画":@"MaskAnimationViewController"}]},
                   @{@"转场动画":@[@{@"转场动画":@"TrasitionRootViewController"}]}
                   
                   ] copy];
    }
    return _data;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *view = [[UILabel alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.font = [UIFont systemFontOfSize:14];
    view.textAlignment = NSTextAlignmentCenter;
    NSDictionary *dic = self.data[section];
    view.text = dic.allKeys.firstObject;
   
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = self.data[section];
    NSArray *array = dic.allValues.firstObject;
    return array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary *dic1 = self.data[indexPath.section];
    NSArray *array = dic1.allValues.firstObject;
    NSDictionary *dic = array[indexPath.row];
    cell.textLabel.text = dic.allKeys.firstObject;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic1 = self.data[indexPath.section];
    NSArray *array = dic1.allValues.firstObject;
    NSDictionary *dic = array[indexPath.row];
    NSString *viewcontroller = dic.allValues.firstObject;
    [self.navigationController pushViewController: [[NSClassFromString(viewcontroller) alloc] init] animated:YES];
}


@end
