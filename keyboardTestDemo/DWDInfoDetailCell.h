//
//  DWDInfoDetailCell.h
//  EduChat
//
//  Created by apple  on 15/11/4.
//  Copyright © 2015年 dwd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DWDInfoDetailCellDelegate <NSObject>
/**
 *  cell中的回复按钮被点击代理方法
 */
- (void)btnClickWithIndex:(NSUInteger)index;

@end

@interface DWDInfoDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;

/**
 *  保存当前是哪个cell
 */
@property (nonatomic , assign) NSUInteger index;

/**
 *  回复按钮被点击代理
 */
@property (nonatomic , weak) id btnClickDelegate;

@end
