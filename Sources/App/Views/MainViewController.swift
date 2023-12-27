import UIKit
import SnapKit
import CoreLocation

class MainViewController: UIViewController{
    
      let locationManager = CLLocationManager()
      private lazy var titleLabel = UILabel()
      private lazy var changeFLabel = UILabel()
      private lazy var changeCLabel = UILabel()
      private lazy var itemMainView = UIView()
      private lazy var itemImage = UIImageView()
      private lazy var itemTextLabel = UILabel()
      private lazy var weathersColletionView = UICollectionView()
      private lazy var changeContryButton = UIButton()
      private lazy var iconLikeImage = UIImageView()
      private lazy var iconRefreshImage = UIImageView()
      private lazy var daysWeather:[DayWeather] = []
      private  var weatherData: WeatherData? ;
      private lazy var weatherDayTableView = UITableView()
      
      
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysWeather = BaseRequestService.share.requestApiWeather().sorted(by: {$0.weatherData[0].dt < $1.weatherData[0].dt});
        weatherData = daysWeather[0].getWeatherCurrent()
       
        
        requestLocationAuthorization()
        setUpViews()
        setUpConstraints()
        UserLocation.shared.setupLocationManager()
        
    }
    
    func setGrandientLayer(yourWidth: Int ,yourHeight : Int)-> CAGradientLayer {
        // Tạo một gradient layer
        let gradientLayer = CAGradientLayer()        // Đặt màu cho gradient
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]

        // Đặt điểm bắt đầu và kết thúc của gradient
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        // Đặt frame cho gradient layer (đối với ví dụ này, chúng ta sẽ đặt full width và height của view)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: yourWidth, height: yourHeight)
        return gradientLayer
    }
    
    func setUpViews() {
  
        view.layer.addSublayer(setGrandientLayer(yourWidth: Int(view.frame.width),yourHeight: Int(view.frame.height)))
        
        iconLikeImage.image = UIImage(named: "icon-heart")
        iconLikeImage.contentMode = .scaleAspectFit
        iconLikeImage.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleClickNextViewLike))
        iconLikeImage.addGestureRecognizer(tapGestureRecognizer)
        
        
        iconRefreshImage.image = UIImage(named: "icon-refresh")
        iconRefreshImage.contentMode = .scaleAspectFit
        
        changeCLabel.text = ""
        changeCLabel.textColor = .white
        changeCLabel.font = UIFont.systemFont(ofSize: 24)
        
     

        titleLabel.text = daysWeather[0].contry
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 32)
        
        
        itemImage.image = UIImage(named: weatherData?.weather[0].icon ?? "04d" );
        itemImage.contentMode = .scaleAspectFill
        
        itemTextLabel.text = weatherData?.getTemperatureC()
        itemTextLabel.textColor = .white
        itemTextLabel.textAlignment = .center
        itemTextLabel.font = UIFont.systemFont(ofSize: 32)
        
        changeContryButton.setTitle("Change Contry", for: .normal)
        changeContryButton.setTitleColor(UIColor.white, for: .normal)
        changeContryButton.backgroundColor = .blue
        changeContryButton.layer.cornerRadius = 10
        changeContryButton.addTarget(self, action:#selector(handleClickChangeContryButton), for: .touchUpInside)
        
        
        setWeatherCollectionView()
        setWeatherDateTableView()
        
      
    }
    
    func setUpConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(itemMainView)
        itemMainView.addSubview(itemImage)
        itemMainView.addSubview(itemTextLabel)
        view.addSubview(weathersColletionView)
        view.addSubview(weatherDayTableView)
        view.addSubview(changeContryButton)
        view.addSubview(iconLikeImage)
        view.addSubview(iconRefreshImage)
        
        iconRefreshImage.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-20)
            $0.topMargin.equalToSuperview().offset(10)
            $0.size.equalTo(CGSize(width: 25, height: 25))
            
        }
        iconLikeImage.snp.makeConstraints{
            $0.topMargin.equalToSuperview().offset(10)
            $0.size.equalTo(CGSize(width: 25, height: 25))
            $0.trailing.equalTo(iconRefreshImage.snp.leading).offset(-15)
    
        }
    
        
        titleLabel.snp.makeConstraints{
            $0.topMargin.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 200, height: 40))
            
        }
        
        itemMainView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.size.equalTo(CGSize(width: 200, height: 140))
            
        }
        
        itemImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        itemTextLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(itemImage.snp.bottom).offset(10)
            $0.size.equalTo(CGSize(width: 100, height: 30))
            
        }
        
        weathersColletionView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(itemMainView.snp.bottom).offset(5)
            $0.size.equalTo(CGSize(width: view.frame.width - 40, height: 160))
        }
        
        
        weatherDayTableView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(weathersColletionView.snp.bottom).offset(10)
            $0.size.equalTo(CGSize(width: view.frame.width - 40, height:200))
        }
        
        changeContryButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(weatherDayTableView.snp.bottom).offset(20)
            $0.size.equalTo(CGSize(width: view.frame.width - 40,height: 60))
        }
     
    }
    
    @objc func handleClickChangeContryButton(){
        let view = ContriesViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    @objc func handleClickNextViewLike(){
        let view = ContriesLikeViewController()
        navigationController?.pushViewController(view, animated: true)
    }

 

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysWeather[0].weatherData.count
    }
    
    func setWeatherCollectionView(){
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 80, height: 150)
        weathersColletionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        self.weathersColletionView.dataSource = self
        self.weathersColletionView.delegate = self
        weathersColletionView.register(WeatherViewCell.self, forCellWithReuseIdentifier: WeatherViewCell.id)
        weathersColletionView.layer.cornerRadius = 10
        weathersColletionView.backgroundColor = .black.withAlphaComponent(0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"WeatherViewCell", for: indexPath) as? WeatherViewCell else{
            return .init()
        }
        let weather: WeatherData = daysWeather[0].weatherData[indexPath.row]
        cell.setData(weatherData: weather)
        
        return cell
        
    }
    
}

extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    
    func setWeatherDateTableView(){
        weatherDayTableView.dataSource = self
        weatherDayTableView.delegate = self
        weatherDayTableView.register(WeatherDataTableViewCell.self, forCellReuseIdentifier: WeatherDataTableViewCell.identifier)
        weatherDayTableView.layer.cornerRadius = 10
        weatherDayTableView.backgroundColor = .black.withAlphaComponent(0.2)

    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDataTableViewCell.identifier, for: indexPath) as? WeatherDataTableViewCell else{
            return .init()
        } 
        let dayWeather = daysWeather[indexPath.row]
        cell.setData(dayWeather: dayWeather)
        
        return cell
    }
    
    
    
}
extension MainViewController: CLLocationManagerDelegate {
    
    func requestLocationAuthorization() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Handle denied or restricted authorization
            print("error 2")
            break
        case .notDetermined:
            // Authorization not determined yet
            print("error 2")
            break
        @unknown default:
            print("error 3")
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // Do something with latitude and longitude
        print("Latitude: \(latitude), Longitude: \(longitude)")

        print(daysWeather)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }



}
