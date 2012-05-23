//
//  Cookbook.h
//  Recipes
//
//  Created by Mike Bradford on 5/21/12.
//  Copyright (c) 2012 Crossraods Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cook;

@interface Cookbook : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) Cook *cook;
@property (nonatomic, retain) NSSet *recipes;
@end

@interface Cookbook (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(NSManagedObject *)value;
- (void)removeRecipesObject:(NSManagedObject *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;
@end
