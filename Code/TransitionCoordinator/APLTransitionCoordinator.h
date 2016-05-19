//
//  APLTransitionCoordinator.h
//  APL Viper
//
//  Created by Semyon Belokovsky on 20/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol APLTransitionCoordinator

@optional

- (UIStoryboardSegue *)segueWithId:(NSString *)segueId;
- (void)configureDestinationController:(UIViewController *)viewController;

@end