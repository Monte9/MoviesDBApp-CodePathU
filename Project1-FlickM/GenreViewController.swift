//
//  GenreViewController.swift
//  Project1-FlickM
//
//  Created by Monte's Pro 13" on 1/30/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import MBProgressHUD

extension GenreViewController: UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  print("\(genres) nil?")
        return genres?.count ?? 0
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let size = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
//        
//        return size
//    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let left = collectionView.frame.size.width
        print(left)
        
        print(left/2)
        
        let insetPosition = UIEdgeInsetsMake(0, left/2, 0, left/2)
        
        return insetPosition
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GenresCollectionViewCell", forIndexPath: indexPath) as! GenresCollectionViewCell

        let genre = genres![indexPath.row]
      //  print("here\(genre)")
        
        cell.genreLabel.text = genre["name"] as! String
        
        return cell
    }
}




class GenreViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var genres : [NSDictionary]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        makeAPICall()
    }

    
    func makeAPICall() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)")
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
                            if (responseDictionary["status_code"] == nil ) {
                                
                                self.genres = responseDictionary["genres"] as! [NSDictionary]!
                                print("Connection to API successful!")
                               
                               // print(self.genres)
                                self.collectionView.reloadData()
                                
                            }
                            else {
                                print("error")
                                
                            }
                            // Hide HUD once network request comes back (must be done on main UI thread)
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                    }
                }
        });
        task.resume()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        let genre = genres![indexPath!.row]
        let genreID = genre["id"] as! Int
        let genreName = genre["name"] as! String
        
        let collectionViewController = segue.destinationViewController as! CollectionViewController
        
        collectionViewController.genreName = genreName
        collectionViewController.genreID = genreID
        collectionViewController.genre = true
        
    }
    

}
