#!/usr/bin/python

## change YOUR* pseudo-variables according to your needs

import imaplib

#default imap port is 993, change otherwise
M=imaplib.IMAP4_SSL("imap.free.fr", 993)
M.login("sathors","nicolas")

status, counts = M.status("Inbox","(MESSAGES UNSEEN)")

unread = counts[0].split()[4][:-1]
if int(unread) == 0:
    print("0")
else:
    print("<span color='red'> <b>"+unread.decode("utf-8")+"</b> </span>")

#print(int(unread))

M.logout()
