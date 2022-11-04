//
//  ViewController.swift
//  WeatherApp
//
//  Created by norelhoda on 02/11/2022.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Proporties
    
    var viewModel = ViewModel()
    var filteredData: [String]!
    @IBOutlet weak var cityNameLbel:UILabel!
    @IBOutlet weak var datTimeLabel:UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var tempratureDegreeLabel:UILabel!
    @IBOutlet weak var weatherDescriptionLabel:UILabel!
    @IBOutlet weak var windLabel:UILabel!
    @IBOutlet weak var humidityLabel:UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var serachView:UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var serachTableHeight : NSLayoutConstraint!
    @IBOutlet weak var searchViewHeight : NSLayoutConstraint!
    @IBOutlet weak var downArrowHeight : NSLayoutConstraint!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         configureUI()
         getDailyWeatherData()
         fetchCities()
    }
    
    //MARK: - Helper Functoion
    
    func configureUI(){
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.searchBar.delegate = self
        self.serachView.roundCorners2(corners: [.bottomLeft,.bottomRight], radius: 25)
    }
    
    //MARK: - API
    
    func getDailyWeatherData(){
        viewModel.getDailyWeather(cityName: "")
        viewModel.dailyWeatherDataUpdat  = { [weak self] in
            self?.updateDailyWeatherdata()
        }
        viewModel.fetchThreeDaysWeather(cityName: "")
        viewModel.ThreeDaysWeatherDataUpdat  = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func updateDailyWeatherdata(){
       
        if let name = self.viewModel.data?.location?.name{
            self.cityNameLbel.text = name
        }
        if let date = self.viewModel.data?.location?.localtime {
            self.datTimeLabel.text = date
        }
        if let temp = self.viewModel.data?.current?.temp_f {
            self.tempratureDegreeLabel.text = String(temp) + "°F"
        }
        if let wind = self.viewModel.data?.current?.wind_mph {
            self.windLabel.text = String(wind) + "mph"
        }
        if let humdidty = self.viewModel.data?.current?.humidity {
            self.humidityLabel.text = String(humdidty) + "%"
        }
        if let decription = self.viewModel.data?.current?.condition?.text {
            self.weatherDescriptionLabel.text = decription
        }
        if let img = self.viewModel.data?.current?.condition?.icon {
            self.weatherIconImage.downloaded(from: "https:\(img)")
        }
    }
    
    func fetchCities (){
        viewModel.fetchCities()
        viewModel.fetchCitiesData  = { [weak self] in
            self?.filteredData = self?.viewModel.cities
            self?.searchTableView.dataSource = self
            self?.searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    //MARK: - Selector Function
    
    @IBAction func serachButtonTapped(){
        self.serachView.alpha = 1
    }
    @IBAction func backButtonTapped(){
        self.serachView.alpha = 0
        self.searchTableView.alpha = 0
    }
}

//MARK: - CollectionView DataSource and Delegate

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        if let img =  self.viewModel.weatherByDayData?.forecast?.forecastday?[indexPath.row].hour?[indexPath.row].condition?.icon {
                cell.weatherImage.downloaded(from: "https:\(img)")
            }
             if let temp = self.viewModel.weatherByDayData?.forecast?.forecastday?[indexPath.row].day?.avgtemp_f{
                 cell.tempratueLabel.text = String(temp) + "°F"
            }
            cell.dayLabel.text = viewModel.dayArray[indexPath.row]
            return cell
    }
}

//MARK: - TableView Delgate and DataSource

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.filteredData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.filtData[indexPath.row]
        return cell
    }
}

//MARK: - Serach Delegate

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTableView.alpha = 1
        filteredData = searchText.isEmpty ? viewModel.cities : viewModel.cities.filter({(dataString: String) -> Bool in
                // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })
            self.serachTableHeight.constant = CGFloat(60*filteredData.count)
            self.downArrowHeight.constant = 46
            self.searchViewHeight.constant = 164 + self.serachTableHeight.constant
            searchTableView.reloadData()
            if searchText == "" {
              searchTableView.alpha = 0
              self.serachTableHeight.constant = 0
              self.downArrowHeight.constant = 0
              self.searchViewHeight.constant = 164
           }
      }
}


