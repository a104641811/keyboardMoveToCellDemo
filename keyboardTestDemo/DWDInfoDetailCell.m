//
//  DWDInfoDetailCell.m
//  EduChat
//
//  Created by apple  on 15/11/4.
//  Copyright © 2015年 dwd. All rights reserved.
//

#import "DWDInfoDetailCell.h"

@implementation DWDInfoDetailCell

- (IBAction)replyBtnClick:(id)sender {
    DWDLogFunc;
    if ([self.btnClickDelegate respondsToSelector:@selector(btnClickWithIndex:)]) {
        [self.btnClickDelegate btnClickWithIndex:_index];
    }
}

- (void)setIndex:(NSUInteger)index{
    _index = index;
    
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
