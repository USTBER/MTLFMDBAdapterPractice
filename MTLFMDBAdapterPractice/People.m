//
//  People.m
//  MTLFMDBAdapterPractice
//
//  Created by LiChunxing on 16/3/29.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "People.h"
#import "PrefixHeader.pch"
@implementation People

+ (NSDictionary *)FMDBColumnsByPropertyKey{
    
    NSSet *propertySet = [People propertyKeys];
    NSMutableDictionary *temDic = [[NSMutableDictionary alloc] init];
    for(NSString *property in propertySet){
        
        NSString *primaryKey = [[self FMDBPrimaryKeys] objectAtIndex:0];
        if(primaryKey && [property isEqualToString:primaryKey]){
            [temDic setObject:[NSNull null] forKey:property];
        }else{
            [temDic setObject:property forKey:property];
        }
    }
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:temDic copyItems:YES];
    return dic;
    
}

+ (NSArray *)FMDBPrimaryKeys{
    
    return @[@"personalID"];
}

+ (NSString *)FMDBTableName{
    
    return PeopleTableName;
}

@end
