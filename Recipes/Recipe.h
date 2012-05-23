//
//  Recipe.h
//  Recipes
//
//  Created by Mike Bradford on 5/21/12.
//  Copyright (c) 2012 Crossraods Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cook, Cookbook;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * directions;
@property (nonatomic, retain) Cook *cook;
@property (nonatomic, retain) Cookbook *cookbook;

@end
