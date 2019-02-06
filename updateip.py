import sys
import os
import urllib3

def get_ip():
    fqn=os.uname()[1]
    http=urllib3.PoolManager()
    ext_ip =http.request('GET', 'http://icanhazip.com')
    myip=ext_ip.data
    print ("%s"%ext_ip.data)

def update_it():
    file_newip="/home/anuraj/newip"
    newip=open(file_newip,"r")
    ip=newip.read()
    newip.close()
    file_path="/etc/nginx/conf.d/test.conf"
    file_path2="/etc/nginx/conf.d/test.updater"
    if os.path.exists(file_path):
        newf=open(file_path2,"w+")
        x=0;
        with open(file_path) as oldrFile:
            for i in oldrFile:
                if "server_name" in i and x is  0:
                    newstring = "server_name "+ip+";"
                    print(newstring)
                    newf.write(newstring)
                    x = 1
                else:
                    newf.write(i)


        newf.close()
        return 0
    else:
        return 1


update_it()
