//
//  MasoryAnimationViewController1.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/1.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "MasoryAnimationViewController1.h"
#import "Masonry.h"
#import "YJAnimateButton.h"

static NSString *tableId = @"tableCellid";
@interface MasoryAnimationViewController1 ()<UITableViewDelegate,UITableViewDataSource>
//约束
@property (nonatomic, assign)  CGFloat  listTopConstraint;//列表的顶部
@property (nonatomic, assign)  CGFloat  listHeightConstraint;//列表的高度
@property (nonatomic, assign)  CGFloat  accountHeightConstraint;//账号的高度

//控件
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) YJAnimateButton *loginBtn;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIButton *dropDownBtn;

//  数据
@property (assign, nonatomic) BOOL isAnimating;
@property (strong, nonatomic) NSArray<NSString *> *records;
@end

@implementation MasoryAnimationViewController1

// MARK:  - life period
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(105/255.f) green:(175/255.f) blue:(199/255.f) alpha:1];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.headImg];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.accountTextField];
    [self.view addSubview:self.dropDownBtn];
    
    self.listTopConstraint = 0;
    self.listHeightConstraint = 0;
    self.accountHeightConstraint = 30;
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(80);
    }];
    
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).mas_offset(25);
        make.trailing.mas_equalTo(self.view).mas_offset(-25);
        make.height.mas_equalTo(self.accountHeightConstraint);
        make.top.mas_equalTo(self->_headImg.mas_bottom).mas_offset(50);
    }];
    
    [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).mas_offset(25);
        make.trailing.mas_equalTo(self.view).mas_offset(-25);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self->_accountTextField.mas_bottom).mas_offset(20);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).mas_offset(25);
        make.trailing.mas_equalTo(self.view).mas_offset(-25);
        make.height.mas_equalTo(46);
        make.top.mas_equalTo(self->_pwdTextField.mas_bottom).mas_offset(45);
    }];
    
    [_dropDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->_accountTextField.mas_centerY);
        make.trailing.mas_equalTo(self->_accountTextField.mas_trailing);
        make.size.mas_equalTo(CGSizeMake(30, 36));
    }];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.mas_equalTo(self->_accountTextField);
        make.top.mas_equalTo(self->_accountTextField).mas_offset(self.listTopConstraint);
        make.height.mas_equalTo(self->_accountTextField).mas_offset(self.listHeightConstraint);
    }];
    // Do any additional setup after loading the view.
}



// MARK:  - action
- (void)actionToOpenOrCloseList:(UIButton *)sender {
    [self.view endEditing: YES];
    [self animateToRotateArrow: sender.selected];
    sender.isSelected ? [self showRecordList] : [self hideRecordList];
}


