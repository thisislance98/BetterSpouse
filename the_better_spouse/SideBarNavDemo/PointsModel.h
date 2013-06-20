//
//  PointsModel.h
//  the_better_spouse
//
//  Created by chenxin on 13-6-4.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointsModel : NSObject

@property (nonatomic, assign) NSInteger points;
@property (nonatomic, strong) NSString *goodHabits;
@property (nonatomic, strong) NSString *badHabits;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSMutableArray *taskArray;
@property (nonatomic, strong) NSMutableArray *scoreArray;
@property (nonatomic, strong) NSMutableArray *youTaskArray;
@property (nonatomic, strong) NSMutableArray *youScoreArray;
@property (nonatomic, strong) NSMutableArray *themTaskArray;
@property (nonatomic, strong) NSMutableArray *themsScoreArray;

- (id)initWithTaskArray:(NSMutableArray *)taskArray andScoreArray:(NSMutableArray *)scoreArray;
@end
