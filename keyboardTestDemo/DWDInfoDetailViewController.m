//
//  DWDInfoDetailViewController.m
//  DWDSj
//
//  Created by apple  on 15/10/30.
//  Copyright © 2015年 dwd. All rights reserved.
//

#import "DWDInfoDetailViewController.h"
#import "DWDInfoDetailHeader.h"
#import "DWDInfoDetailCell.h"
#import "DWDTableView.h"
@interface DWDInfoDetailViewController () < UITableViewDelegate , UITableViewDataSource , DWDInfoDetailCellDelegate>
@property (weak, nonatomic) IBOutlet DWDTableView *tableView;
/**
 *  底部文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *bottomField;
/**
 *  头部视图
 */
@property (nonatomic , weak) DWDInfoDetailHeader *headerView;
/**
 *  文本框底部  对  控制器view底部 的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fieldBottomCons;
/**
 *  保存点击cell的角标
 */
@property (nonatomic , assign) NSUInteger index;
/**
 *  保存点击第一个cell时 ,cell底部距离屏幕底部的距离
 */
@property (nonatomic , assign) CGFloat delta;
/**
 *  动画时间
 */
@property (nonatomic , assign) CGFloat duration;
/**
 *  切换键盘时,被切换的键盘的Y值
 */
@property (nonatomic , assign) CGFloat lastEndKeyBY;
@end

@implementation DWDInfoDetailViewController

- (void)awakeFromNib{
    self.hidesBottomBarWhenPushed = YES;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 监听底部键盘事件
    [self observeBottomField];
    // 设置tableview
    [self setupTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

/**
 *  设置tableview
 */
- (void)setupTableView{
    _tableView.rowHeight = 150;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    DWDInfoDetailHeader *detailHeader = [DWDInfoDetailHeader header];
    _headerView = detailHeader;
    _tableView.tableHeaderView = detailHeader;
}


/**
 *  监听底部键盘事件
 */
- (void)observeBottomField{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillHide:(NSNotification *)note{
    CGFloat endLocation = - _bottomField.height;
    [UIView animateWithDuration:_duration animations:^{
        _fieldBottomCons.constant = endLocation;
        [self.view layoutIfNeeded];
    }];
}

/**
 *  监听键盘的通知方法
 */
- (void)keyboardWillshow:(NSNotification *)note{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 接受键盘弹出的第一个通知时,动画时间才有值,保存起来
    if (duration > 0) {
        _duration = duration;
    }
    
    // 当键盘高度完全布局好的时候
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardH = frame.size.height;
    CGFloat endLocation = DWDScreenH - frame.origin.y;
    CGFloat offY = _tableView.contentOffset.y + (keyBoardH + _bottomField.height);
    
    if (_bottomField.y < DWDScreenH) { // 键盘正在展示中,收到的通知是切换键盘的通知
        offY = _lastEndKeyBY - frame.origin.y;
        // 改变此时tableview的offset
        [UIView animateWithDuration:duration animations:^{
            _fieldBottomCons.constant = endLocation;
            [_tableView setContentOffset:CGPointMake(0, _tableView.contentOffset.y + offY)];
            [self.view layoutIfNeeded];
        }];
        // 正在展示中也有可能继续切换其他的键盘
        _lastEndKeyBY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        return;
    }else{  // 键盘没有在展示,是从底部钻上来的,此时应该保存一下键盘最终Y值作为切换键盘前的旧Y值
        _lastEndKeyBY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        if (_index == 0) {
            // 点的是第一个cell
            if (_delta > 0) {
                offY = offY - _delta;
            }
        }
    }
    [UIView animateWithDuration:duration animations:^{
        _fieldBottomCons.constant = endLocation;
        [_tableView setContentOffset:CGPointMake(0, offY)];
        [self.view layoutIfNeeded];
    }];
}

/**
 *  移除通知中心观察者
 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - <DWDInfoDetailCellDelegate>
/**
 *  监听到cell中回复按钮被点击,让底部field弹出键盘,并且滚动到底部
 */
- (void)btnClickWithIndex:(NSUInteger)index{
    _index = index;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    // 计算第一个cell距离屏幕底部偏移量
    if (index == 0) {
        CGRect cellZeroF = [_tableView rectForRowAtIndexPath:indexPath];
        CGFloat cellZeroMaxY = CGRectGetMaxY(cellZeroF);
        _delta = -64 + DWDScreenH - cellZeroMaxY;
    }
    
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    [_bottomField becomeFirstResponder];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"InfoDetailCell";
    DWDInfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DWDInfoDetailCell" owner:nil options:nil] lastObject];
    }
    
    cell.index = indexPath.row;
    cell.btnClickDelegate = self;
    cell.userName.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    cell.commentLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];    
}

@end
