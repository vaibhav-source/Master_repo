#! /bin/bash
file_name=`echo "LDAP_MSISDN_$(date +%Y%m%d%H%M%S).CSV"`
echo "$file_name"

ldapsearch -z 10500 -x -D 'cn=shanmug,ou=mobility,dc=o2,dc=com' -b 'ou=mobility,dc=o2,dc=com' '(&(!(featureCode=VoLTE))(!(featureCode=VoWiFi))(!(featureCode=iCloudVoWiFi))(featureCode=Multi-SIM))' -w Welcome@1234567|grep -e "mdn" -e "imsi" -e "featureCode" | tr '\n' ' '| awk '{gsub(/featureCode:/,"\n")}1' |awk '{gsub(/imsi:/,",")}1'|awk '{gsub(/mdn:/,",")}1'|awk -F"," '{print $3",",$2",",$1}'|sed 's/ //g'|awk 'NR>1' >> $file_name
echo "dev branch"