- (void)actionToSignIn:(UIButton *)sender {
    _isAnimating = !_isAnimating;
    if (_isAnimating) {
        [self.loginBtn start];
        
        [UIView animateWithDuration:0.15 animations:^{
            [_loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.view);
                make.width.height.mas_equalTo(46);
                make.top.mas_equalTo(self->_pwdTextField.mas_bottom).mas_offset(45);
            }];
            [self.view layoutIfNeeded];
        }];
    } else {
        [self.loginBtn stop];
        
        [UIView animateWithDuration:0.15 animations:^{
            [_loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.view).mas_offset(25);
                make.trailing.mas_equalTo(self.view).mas_offset(-25);
                make.height.mas_equalTo(46);
                make.top.mas_equalTo(self->_pwdTextField.mas_bottom).mas_offset(45);
            }];
            [self.view layoutIfNeeded];
        }];
    }
}
//显示记录列表 方法2
- (void)showRecordList{
    //布局的代码不能写到viewWillLayoself->utSubviews 写到里面 相当于执行了两遍mas_remakeConstraints，可以把布局的代码写到viewdidload中
    self.listTopConstraint = self.accountHeightConstraint;
    self.listHeightConstraint = self.accountHeightConstraint*5;
    [UIView animateWithDuration: 0.25 delay: 0 usingSpringWithDamping: 0.4 initialSpringVelocity: 5 options: UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations: ^{
        [self->_tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.leading.mas_equalTo(self->_accountTextField);
            make.top.mas_equalTo(self->_accountTextField).mas_offset(self.listTopConstraint);
            make.height.mas_equalTo(self->_accountTextField).mas_offset(self.listHeightConstraint);
        }];
        [self.view layoutIfNeeded];//重新布局
        //        用来立刻刷新界面，这个方法会调用当前视图上面所有的子视图的- (void)layoutSubviews让子视图进行重新布局
    } completion: nil];
}
//隐藏记录列表
- (void)hideRecordList{
    self.listTopConstraint = 0;
    self.listHeightConstraint = 0;
    [self.view setNeedsLayout];
    [UIView animateWithDuration: 0.25 animations: ^{
        [_tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.leading.mas_equalTo(self->_accountTextField);
            make.top.mas_equalTo(self->_accountTextField).mas_offset(self.listTopConstraint);
            make.height.mas_equalTo(self->_accountTextField).mas_offset(self.listHeightConstraint);
        }];
        [self.view layoutIfNeeded];
    } completion: nil];
}
// 按钮转向动画
- (void)animateToRotateArrow: (BOOL)selected
{
    //2.
    CATransform3D transform = selected ? CATransform3DIdentity : CATransform3DMakeRotation(M_PI, 0, 0, 1);
    [self.dropDownBtn setSelected: !selected];
    [UIView animateWithDuration: 0.25 animations: ^{
        self.dropDownBtn.layer.transform = transform;
    }];
    //1.
    //    CGAffineTransform tranform = selected?CGAffineTransformIdentity: CGAffineTransformMakeRotation(M_PI);
    //    [self.dropDownBtn setSelected:!selected];
    //    [UIView animateWithDuration:0.25 animations:^{
    //        self.dropDownBtn = tranform;
    //    } completion:nil];
    
    
}

// MARK:  - delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableId];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = self.records[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _accountTextField.text = self.pwdTextField.text = self.records[indexPath.row];
    [self animateToRotateArrow: YES];
    [self hideRecordList];
}

// MARK: - getter and setter
- (NSArray<NSString *> *)records
{
    if (!_records) {
        NSMutableArray * records = @[].mutableCopy;
        for (NSInteger idx = 0; idx < 8; idx++) {
            [records addObject: [NSString stringWithFormat: @"record%02lu", idx]];
        }
        _records = records;
    }
    return _records;
}

- (UIImageView *)headImg{
    if (!_headImg) {
        _headImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"article_author"]];
        _headImg.layer.cornerRadius = 25;
        _headImg.layer.masksToBounds = YES;
    }
    return _headImg;
}
- (UITextField *)pwdTextField{
    if (!_pwdTextField) {
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.font = [UIFont systemFontOfSize:14];
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.backgroundColor = [UIColor whiteColor];
        _pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _pwdTextField.placeholder = @"password";
    }
    return _pwdTextField;
}
- (UITextField *)accountTextField{
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.font = [UIFont systemFontOfSize:14];
        _accountTextField.backgroundColor = [UIColor whiteColor];
        _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
        _accountTextField.placeholder = @"account";
    }
    return _accountTextField;
}
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.dataSource = self ;
        _tableview.delegate = self ;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableview.layer.masksToBounds = YES;
        _tableview.layer.cornerRadius = 5;
        _tableview.separatorInset = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableview;
}

- (YJAnimateButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[YJAnimateButton alloc] init];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 23;
        _loginBtn.backgroundColor =  [UIColor colorWithRed:(29/255.f) green:(189/255.f) blue:(80/255.f) alpha:1];
        [_loginBtn setTitle:@"login" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(actionToSignIn:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.radius = 20;
    }
    return _loginBtn;
}
- (UIButton *)dropDownBtn{
    if (!_dropDownBtn) {
        _dropDownBtn = [[UIButton alloc] init];
        [_dropDownBtn setImage:[UIImage imageNamed:@"drop_down"] forState:UIControlStateNormal];
        [_dropDownBtn addTarget:self action:@selector(actionToOpenOrCloseList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dropDownBtn;
}

@end

