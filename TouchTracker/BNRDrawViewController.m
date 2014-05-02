//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Jan Graßegger on 01.05.14.
//  Copyright (c) 2014 Jan Graßegger. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawViewController ()

@property (nonatomic, strong) BNRDrawView *drawView;
@property (nonatomic, strong, readonly) NSString *path;

@end

@implementation BNRDrawViewController

- (void)loadView
{
    self.drawView = [[BNRDrawView alloc] initWithFrame:CGRectZero];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:self.path];
    if (fileExists) {
        NSArray *datas = [[NSArray alloc] initWithContentsOfFile:self.path];
        
        for (NSData *data in datas) {
            [self.drawView.finishedLines addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
    }
    
    self.view = self.drawView;
    
}

- (NSString*)path
{
    NSArray *path =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [[path objectAtIndex:0] stringByAppendingPathComponent:@"savefile.plist"];
}

- (void)saveData
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (BNRLine *line in self.drawView.finishedLines) {
        [data addObject:[NSKeyedArchiver archivedDataWithRootObject:line]];
    }
    
    [data writeToFile:self.path atomically:YES];
}

@end
