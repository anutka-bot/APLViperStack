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

@property (nonatomic, weak) id<APLModuleOutput> moduleOutput;

@end
