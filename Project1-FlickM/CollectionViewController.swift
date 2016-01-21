//
//  CollectionViewController.swift
//  Project1-FlickM
//
//  Created by Monte's Pro 13" on 1/19/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import Foundation
import SystemConfiguration
import ReachabilitySwift

extension CollectionViewController: UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedMovies?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoviesCollectionViewCell", forIndexPath: indexPath) as! MoviesCollectionViewCell
        
        let movie = searchedMovies![indexPath.row]
        
        let baseImageURL = "http://image.tmdb.org/t/p/w500/"
        let imagePath = movie["poster_path"] as! String
        let imageURL = NSURL(string: baseImageURL + imagePath)
        
        cell.posterImageView.setImageWithURL(imageURL!)
        
        return cell
    }
}

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var networkView: UIView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!
    
    var count = 0
    
    var movies: [NSDictionary]?
    var endPoint : String!
    var searchedMovies : [NSDictionary]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.blackColor()
 
      //  UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)
        
        //check for reachability- is there internet or not?
        let reachability = try! Reachability.reachabilityForInternetConnection()
        if reachability.currentReachabilityStatus == .NotReachable {
            collectionView.hidden = true
            searchBar.hidden = true
            networkView.hidden = false
            
            countButton.layer.cornerRadius = 50
        } else {
            networkView.hidden = true
            countButton.hidden = true
            countLabel.hidden = true
            // Display HUD right before next request is made
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            //Call the endpoint to get all the movies
            makeAPICall()
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchedMovies = self.movies
        self.collectionView.reloadData()
    }
    
    
    @IBAction func countButtonPressed(sender: AnyObject) {
        
        
        if (count == 18) {
            countLabel.text = String("M")
        }
        else {
            countLabel.text = "."
            ++count
            countLabel.text = String(count)
        }

        
    
    }
    
    
    func makeAPICall() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.searchedMovies = self.movies
                            self.collectionView.reloadData()
                    }
                }
                else if (error !=  nil) {
                    print("error")
                    self.collectionView.hidden = true
                    self.searchBar.hidden = true
                    self.networkView.hidden = false
                    
                    self.countButton.layer.cornerRadius = 50
                }
                
                // Hide HUD once network request comes back (must be done on main UI thread)
                 MBProgressHUD.hideHUDForView(self.view, animated: true)
        });
        task.resume()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchedMovies = searchText.isEmpty ? movies : movies!.filter({(movie: NSDictionary) -> Bool in
            return (movie["title"] as! String).rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // Make API call to fetch all the movies data
        makeAPICall()
        
        // Do the following when the network request comes back successfully:
        // Update collectionView data source
        self.collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        let movie = searchedMovies![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! MovieInfoViewController
        
        detailViewController.movie = movie

    }
    

}
