#!/usr/bin/python

import shlex, subprocess
import androidutil
import os
import pty

# data first
import json
datafile = open('data.json')
avdata = json.load(datafile)
datafile.close()

# preprocess to remove disabled avs
for av in avdata.keys():
    if avdata[av]['enabled']:
        del avdata[av]['enabled']
    else:
        del avdata[av]

locks = dict()
results = open('result.txt', 'w')

import threading
sema = threading.BoundedSemaphore(8)

class Scan(threading.Thread):
    def __init__(self, av, filename):
        self._av = av
        self._filename = filename
        threading.Thread.__init__(self)
    def run(self):
        ''' assume no emulator with this avd is running '''
        sema.acquire()
        av = self._av
        filename = self._filename
        #print '* task:', av, filename, '*'
        record = avdata[av]
        port = record['port']
        cmd = 'emulator @' + av
        cmd += ' -ports %d,%d' % (port, port+1)
        cmd += ' -no-snapshot-save'
        print 'launching emulator avd', av
        p = androidutil.launchemulator(shlex.split(cmd))
        device = 'emulator-%d' % port
        androidutil.waitfordevice(device)
        print 'indtalling app', filename
        code = androidutil.install(filename, device)
        if code != 0:
            print filename, 'could not install on', av, code
            print >>results, filename, av, -1
            results.flush()
            print 'killing #1 emulator avd', av
            p.terminate()
            p.wait()
            locks[av] = False
            sema.release()
            return
        # check when scan is done
        cmd = 'adb -s ' + device + ' logcat -v time'
        #TODO update with specific tags
        cmd += ' ActivityManager:I + NotificationManager:V + *:S'
        print cmd
        logmaster, logslave = pty.openpty()
        logcatp = subprocess.Popen(cmd, shell=True, stdout=logslave,
                stderr=logslave)
        stdout = os.fdopen(logmaster)
        written = False
        print 'checking logcat'
        line = stdout.readline()
        while line:
            print line.strip()
            if record['malNote'] in line: #TODO change this condition
                written = True
                print >>results, filename, av, 1
                break
            elif record['safeNote'] in line: #TODO change this condition
                written = True
                print >>results, filename, av, 0
                break #TODO do we set a time out
            line = stdout.readline()
        print 'out of logcat loop'
        if not written: #very wierd
            print filename, 'could not scan on', av
            print >>results, filename, av, -2
        results.flush()
        logcatp.terminate()
        print 'killing #1 emulator avd', av
        p.terminate()
        p.wait()
        locks[av] = False
        sema.release()
        return


# dispatch the files to different avs making sure that same av was not
# running earlier
from collections import OrderedDict
import time
def scanall(masterfile):
    androidutil.init()
    master = open(masterfile)
    d = OrderedDict()
    for line in master:
        filename = line.strip()
        for av in avdata.keys():
            d[(av, filename)] = None #we just want an ordered set
    master.close()
    for av in avdata.keys():
        locks[av] = False
    while len(d):
        wait = False
        for (av, filename) in d.keys():
            if locks[av]: continue
            locks[av] = True
            del d[(av, filename)]
            Scan(av, filename).start()
            wait = True
            break
        if wait:
            time.sleep(5)

scanall('masterfile')
