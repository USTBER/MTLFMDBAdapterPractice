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

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//        [self testAddPeople];
    [self testGetAllPeople];
//    [self testDeleteTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testDeleteTable{
    
    PeopleStore *sharedStore = [PeopleStore sharedPeopleStroe];
    [sharedStore deleteTable];
}

- (void)testAddPeople{
    
    NSDictionary *peopleProperties = @ {@"name":@"李春醒", @"adress":@"USTB", @"skill":@"iOS Develop"};
    PeopleStore *sharedStore = [PeopleStore sharedPeopleStroe];
    BOOL success = [sharedStore addNewPeopleWithProperty:peopleProperties];
    if(success){
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
}

- (void)testGetAllPeople{
    
    PeopleStore *sharedStore = [PeopleStore sharedPeopleStroe];
    BOOL success = [sharedStore getAllPeople];
    if(success){
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
}

@end
