# daily random background image for macos using images from unsplash.com  
## prerequisites
1. you have to register for free with unsplash.com in order to get an api_key.   
2. you must create a folder where your downloaded image will be stored   
3. open your 'system pref.' > 'desktop and screen saver', choose custom location (folder) and add the folder you have just created, where your image will be stored  
4. check **change picture:** and change it to **daily**  
5. install jq via homebrew -> **brew install jq**

## how to  
if you checked all the prerequisites you will have to adjust the shell skript and the plist.file.  
### the shell script  
you will have to change the path to your folder, where the image will be stored. I had to use the absolute path, I couldn't get it to work with a relative `~` path, I don't know why.. so you are probably best of by using the absolute path too  
```shell
save_to='/PATH/TO/YOUR/FOLDER/'
```    
you will have to change the *YOURAPIKEY* with the api_key you got from your unsplash.com account (you should have created one in prerequisites). don't delete the `client_id=` part by accident, just replace `YOURAPIKEY` with your api_key  
```shell
api_key='client_id=YOURAPIKEY'
```   
if you don't want to look for images containing a certain tag, you should delete this part `&query=$query` from `url`. Then you will get a random image from unsplash.com but still using the defined dimensions (width & height). If you **DO** want to use a keyword to look for, than change `YOURKEYWORD` to your keyword.   
```shell
query='YOURKEYWORD'
url="https://api.unsplash.com/photos/random?$api_key&w=$width&h=$height&query=$query"
```    

if you want you can also adjust the width and height the same way..   

### the plist.file
you will have to correct the three `/PATH/TO/YOUR/FOLDER` strings found in line 11, 21 and 23 just make sure you **don't** delete the rest of the strings. Being `get_and_set_backgroundimage.sh`, `startup.stdout` and `startup.stderr`. The stdout and stderr file will be created automatically. The shell script file `get_and_set_backgroundimage.sh` must be copied to your `/PATH/TO/YOUR/FOLDER`.  
In case you would like to change the image more often (every X min, hours etc.) you will have to change the  
```
<key>LaunchOnlyOnce</key>
<true/>
```  
to the corresponding value. you can google how to configure the plist.file for this setting. its pretty much like a cronjob. you would also have to change the setting made in the prerequisites point 4. from daily to min, hours whatever you have in mind..   

### finally  
the plist.file **must be copied to** `~/Library/LaunchAgent/` (**NOT** /Library/LaunchDaemons ) and the **shell script must be copied into the** `/PATH/TO/YOUR/FOLDER` as mentioned above. In case you have renamed the plist.file you will have to make sure to rename it inside the plist.file itself, in line 11, as well `<string>com.bkgimagechanger</string>`, the same goes for the shell script. If you have renamed the `.sh` file you will have to rename it in line 13 inside the plist.file  

## lastly  
originally I wanted the shell script to set the background image as my desktop background. I was sure there was an easy way, welp, I tried one or two things but got frustrated after it didnt work. So I decided I would set the 'desktop & screen saver' settings to daily and change the picture when I log in by making it an LaunchAgent.. If someone knows a way how to make the shell script change the background picture right after downloading it, that would be great. **KEEP IN MIND** in order for the picture to be changed, you have to **log in**, which usually happens when you start the computer or sign off (ofcourse) **AND** because of the 'desktop & screen saver' setting it will only change daily!  
