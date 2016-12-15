//
//  APLSegue.h
//  Pods
//
//  Created by Semyon Belokovsky on 14/12/2016.
//
//

#import <UIKit/UIKit.h>

@interface APLSegue : NSObject

@property (nonatomic, weak) UIViewController *source;
@property (nonatomic, strong) UIViewController *destination;

- (void)perform;
- (void)unwind;

@end
