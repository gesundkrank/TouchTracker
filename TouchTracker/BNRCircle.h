//
//  BNRCircle.h
//  TouchTracker
//
//  Created by Jan Graßegger on 02.05.14.
//  Copyright (c) 2014 Jan Graßegger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRPoint.h"

@interface BNRCircle : NSObject

@property (nonatomic, strong) NSArray *points;

- (instancetype) initWithPoints: (NSArray *)points;

@end
