remmina_disable_cert
====================

disable remmina asking to confirm certs prior to connecting to computers

(using gui) http://askubuntu.com/questions/137280/remmina-nags-about-rdp-certificate

but i have many connection profiles and did not want to spend time clicking on all of them.

i couldn't find a whole lot of documentation on the files inside ~/.remmina but it looks like all we need to do is add

security=rdp

at the end of the file