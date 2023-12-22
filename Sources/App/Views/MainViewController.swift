import UIKit
import SnapKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
      private lazy var titleLabel = UILabel()
      private lazy var itemMainView = UIView()
      private lazy var itemImage = UIImageView()
      private lazy var itemTextLabel = UILabel()
      private lazy var weathersColletionView = UICollectionView()
    private lazy var weathers: [Weather] = [
        Weather(dayOnWeather: "Mon",imageWeather: "cloudy",temperature: "76"),
        Weather(dayOnWeather: "Mon",imageWeather: "cloudy",temperature: "76"),
        Weather(dayOnWeather: "Mon",imageWeather: "cloudy",temperature: "76"),
        Weather(dayOnWeather: "Mon",imageWeather: "cloudy",temperature: "76"),
        Weather(dayOnWeather: "Mon",imageWeather: "cloudy",temperature: "76"),
        Weather(dayOnWeather: "Mon",imageWeather: "cloudy",temperature: "76"),
        Weather(dayOnWeather: "Mon",imageWeather: "cloudy",temperature: "76")
    ]
      
      
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tạo một gradient layer
        let gradientLayer = CAGradientLayer()

        // Đặt màu cho gradient
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]

        // Đặt điểm bắt đầu và kết thúc của gradient
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        // Đặt frame cho gradient layer (đối với ví dụ này, chúng ta sẽ đặt full width và height của view)
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        titleLabel.text = "Viet Nam"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 32)
        
        
        itemImage.image = UIImage(named: "cloudy");
        itemImage.contentMode = .scaleToFill
        
        itemTextLabel.text = "78"
        itemTextLabel.textColor = .white
        itemTextLabel.textAlignment = .center
        itemTextLabel.font = UIFont.systemFont(ofSize: 32)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 100, height: 300)
        weathersColletionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        self.weathersColletionView.dataSource = self
        self.weathersColletionView.delegate = self
        weathersColletionView.register(WeatherViewCell.self, forCellWithReuseIdentifier: WeatherViewCell.id)
        weathersColletionView.backgroundColor = .red
        
    }
    
    func setUpConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(itemMainView)
        itemMainView.addSubview(itemImage)
        itemMainView.addSubview(itemTextLabel)
        view.addSubview(weathersColletionView)
        
        titleLabel.snp.makeConstraints{
            $0.topMargin.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 200, height: 40))
            
        }
        
        itemMainView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.size.equalTo(CGSize(width: 200, height: 200))
            
            
            
        }
        itemImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        itemTextLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(itemImage.snp.bottom).offset(20)
            $0.size.equalTo(CGSize(width: 100, height: 40))
            
        }
        weathersColletionView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(itemMainView.snp.bottom).offset(10)
            $0.size.equalTo(CGSize(width: view.frame.width - 40, height: 100))
            
        }
        
     
      

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"WeatherViewCell", for: indexPath) as? WeatherViewCell else{
            return .init()
        }
        let weather: Weather = weathers[indexPath.row]
        cell.setData(day: weather.dayOnWeather , nameImage: weather.imageWeather , temperature: weather.temperature)
        
        return cell
        
    }
 
    
    
        
    
        
    

}
