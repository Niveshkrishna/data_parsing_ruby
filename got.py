from bs4 import BeautifulSoup
import requests
import re
import urllib2
import os
import argparse
import sys
import json
import mechanize

def get_soup(url,header):
    return BeautifulSoup(urllib2.urlopen(urllib2.Request(url,headers=header)),'html.parser')

def main():
	lines = [line.rstrip('\n').split('\t') for line in open('item_names_new','r+')]
	links = open('item_links_new', 'w')
	for query in lines:
		tmp = query
		item_id = query[0]
		query = query[1]
		max_images = 5
		save_directory = 'item_images/'
		image_type="Action"
		query= str(query).split()
		query='+'.join(query)
		url="https://www.google.co.in/search?q="+query+"&source=lnms&tbm=isch"
		header={'User-Agent':"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36"}
		soup = get_soup(url,header)
		ActualImages=[]# contains the link for Large original images, type of  image
		for a in soup.find_all("div",{"class":"rg_meta"}):
			link , Type =json.loads(a.text)["ou"]  ,json.loads(a.text)["ity"]
			ActualImages.append((link,Type))
		for i , (img , Type) in enumerate( ActualImages[0:max_images]):
			links.write(str(item_id)+', ')
			links.write(img+'\n')
			print 'saved item id ' + str(item_id)
		
if __name__ == '__main__':
    try:
        main()
		
    except KeyboardInterrupt:
        pass
sys.exit()  
