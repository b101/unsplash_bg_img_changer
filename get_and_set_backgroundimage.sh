#!/bin/sh
#path to the location you want to store the downloaded image in
save_to='/PATH/TO/YOUR/FOLDER/'
#the file name which the image will be stored under (obviously)
filename='bkg_image.jpg'

#unsplash api_key
api_key='client_id=YOURAPIKEY'
#unsplash width & height value for image (can be changed)
width='5120'
height='2880'
#if your looking for images containing a certain keyword
query='YOURKEYWORD'

#api url you are about to call using the defined unsplash settings
url="https://api.unsplash.com/photos/random?$api_key&w=$width&h=$height&query=$query"
#if you dont have jq installed, you can install it via brew install jq
image=$(curl -s $url | jq --raw-output '.urls.custom')
download="$save_to$filename"
curl -s -o $download $image
