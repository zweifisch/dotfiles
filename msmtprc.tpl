account default              
host smtp.gmail.com          
port 587                     
protocol smtp
auth on                     

from #{email}
user #{email}

tls on                       
tls_starttls on              
tls_trust_file /etc/ssl/certs/Equifax_Secure_CA.pem

password #{passwd}
logfile ~/.msmtp.log
