//
//  Cook.h
//  Recipes
//
//  Created by Mike Bradford on 5/21/12.
//  Copyright (c) 2012 Crossraods Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cook : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * auth_key;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSSet *cookbooks;
@property (nonatomic, retain) NSSet *recipes;

+ (Cook *)cook;

@end

@interface Cook (CoreDataGeneratedAccessors)

- (void)addCookbooksObject:(NSManagedObject *)value;
- (void)removeCookbooksObject:(NSManagedObject *)value;
- (void)addCookbooks:(NSSet *)values;
- (void)removeCookbooks:(NSSet *)values;
- (void)addRecipesObject:(NSManagedObject *)value;
- (void)removeRecipesObject:(NSManagedObject *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;
@end
