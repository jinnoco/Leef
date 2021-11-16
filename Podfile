# Uncomment the next line to define a global platform for your project
# platform :ios, '14.5'

def install_pods

pod 'Firebase/Auth'
pod 'Firebase/Firestore'
pod 'Firebase/Storage'
pod 'NVActivityIndicatorView'
pod 'Nuke'
pod 'NeumorphismTab'
pod 'SoftUIView'
pod 'lottie-ios'
pod 'ImageViewer.swift', '~> 3.0'

end
 

target 'Leef' do
install_pods
end


target 'LeefUnitTests' do
inherit! :search_paths
install_pods
end

target 'LeefUITests' do
inherit! :search_paths
install_pods
end