//
//  SZHeaderView.m
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZHeaderView.h"

@implementation SZHeaderView

+ (instancetype)viewForXib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SZHeaderView" owner:nil options:nil] lastObject];
}

@end
