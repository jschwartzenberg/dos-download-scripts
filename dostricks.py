'''
Created on 30 okt. 2019

@author: julius
'''
import argparse
import libarchive
import os
import tempfile
import urllib3
from tempfile import tempdir
import subprocess

tosecUrl = "http://archive.org/download/IBM_PC_Compatibles_TOSEC_2012_04_23/IBM_PC_Compatibles_TOSEC_2012_04_23.zip"

softwareList = {
    "cdraw12":    tosecUrl + "/IBM%20PC%20Compatibles%20%5BTOSEC%5D%2FIBM%20PC%20Compatibles%20-%20Applications%20-%20%5BIMA%5D%20%28TOSEC-v2011-01-06_CM%29%2FCorel%20Draw%20V1.2%20for%20Windows%203.0%20%281989%29%28Corel%29%28Disk%201%20of%207%29.zip",
    "drdos702":   tosecUrl + "/IBM%20PC%20Compatibles%20%5BTOSEC%5D%2FIBM%20PC%20Compatibles%20-%20Operating%20Systems%20-%20%5BIMA%5D%20%28TOSEC-v2011-01-06_CM%29%2FCaldera%20DR-DOS%20v7.02%20%281998%29%28Caldera%29%28Disk%201%20of%205%29.zip",
    "drdos703":   tosecUrl + "/IBM%20PC%20Compatibles%20%5BTOSEC%5D%2FIBM%20PC%20Compatibles%20-%20Operating%20Systems%20-%20%5BIMA%5D%20%28TOSEC-v2011-01-06_CM%29%2FCaldera%20DR-DOS%20v7.03%20%281998%29%28Caldera%20Systems%29%28Disk%201%20of%205%29.zip",
    "msdos622":   tosecUrl + "/IBM%20PC%20Compatibles%20%5BTOSEC%5D%2FIBM%20PC%20Compatibles%20-%20Operating%20Systems%20-%20%5BIMA%5D%20%28TOSEC-v2011-01-06_CM%29%2FMicrosoft%20MS-DOS%20v6.22%20%281994%29%28Microsoft%29%28Disk%201%20of%203%29.zip",
    "msoffice40": tosecUrl + "/IBM%20PC%20Compatibles%20%5BTOSEC%5D%2FIBM%20PC%20Compatibles%20-%20Applications%20-%20%5BIMA%5D%20%28TOSEC-v2011-01-06_CM%29%2FMicrosoft%20Office%20v4.0%20%281994%29%28Microsoft%29%28Disk%201%20of%2016%29.zip",
    "pcdos2k":    tosecUrl + "/IBM%20PC%20Compatibles%20%5BTOSEC%5D%2FIBM%20PC%20Compatibles%20-%20Operating%20Systems%20-%20%5BIMA%5D%20%28TOSEC-v2011-01-06_CM%29%2FIBM%20PC%20Dos%202000%20%281998%29%28IBM%29%28Disk%201%20of%206%29.zip",
    "wfw311":     tosecUrl + "/IBM%20PC%20Compatibles%20%5BTOSEC%5D%2FIBM%20PC%20Compatibles%20-%20Operating%20Systems%20-%20%5BIMA%5D%20%28TOSEC-v2011-01-06_CM%29%2FMicrosoft%20Windows%20for%20Workgroups%20v3.11%20%281994%29%28Microsoft%29%28Disk%201%20of%208%29.zip",
    "win31" :     tosecUrl + "/IBM%20PC%20Compatibles%20%5BTOSEC%5D%2FIBM%20PC%20Compatibles%20-%20Operating%20Systems%20-%20%5BIMA%5D%20%28TOSEC-v2011-01-06_CM%29%2FMicrosoft%20Windows%20v3.1%20%281992%29%28Microsoft%29%28Disk%201%20of%206%29.zip",
    "wp51"  :     tosecUrl + "/IBM%20PC%20Compatibles%20%5BTOSEC%5D%2FIBM%20PC%20Compatibles%20-%20Applications%20-%20%5BIMA%5D%20%28TOSEC-v2011-01-06_CM%29%2FWordPerfect%20v5.1%20for%20DOS%20%281989%29%28WordPerfect%20Corp%29%28Disk%201%20of%206%29.zip",
}


class RemoteDiskSet:

    def __init__(self, urlOfFirstDisk):
        self.urlOfFirstDisk = urlOfFirstDisk

    def getUrlList(self):
        diskIndex = self.urlOfFirstDisk.find("%28Disk%201%20of%20")
        toIncrementIndex = diskIndex + 10
        toIncrementEndIndex = diskIndex + 11
        numberOfDisksIndex = diskIndex + 19
        numberOfDisksEndIndex = self.urlOfFirstDisk.find("%29", numberOfDisksIndex)
        numberOfDisks = int(self.urlOfFirstDisk[numberOfDisksIndex:numberOfDisksEndIndex])
        urlList = list()
        for i in range(1, numberOfDisks + 1):
            urlList.append(self.urlOfFirstDisk[:toIncrementIndex] + str(i) + self.urlOfFirstDisk[toIncrementEndIndex:])
        return urlList


class Downloader(object):

    def __init__(self, url):
        self.url = url

    def download(self):
        http = urllib3.PoolManager()
        httpRequest = http.request('GET', self.url)
        httpRequest.read()
        return httpRequest.data


class Extractor(object):

    def __init__(self, data, destination):
        self.data = data
        self.destination = destination

    def extractArchive(self, tempdir, files):
        name = tempdir + "/" + files[0]
        tempdir = tempfile.TemporaryDirectory().name
        os.mkdir(tempdir)
        os.chdir(tempdir)
        print("just one file")
        try:
            libarchive.extract_file(name)
        except libarchive.exception.ArchiveError:
            print("running 7z")
            subprocess.run(["7z", "e", name, "-o" + self.destination, "-y", "-ssc-"])

    def extractDownload(self):
        currentDir = os.getcwd()
        tempdir = tempfile.TemporaryDirectory().name
        os.mkdir(tempdir)
        os.chdir(tempdir)
        libarchive.extract_memory(self.data)
        files = os.listdir(".")
        if (len(files) == 1):
            self.extractArchive(tempdir, files)
#         else:
            # move to destination
        os.chdir(currentDir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='dostricks, automates downloading and extracting')
    parser.add_argument('name', help='[' + ', '.join(softwareList.keys()) + ']')
    parser.add_argument('destination', help='destination directory')
    args = parser.parse_args()
    print("downloading...")
    os.makedirs(args.destination, exist_ok=True)
    os.chdir(args.destination)
    remoteDiskSet = RemoteDiskSet(softwareList.get(args.name))
    for url in remoteDiskSet.getUrlList():
        data = Downloader(url).download()
        extractor = Extractor(data, args.destination)
        extractor.extractDownload()
    print("downloading finished")
    print("eind")
