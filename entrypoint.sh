#!/bin/sh


chown syslog:syslog -R /logs
chown syslog:syslog -R /work

rsyslogd -n
