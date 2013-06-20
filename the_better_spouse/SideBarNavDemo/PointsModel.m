//
//  PointsModel.m
//  the_better_spouse
//
//  Created by chenxin on 13-6-4.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "PointsModel.h"

@implementation PointsModel

- (id)initWithTaskArray:(NSMutableArray *)taskArray andScoreArray:(NSMutableArray *)scoreArray
{
    if (self = [super init]) {
        _taskArray = taskArray;
        _scoreArray = scoreArray;
        NSLog(@"-------:%@---------:%@",_taskArray,_scoreArray);
    }
    return self;
}

@end
