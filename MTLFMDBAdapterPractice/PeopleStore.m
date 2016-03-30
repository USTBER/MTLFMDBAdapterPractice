//
//  PeopleStore.m
//  MTLFMDBAdapterPractice
//
//  Created by LiChunxing on 16/3/29.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "PeopleStore.h"
#import <FMDB.h>
#import <MTLFMDBAdapter.h>
#import "PrefixHeader.pch"
static PeopleStore *sharedPeopleStore;

@interface PeopleStore ()

@property (nonatomic, copy) NSString *documentPath;
@property (nonatomic, copy) NSString *tablePath;
@property (nonatomic, strong) FMDatabase *peopleDatabase;

@end

@implementation PeopleStore

- (NSString *)documentPath{
    
    if(_documentPath){
        return _documentPath;
    }
    _documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return _documentPath;
}

- (NSString *)tablePath{
    
    if (_tablePath) {
        return  _tablePath;
    }
    _tablePath = [self.documentPath stringByAppendingPathComponent:@"people.sqlite"];
    
    return _tablePath;
}

- (FMDatabase *)peopleDatabase{
    
    
    
    if(_peopleDatabase){
        return _peopleDatabase;
    }
    _peopleDatabase = [FMDatabase databaseWithPath:self.tablePath];
    [_peopleDatabase open];
    NSString *createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, %@ TEXT, %@ TEXT, %@ TEXT)", PeopleTableName, @"personalID", @"name", @"adress", @"skill"];
    [_peopleDatabase executeUpdate:createTableSQL];
    [_peopleDatabase close];
    return _peopleDatabase;
}

+ (id)sharedPeopleStroe{
    
    static dispatch_once_t once;
    if (sharedPeopleStore) {
        return sharedPeopleStore;
    }
    dispatch_once(&once, ^{
        sharedPeopleStore = [[super allocWithZone:nil] init];
    });
    return sharedPeopleStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    
    return [self sharedPeopleStroe];
}

- (BOOL)addNewPeopleWithProperty:(NSDictionary *)properties{
    
    People *newPeople = [[People alloc] initWithDictionary:properties error:nil];
    NSString *insertString = [MTLFMDBAdapter insertStatementForModel:newPeople];
    NSArray *params = [MTLFMDBAdapter columnValues:newPeople];
    if([self.peopleDatabase open]){
        
        BOOL success = [self.peopleDatabase executeUpdate:insertString withArgumentsInArray:params];
        [self.peopleDatabase close];
        return success;
    }
    
    return false;
}

- (BOOL)updatePeople:(People *)p withPrimaryKey:(id)primaryKey{
    
    if(![self.peopleDatabase open]){
        return false;
    }
    if(!primaryKey){
        return false;
    }
    NSString *updateSQL = [MTLFMDBAdapter updateStatementForModel:p];
    NSArray *propertyValues = [MTLFMDBAdapter columnValues:p];
    NSMutableArray *arguments = [[NSMutableArray alloc] initWithArray:propertyValues copyItems:YES];
    [arguments addObject:primaryKey];
    BOOL success = [self.peopleDatabase executeUpdate:updateSQL withArgumentsInArray:arguments];
    NSLog(@"%@", updateSQL);
    return success;
}

- (BOOL)removePeopleWithProperty:(NSDictionary *)properties{
    
    
    return false;
}

- (NSArray *)peopleWithProperty:(NSDictionary *)properties{
    
    //条件不能为空，空的话需要通过getAllPeople得到
    if(![self.peopleDatabase open]){
        return nil;
    }
    if(![properties count]){
        return nil;
    }
    NSArray *arr;
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM %@", PeopleTableName];


    NSString *whereSQL = [self whereSQLWith:properties];
    selectSQL = [selectSQL stringByAppendingString:whereSQL];
    selectSQL = [selectSQL stringByAppendingString:@";"];
    NSMutableArray *temArr = [[NSMutableArray alloc] init];
    FMResultSet *set = [self.peopleDatabase executeQuery:selectSQL];
    while ([set next]) {
        int personalID = [set intForColumn:@"personalID"];
        People *p = [MTLFMDBAdapter modelOfClass:[People class] fromFMResultSet:set error:nil];
        [p setValue:[NSNumber numberWithInt:personalID] forKey:@"personalID"];
        [temArr addObject:p];
    }
    arr = [[NSArray alloc] initWithArray:temArr copyItems:YES];
    
    return arr;
}

- (NSString *)whereSQLWith:(NSDictionary *)properties {
    
    if(![properties count]){
        return @"";
    }
    NSString *sql = @" WHERE ";
    NSArray *keys = [properties allKeys];
    int i = 0;
    for(NSString *key in keys){
        id value = [properties objectForKey:key];
        NSString *conditionSQL = [NSString stringWithFormat:@"%@ = %@", key, value];
        sql = [sql stringByAppendingString:conditionSQL];
        if(i < keys.count - 1){
            sql = [sql stringByAppendingString:@" AND "];
        }
    }
    return sql;
    
}

- (NSArray *)getAllPeople{
    
    NSString *getAllSQL = [NSString stringWithFormat:@"SELECT * FROM %@", PeopleTableName];
    NSMutableArray *temArr = [[NSMutableArray alloc] init];
    if([self.peopleDatabase open]){
        FMResultSet *set = [self.peopleDatabase executeQuery:getAllSQL];
        while([set next]){
            
            People *p = [MTLFMDBAdapter modelOfClass:[People class] fromFMResultSet:set error:nil];
            int personalID = [set intForColumn:@"personalID"];
            [p setValue:[NSNumber numberWithInt:personalID] forKey:@"personalID"];
            [temArr addObject:p];
        }
        NSArray *arr = [[NSArray alloc] initWithArray:temArr copyItems:YES];
        return arr;
    }
    return nil;
}

- (void)deleteTable{
    
    if ([self.peopleDatabase open]) {
        NSString *dropTableSQL = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", PeopleTableName];
        if([self.peopleDatabase executeUpdate:dropTableSQL]){
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
        [self.peopleDatabase close];
    }
}



@end
