//
//  ViewController.m
//  MTLFMDBAdapterPractice
//
//  Created by LiChunxing on 16/3/29.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "ViewController.h"
#import "People.h"
#import "PeopleStore.h"

@interface ViewController ()

@property (nonatomic, strong) PeopleStore *sharedStore;

@end

@implementation ViewController

- (PeopleStore *)sharedStore{
    if(_sharedStore){
        return _sharedStore;
    }
    _sharedStore = [PeopleStore sharedPeopleStroe];
    return _sharedStore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//            [self testAddPeople];
//    [self testGetAllPeople];
    //    [self testDeleteTable];
    [self testGetPeopleWithProperty];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testDeleteTable{
    
    
    [self.sharedStore deleteTable];
}

- (void)testAddPeople{
    
    NSDictionary *peopleProperties = @ {@"name":@"李春醒", @"adress":@"USTB", @"skill":@"iOS Develop"};
    
    BOOL success = [self.sharedStore addNewPeopleWithProperty:peopleProperties];
    if(success){
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
}

- (void)testGetPeopleWithProperty{
    
    NSDictionary *dic = @{@"personalID":@4};
    NSArray *arr = [self.sharedStore peopleWithProperty:dic];
    for(People *p in arr){
        
        NSArray *keys = [[p dictionaryValue] allKeys];
        for(NSString *str in keys){
            NSLog(@"key: %@ and value: %@", str, [[p dictionaryValue] objectForKey:str]);
        }
    }
}

- (void)testGetAllPeople{
    
    NSArray *arr = [self.sharedStore getAllPeople];
    for(People *p in arr){
        
        NSArray *keys = [[p dictionaryValue] allKeys];
        for(NSString *str in keys){
            NSLog(@"key: %@ and value: %@", str, [[p dictionaryValue] objectForKey:str]);
        }
    }
}

@end
