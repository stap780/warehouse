class MyApp < InsalesApi::App
self.api_key            = 'warehouse'# второй вариант через api 'ee8d04c00d924c5545c8f33893afd645',
self.api_secret         = '1f2bff00e1a93497cd0d9a77cbfcb011'# второй вариант через api '1f2bff00e1a93497cd0d9a77cbfcb011'
self.api_autologin_url  = 'http://104.236.104.115:3000/session/autologin'
#MyApp.api_host           = 'http://104.236.104.115:3000/'
# MyApp.api_autologin_path = 'session/autologin'
end
 MyApp.configure_api(Account.last.insales_subdomain, Account.last.password)# второй вариант через api MyApp.configure_api('myshop-327-26.myinsales.ru', '0957c04ecd191ef45fe07762af6dcc68')
