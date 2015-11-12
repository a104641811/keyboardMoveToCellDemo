//
//  DWDTableView.m
//  EduChat
//
//  Created by ye on 15/11/4.
//  Copyright © 2015年 dwd. All rights reserved.
//

#import "DWDTableView.h"

@implementation DWDTableView

//-(BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
//    [self.superview endEditing:YES];
//    return [super touchesShouldBegin:touches withEvent:event inContentView:view];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.superview endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
