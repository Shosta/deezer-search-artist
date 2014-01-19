//--------------------------------------------------------
// Rémi Lavedrine Corp
//--------------------------------------------------------
// Project     : Deezer
// File        : FirstAlbumForArtistViewController.h
// Created     : $ 19/01/2014 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright Rémi Lavedrine 2004-2012, All Rights Reserved
//
// This software is the confidential and proprietary
// information of Rémi Lavedrine.
// You shall not disclose such Confidential Information
// and shall use it only in accordance with the terms
// of the license agreement you entered into with
// Rémi Lavedrine.
//--------------------------------------------------------
//
// @brief
// Display an album from the selected artist and display its tracks in a TableView. Each result is a track from this album and can be clicked to be listened.
//

#import <UIKit/UIKit.h>


//! @brief Display an album from the selected artist and display its tracks in a TableView. Each result is a track from this album and can be clicked to be listened.
//! It displays as well the album title, the album cover and the artist image.
//! @class FirstAlbumForArtistViewController
//! @ingroup Controllers
//! @author Rémi Lavedrine
@interface FirstAlbumForArtistViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *albumDetailContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *albumCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;
@property (weak, nonatomic) IBOutlet UITableView *albumTracksForArtistTableView;


#pragma mark - Object

//! Contructor
//! @param[in]    nibNameOrNil : The Nib's name.
//! @param[in]  nibBundleOrNil : The nib Bundle.
//! @param[in]      aTrackDict : The artist object as a NSDictionary as defined in the Deezer sdk documentation (http://developers.deezer.com/api/artist).
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           artistDict:(NSDictionary *)aArtistDict;


@end
