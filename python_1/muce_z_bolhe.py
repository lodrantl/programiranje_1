import re
import requests
import csv
import time

'''
    File name: muce_z_bolhe.py
    Author: Luka Lodrant
    Date created: 5/10/2016
    Python Version: 3.5
'''

def get_sites():
    site = requests.get("http://www.bolha.com/zivali/male-zivali/macke/?listingType=list&page=1").text

    number_regex = re.compile(r'Št. najdenih oglasov: (\d*)', re.MULTILINE)

    number_sites = (int(number_regex.findall(site)[0]) // 20) - 18

    for i in range(2, number_sites):
        print(number_sites - i)
        site += requests.get("http://www.bolha.com/zivali/male-zivali/macke/?listingType=list&page=" + str(i)).text
    return site;


def get_ads(sites):
    p = re.compile(
        r'<div class="ad">.*?<a title="(.+?)".*?</h3>(.+?)<div.*?<div class="price">(?:<span>)?(.*?)(?:</span>)?</div>',
        re.MULTILINE | re.DOTALL)
    cats = p.findall(sites)
    for c in cats:
        print(c[1])
    return [{"Naslov": c[0].strip(), "Opis": c[1].strip(), "Cena": c[2].strip()} for c in cats]


def write_csv(filename, ads):
with open('muce.csv', 'w', encoding='utf-8') as f:
    writer = csv.DictWriter(f, dialect='excel', fieldnames=["Naslov", "Opis", "Cena"], )
    writer.writeheader()
    writer.writerows(ads)


def send_file(filename, address, subject):
    import smtplib
    from email.mime.text import MIMEText
    from email.mime.multipart import MIMEMultipart

    msg = MIMEMultipart()
    msg['Subject'] = subject
    msg['From'] = "luka.null@gmail.com"
    msg['To'] = address

    with open(filename, encoding='utf-8') as fp:
        attachment = MIMEText(fp.read(), "plain")
        attachment.add_header('Content-Disposition', 'attachment', filename=filename)
        msg.attach(attachment)

    #Gmail
    gmail_user = 'luka.null@gmail.com'
    gmail_pwd = 'not telling'
    smtpserver = smtplib.SMTP("smtp.gmail.com", 587)
    smtpserver.ehlo()
    smtpserver.starttls()
    smtpserver.ehlo
    smtpserver.login(gmail_user, gmail_pwd)
    smtpserver.send_message(msg)
    smtpserver.quit()

def runner():
    ads = get_ads(get_sites())
    write_csv('muce.csv', ads)
    send_file('muce.csv', "luka.lodrant@gmail.com", "Trenutna ponudba muc")
    time.sleep(60*60)
    runner()

runner()