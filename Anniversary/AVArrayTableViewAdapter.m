//
//  AVArrayTableViewAdapter.m
//  Anniversary
//
//  Created by Alan Bouzek on 12/16/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import "AVArrayTableViewAdapter.h"

@interface AVArrayTableViewAdapter ()

@property (weak, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *cellIdentifier;
@property (strong, nonatomic) AVSelectItemBlock selectItemBlock;
@property (strong, nonatomic) AVCellConfigureBlock cellConfigureBlock;

@end

@implementation AVArrayTableViewAdapter

-(instancetype)initWithItems:(NSArray *)items
              cellIdentifier:(NSString *)cellIdentifier
          cellConfigureBlock:(AVCellConfigureBlock)cellConfigureBlock
             selectItemBlock:(AVSelectItemBlock)selectItemBlock {
    if (self = [super init]) {
        self.items = items;
        self.cellIdentifier = cellIdentifier;
        self.cellConfigureBlock = cellConfigureBlock;
        self.selectItemBlock = selectItemBlock;
    }
    return self;
}


#pragma mark - utility methods

-(id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.row];
}


#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    !self.cellConfigureBlock ?: self.cellConfigureBlock(cell, item);
    return cell;
}


#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self itemAtIndexPath:indexPath];
    !self.selectItemBlock ?: self.selectItemBlock(item);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
@end
