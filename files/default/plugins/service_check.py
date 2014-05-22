#!/usr/bin/python

from optparse import OptionParser
import urllib2
import time

parser = OptionParser()
parser.add_option('-t' ,'--host', dest='host', help="Host name or address")
parser.add_option('-c', '--service_content', dest='service_content', help="Content to check in the service response")

(options, args) = parser.parse_args()
host = options.host
service_content = options.service_content

start_time = time.time()

try:
    response = urllib2.urlopen(host)
except urllib2.URLError:
  print "metric service_running string no"
else:
    response_code = response.getcode()

    if response_code == 200 and service_content in response.read():
        print "metric service_running string yes"
    else:
        print "metric service_running string no"

    print "metric response_code int %s" % response_code

end_time = time.time()
elapsed_time = end_time - start_time
print "metric response_time double %s seconds" % elapsed_time
