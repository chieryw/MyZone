//
//  MMMPMediaPlayerControllerVC.m
//  My-Zone
//
//  Created by chiery on 2016/11/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//  有待完善，界面中可以添加listView来展示歌曲列表，增加文案展示

#import "MMMPMediaPlayerControllerVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIAlertView+RACSignalSupport.h"

@interface MMMPMediaPlayerControllerVC ()<MPMediaPickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bottomBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic,strong) MPMediaPickerController *mediaPicker;//媒体选择控制器
@property (nonatomic,strong) MPMusicPlayerController *musicPlayer; //音乐播放器
@property (weak, nonatomic) IBOutlet UILabel *musicDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *musicData;

@end

@implementation MMMPMediaPlayerControllerVC

- (void)dealloc {
    [self.musicPlayer endGeneratingPlaybackNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void)configureUI {
    self.bottomBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
}

- (MPMusicPlayerController *)musicPlayer {
    if (!_musicPlayer) {
        _musicPlayer=[MPMusicPlayerController applicationMusicPlayer];
        [_musicPlayer beginGeneratingPlaybackNotifications];//开启通知，否则监控不到MPMusicPlayerController的通知
        [self addNotification];//添加通知
        //如果不使用MPMediaPickerController可以使用如下方法获得音乐库媒体队列
        //[_musicPlayer setQueueWithItemCollection:[self getLocalMediaItemCollection]];
    }
    return _musicPlayer;
}

- (MPMediaPickerController *)mediaPicker {
    if (!_mediaPicker) {
        //初始化媒体选择器，这里设置媒体类型为音乐，其实这里也可以选择视频、广播等
        //                _mediaPicker=[[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeMusic];
        _mediaPicker=[[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeAny];
        _mediaPicker.allowsPickingMultipleItems=YES;//允许多选
        //                _mediaPicker.showsCloudItems=YES;//显示icloud选项
        _mediaPicker.prompt=@"请选择要播放的音乐";
        _mediaPicker.delegate=self;//设置选择器代理
    }
    return _mediaPicker;
}

- (MPMediaItemCollection *)getLocalMediaItemCollection {
    MPMediaQuery *mediaQueue=[MPMediaQuery songsQuery];
    NSMutableArray *array=[NSMutableArray array];
    for (MPMediaItem *item in mediaQueue.items) {
        [array addObject:item];
        NSLog(@"标题：%@,%@",item.title,item.albumTitle);
    }
    MPMediaItemCollection *mediaItemCollection=[[MPMediaItemCollection alloc]initWithItems:[array copy]];
    return mediaItemCollection;
}

- (NSMutableArray *)musicData {
    if (!_musicData) {
        _musicData = [NSMutableArray new];
    }
    return _musicData;
}

#pragma mark - MPMediaPickerController代理方法
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    MPMediaItem *mediaItem=[mediaItemCollection.items firstObject];//第一个播放音乐
    //注意很多音乐信息如标题、专辑、表演者、封面、时长等信息都可以通过MPMediaItem的valueForKey:方法得到,但是从iOS7开始都有对应的属性可以直接访问
    //    NSString *title= [mediaItem valueForKey:MPMediaItemPropertyAlbumTitle];
    //    NSString *artist= [mediaItem valueForKey:MPMediaItemPropertyAlbumArtist];
    //    MPMediaItemArtwork *artwork= [mediaItem valueForKey:MPMediaItemPropertyArtwork];
    //UIImage *image=[artwork imageWithSize:CGSizeMake(100, 100)];//专辑图片
    NSLog(@"标题：%@,表演者：%@,专辑：%@",mediaItem.title ,mediaItem.artist,mediaItem.albumTitle);
    [self.musicData addObjectsFromArray:mediaItemCollection.items];
    [self.tableView reloadData];
    [self.musicPlayer setQueueWithItemCollection:mediaItemCollection];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker  {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 通知
- (void)addNotification {
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(playbackStateChange:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.musicPlayer];
}

-(void)playbackStateChange:(NSNotification *)notification{
    [self updateUI];
}

- (void)updateUI {
    [self updatePlayeButton];
    [self updateMediaDescription];
}

- (void)updatePlayeButton {
    switch (self.musicPlayer.playbackState) {
        case MPMusicPlaybackStatePlaying:
            NSLog(@"正在播放...");
            self.playButton.selected = YES;
            break;
        case MPMusicPlaybackStatePaused:
            NSLog(@"播放暂停.");
            self.playButton.selected = NO;
            break;
        case MPMusicPlaybackStateStopped:
            NSLog(@"播放停止.");
            self.playButton.selected = NO;
            break;
        default:
            break;
    }
}

- (void)updateMediaDescription {
    if (self.musicPlayer.nowPlayingItem) {
        self.musicDescriptionLabel.text = [NSString stringWithFormat:@"当前歌曲：%@",self.musicPlayer.nowPlayingItem.title];
    }
}

#pragma mark - UI事件
- (IBAction)addClick:(id)sender {
    [self presentViewController:self.mediaPicker animated:YES completion:nil];
}

- (IBAction)nextClick:(UIButton *)sender {
    if ([self mediaIsReady]) {
        [self.musicPlayer skipToNextItem];
        [self updateUI];
    } else {
        [self alertMediaIsNotReady];
    }
}

- (IBAction)prevClick:(UIButton *)sender {
    if ([self mediaIsReady]) {
        [self.musicPlayer skipToPreviousItem];
        [self updateUI];
    } else {
        [self alertMediaIsNotReady];
    }
}

- (IBAction)chooseMusic:(id)sender {
    if (self.tableView.hidden) {
        if ([self mediaIsReady]) {
            self.tableView.hidden = NO;
            [self.tableView scrollToRow:self.musicPlayer.indexOfNowPlayingItem inSection:0 atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        } else {
            [self alertMediaIsNotReady];
        }
    } else {
        self.tableView.hidden = YES;
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.musicData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"musicCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    MPMediaItem *item = [self.musicData objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    MPMediaItem *item = [self.musicData objectAtIndex:indexPath.row];
    NSLog(@"***************%@",item.title);
    self.musicPlayer.nowPlayingItem = item;
    [self.musicPlayer play];
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)mediaIsReady {
    if ((self.musicData.count > 0)) return YES;
    return NO;
}

- (void)alertMediaIsNotReady {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"您现在还不能播放音乐，因为你的歌曲库中没有添加音乐"
                                                       delegate:nil
                                              cancelButtonTitle:@"暂时不播放"
                                              otherButtonTitles:@"立即添加", nil];
    [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber* x) {
        if (x.integerValue == 1) {
            [self presentViewController:self.mediaPicker animated:YES completion:nil];
        }
        else if (x.integerValue == 0){
            // 暂时不做处理
        }
    }];
    [alertView show];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self updateUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:1];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (IBAction)playAction:(UIButton *)sender {
    if (![self mediaIsReady]) {
        [self alertMediaIsNotReady];
        return;
    }
    
    if (sender.selected) {
        sender.selected = NO;
        [self.musicPlayer pause];
    }
    else {
        sender.selected = YES;
        [self.musicPlayer play];
    }
}

@end
