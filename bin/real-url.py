import urllib

url = raw_input('What is the Google url? ')
url = url[url.find('&url=') + 5:]
url = url[:url.find('&')]

print urllib.unquote(url)
