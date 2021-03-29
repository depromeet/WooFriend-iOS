# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Woofriend' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_modular_headers!

  # Pods for Woofriend
	pod 'Firebase/Analytics' # , '7.8.0'
	pod 'Firebase/Crashlytics'
	pod 'Firebase/RemoteConfig'

	pod 'RIBs', '0.9.1'

	pod 'RxSwift', '4.5.0'
    	pod 'RxCocoa', '4.5.0'
	pod 'RxGesture', '2.2.0'
	pod 'RxDataSources', '3.1.0'

	# SNS 로그인 - 카톡은 레거시로 직접 프레임워크 넣음
	pod 'naveridlogin-sdk-ios'
	pod 'KakaoSDK'

	#
	pod 'NMapsMap'

	# 네트워크
	# KaKao 디펜던시 있음 Alamofire  5.4.1
	pod 'Moya'
#	pod 'Moya/RxSwift'

	# log
	pod 'CocoaLumberjack/Swift'
		
	# UI
	pod 'TagListView'	# 태그
	pod 'ZLPhotoBrowser'	# 사진 크롭, 멀티 등
	pod 'CropViewController'
	pod 'Hero'

  target 'WoofriendTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'

  end

  target 'WoofriendUITests' do
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'

  end

end
