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
    
    
    //    NSDictionary *dic = @{@"guid":@"guid", @"name":@"name", @"adress":@"adress", @"skill":@"skill"};
    //    return dic;
    NSSet *propertySet = [People propertyKeys];
    NSMutableDictionary *temDic = [[NSMutableDictionary alloc] init];
    for(NSString *property in propertySet){
        
        if([property isEqualToString:@"personalID"]){
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
