//
//  People.m
//  MTLFMDBAdapterPractice
//
//  Created by LiChunxing on 16/3/29.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "People.h"

@implementation People

+ (NSDictionary *)FMDBColumnsByPropertyKey{
    
    NSDictionary *dic = @{@"guid":@"guid", @"name":@"name", @"adress":@"adress", @"skill":@"skill"};
    return dic;
}

+ (NSArray *)FMDBPrimaryKeys{
    
    return @[@"guid"];
}

+ (NSString *)FMDBTableName{
    
    return @"t_people";
}

@end
