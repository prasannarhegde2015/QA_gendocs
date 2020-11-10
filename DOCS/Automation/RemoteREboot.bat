set machine=meinwesswks6
set user=srv_sitqa
set pwd=nhmfZ8tRJE{tzBd
net use \\%machine% %pwd% /user:%user%
shutdown /m \\%machine% /r /f
