//
//  APLModuleInput.h
//  APL Viper
//
//  Created by Semyon Belokovsky on 20/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APLModuleOutput;

@protocol APLModuleInput <NSObject>

@optional

- (void)setModuleOutput:(id<APLModuleOutput>)moduleOutput;

@end
