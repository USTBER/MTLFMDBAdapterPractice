//
//  PeopleStore.h
//  MTLFMDBAdapterPractice
//
//  Created by LiChunxing on 16/3/29.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People.h"
@interface PeopleStore : NSObject

+ (id)sharedPeopleStroe;
- (BOOL)addNewPeopleWithProperty:(NSDictionary *)properties;
- (NSArray *)peopleWithProperty:(NSDictionary *)properties;
- (NSArray *)getAllPeople;
- (BOOL)removePeopleWithProperty:(NSDictionary *)properties;
- (BOOL)updatePeople:(People *)p withProperty:(NSDictionary *)properties;
- (void)deleteTable;
@end
