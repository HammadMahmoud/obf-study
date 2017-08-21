#!/usr/bin/python

'''utils for giving adb, emulator commands; assume them in path
   and that they will not be'''

import subprocess
import shlex
import os.path

def killserver():
    subprocess.call(shlex.split('adb kill-server'))

def startserver():
    subprocess.call(shlex.split('adb start-server'))

def getadbcmd(args, device=None):
    ''' helper function:
        args - arguments excluding adb and device'''
    preargs = ['adb']
    if device and device.strip() != '':
        preargs += ['-s', device]
    return preargs + args;

def waitfordevice(device=None):
    subprocess.call(getadbcmd(['wait-for-device'], device))

def install(filename, device=None):
    return subprocess.call(getadbcmd(['install', filename], device))

def getdevices():
    args = ['adb', 'devices']
    output = subprocess.check_output(args)
    devices = []
    for line in output.splitlines():
        line = line.strip()
        if line == '': continue
        if line == 'List of devices attached': continue
        [name, type_] = line.split()
        if type_ == 'device':
            devices.append(name)
    return devices

def getstatus(device=None):
    return subprocess.check_output(getadbcmd(['get-status'], device)).strip()

def launchemulator(args):
    ''' returns corresponding process; can operate on it as p.poll()
        or p.terminate() '''
    if os.path.basename(args[0]) != 'emulator':
        args = 'emulator' + args
    p = subprocess.Popen(args)
    return p

def killemulator(device=None):
    ''' no snapshot will be saved 
        better option may be to terminate the process returned by
        launchemulator '''
    return subprocess.call(getadbcmd(['emu', 'kill'], device))

def init():
    print '(re)starting adb server'
    killserver()
    startserver()
    print 'killing any emulators already present'
    for device in getdevices():
        killemulator(device)
