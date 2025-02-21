#!/bin/sh

#cp /d/androidWorkspace/MyApp/app/build/outputs/apk/debug/com.zoranl.myapp-v1(0.1a)-debug.apk  /d/mygit/MySharedApk/
#cp /d/androidWorkspace/MyMath/app/build/outputs/apk/debug/com.zoranl.mymath-v1\(0.9b\)-debug.apk  /d/mygit/MySharedApk/
#cp /d/androidWorkspace/BTapp/app/build/outputs/apk/debug/com.zoranl.btapp-v2\(0.9b\)-debug.apk    /d/mygit/MySharedApk/
#cp /d/androidWorkspace/WiFIApp/app/build/outputs/apk/debug/com.zoranl.wifiapp-v1\(0.8\)-debug.apk /d/mygit/MySharedApk/
#cp /d/androidWorkspace/NfcApp/app/build/outputs/apk/debug/com.zoranl.nfcapp-v1\(0.0\)-debug.apk   /d/mygit/MySharedApk/



file_copy() {
# Define each array and then add it to the main one
FILE_0=("/d/androidWorkspace/MyApp/app/build/outputs/apk/debug/com.zoranl.myapp-v1(0.1a)-debug.apk" "/d/mygit/MySharedApk/com.zoranl.myapp-v1(0.1a)-debug.apk")
FILE_1=("/d/androidWorkspace/MyMath/app/build/outputs/apk/debug/com.zoranl.mymath-v1(0.9b)-debug.apk" "/d/mygit/MySharedApk/com.zoranl.mymath-v1(0.9b)-debug.apk")
FILE_2=("/d/androidWorkspace/BTapp/app/build/outputs/apk/debug/com.zoranl.btapp-v2(0.9b)-debug.apk" "/d/mygit/MySharedApk/com.zoranl.btapp-v2(0.9b)-debug.apk")
FILE_3=("/d/androidWorkspace/WiFIApp/app/build/outputs/apk/debug/com.zoranl.wifiapp-v1(0.8)-debug.apk" "/d/mygit/MySharedApk/com.zoranl.wifiapp-v1(0.8)-debug.apk")
FILE_4=("/d/androidWorkspace/NfcApp/app/build/outputs/apk/debug/com.zoranl.nfcapp-v1(0.0)-debug.apk" "/d/mygit/MySharedApk/com.zoranl.nfcapp-v1(0.0)-debug.apk")
APK_ARRAY=(
  FILE_0[@]
  FILE_1[@]
  FILE_2[@]
  FILE_3[@]
  FILE_4[@]
)


COUNT=${#APK_ARRAY[@]}
for ((i=0; i<$COUNT; i++))
	do
		FILE_SOURCE=${!APK_ARRAY[i]:0:1}
		FILE_DESTINATION=${!APK_ARRAY[i]:1:1}
		
		#echo "FILE_SOURCE $FILE_SOURCE"
		#echo "FILE_DESTINATION $FILE_DESTINATION"
		
		ls -al $FILE_SOURCE $FILE_DESTINATION
		
				
		if [[ ${FILE_SOURCE} -nt ${FILE_DESTINATION} ]]; then
			echo "!!!!! ${FILE_SOURCE} is newer than ${FILE_DESTINATION}!!!!!!"
			cp $FILE_SOURCE $FILE_DESTINATION
		fi
		echo "--------------------------------------------------------------"
			
	done
}


file_copy



#another simpler way:
check_files(){
ls -al $FILE_SOURCE $FILE_DESTINATION
if [[ ${FILE_SOURCE} -nt ${FILE_DESTINATION} ]];then
	echo ${FILE_SOURCE} is newer than ${FILE_DESTINATION}
	#cp ${FILE_SOURCE} ${FILE_DESTINATION}
fi
echo "-------------------------------------------"
}

main(){
FILE_SOURCE=/d/androidWorkspace/MyMath/app/build/outputs/apk/debug/com.zoranl.mymath-v1\(0.9b\)-debug.apk
FILE_DESTINATION=/d/mygit/MySharedApk/com.zoranl.mymath-v1\(0.9b\)-debug.apk

check_files

FILE_SOURCE=/d/androidWorkspace/MyApp/app/build/outputs/apk/debug/com.zoranl.myapp-v1\(0.1a\)-debug.apk
FILE_DESTINATION=/d/mygit/MySharedApk/com.zoranl.myapp-v1\(0.1a\)-debug.apk

check_files

FILE_SOURCE=/d/androidWorkspace/BTapp/app/build/outputs/apk/debug/com.zoranl.btapp-v2\(0.9b\)-debug.apk
FILE_DESTINATION=/d/mygit/MySharedApk/com.zoranl.btapp-v2\(0.9b\)-debug.apk

check_files

FILE_SOURCE=/d/androidWorkspace/WiFIApp/app/build/outputs/apk/debug/com.zoranl.wifiapp-v1\(0.8\)-debug.apk
FILE_DESTINATION=/d/mygit/MySharedApk/com.zoranl.wifiapp-v1\(0.8\)-debug.apk

check_files

FILE_SOURCE=/d/androidWorkspace/NfcApp/app/build/outputs/apk/debug/com.zoranl.nfcapp-v1\(0.0\)-debug.apk
FILE_DESTINATION=/d/mygit/MySharedApk/com.zoranl.nfcapp-v1\(0.0\)-debug.apk

check_files
}

