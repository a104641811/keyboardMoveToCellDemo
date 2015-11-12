//
//  DWDInfoDetailHeader.m
//  DWDSj
//
//  Created by apple  on 15/10/30.
//  Copyright © 2015年 dwd. All rights reserved.
//

#import "DWDInfoDetailHeader.h"

@interface DWDInfoDetailHeader()

@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;

@end

@implementation DWDInfoDetailHeader
- (IBAction)collectionBtnClick:(UIButton *)sender {
    DWDLogFunc;
}
- (IBAction)conmentBtnClick:(UIButton *)sender {
    DWDLogFunc;
}
- (IBAction)zanBtnClick:(UIButton *)sender {
    DWDLogFunc;
}

+ (instancetype)header{
    return [[[NSBundle mainBundle] loadNibNamed:@"DWDInfoDetailHeader" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    // 根据自己最后的一个控件计算自己的高度
    self.frame = CGRectMake(0, 0, DWDScreenW, CGRectGetMaxY(self.collectionBtn.frame));
}


@end
