#!/usr/bin/python

libprefixes = [
    'Landroid/', 
    'Ldalvik/', 
    'Ljava/', 
    'Ljavax/',
    'Lorg/apache/',
    'Lorg/json/',
    'Lorg/w3c/',
    'Lorg/xml'
    ]

# we can remove the whole java/lang and it works - tested to be runnining also
reflectprefixes = [
        'Ljava/lang/Class',
        'Ljava/lang/reflect'
        ]

primitives = dict({
    'Z':'Boolean',
    'B':'Byte',
    'S':'Short',
    'C':'Character',
    'I':'Integer',
    'J':'Long',
    'F':'Float',
    'D':'Double'
    })

class ToRefl:
    ccode = ''
    def __init__(self, line):
        self.line = line.strip()
        l = self.line
        idx = l.find(' ')
        self.invoke = l[:idx]
        if 'static' in self.invoke:
            self.static = True
        else:
            self.static = False
        l = l[idx+1:]
        idx = l.find('}') + 2 #we should be at the space after args
        self.arglist = l[1:idx-2]
        arglist = [a.strip(',') for a in l[1:idx-2].split()]
        if '..' in arglist:
            start = int(arglist[0][1:])
            end = int(arglist[2][1:])
            self.args = [arglist[0][0]+str(x) for x in range(start,end+1)]
        else:
            self.args = arglist        
        l = l[idx+1:]
        idx = l.find('->')
        self.cls = l[:idx] ##self.cls is the invoked class
        l = l[idx+2:]      
        idx = l.find('(')
        self.methname = l[:idx] ##self.methname is the invoked method name without the parameter        
        l = l[idx+1:]
        idx = l.find(')')
        argstring = l[:idx]
        self.argstring = argstring
        self.rettype = l[idx+1:]
        self.clsname = self.clsDescriptorToName(self.cls)

        self.argtypes = []
        x = ''
        idx = 0
        while idx < len(argstring):
            while argstring[idx] == '[':
                x += argstring[idx]
                idx += 1
            if argstring[idx] == 'L':
                idx1 = argstring.find(';', idx)
                x += argstring[idx:idx1]
                idx = idx1
            x += argstring[idx]
            idx += 1
            self.argtypes.append(x)
            x = ''
        #print self.methname, self.cls, self.argtypes

    def clsDescriptorToName(self, cls):
        return cls[1:-1].replace('/','.')

    def unusedRegister(self, n=4):
        argnums = set([int(a[1:]) for a in self.args])
        return ['v'+str(x) for x in list(set(range(100)) - argnums).sort()[:n]]
    
    def getCode(self, u):
        code = [
                'const/4 '+u[0]+', '+hex(len(self.argtypes)),
                'new-array '+u[1]+', '+u[0]+', '+'[Ljava/lang/Class;',
                'new-array '+u[2]+', '+u[0]+', '+'[Ljava/lang/Object;'
                ]
        args = list(self.args if self.static else self.args[1:])
        args.reverse()
        idx = 0
        for tau in self.argtypes:
            if tau.startswith('[') or tau.startswith('L'):
                tcode = ['const-class '+u[3]+', '+tau]
                vcode = []
                vreg = args.pop()
            else:
                tcode = ['sget-object '+u[3]+', Ljava/lang/'+primitives[tau]+
                        ';->TYPE:Ljava/lang/Class;']
                vcode = ['new-instance '+u[3]+', Ljava/lang/'+
                        primitives[tau]+';']
                if tau == 'J' or tau == 'D':
                    vregIntermediate = args.pop()+', '+args.pop()
                else:
                    vregIntermediate = args.pop()
                vcode.append('invoke-direct {'+u[3]+', '+vregIntermediate+
                        '}, Ljava/lang/'+primitives[tau]+';-><init>('+tau+')V')
                vreg = u[3]
            code.append('const/4 '+u[0]+', '+hex(idx))
            tcode.append('aput-object '+u[3]+', '+u[1]+', '+u[0])
            vcode.append('aput-object '+vreg+', '+u[2]+', '+u[0])
            code += tcode
            code += vcode
            idx += 1
        frag = [
                'const-string '+u[0]+', '+'"'+self.methname+'"',
                'const-class '+u[3]+', '+self.cls,
                'invoke-virtual {'+u[3]+', '+u[0]+', '+u[1]+'}, '+
                    'Ljava/lang/Class;->getMethod(Ljava/lang/String;'+
                    '[Ljava/lang/Class;)Ljava/lang/reflect/Method;',
                'move-result-object '+u[0]
                ]
        code += frag
        if self.static:
            code.append('const/4 '+u[3]+', 0x0')
            oreg = u[3]
        else:
            oreg = self.args[0]
        code.append('invoke-virtual {'+u[0]+', '+oreg+', '+u[2]+'}, '+
                'Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;'+
                '[Ljava/lang/Object;)Ljava/lang/Object;')
        if self.rettype in primitives:
            code += [
                    'move-result-object '+u[0],
                    'check-cast '+u[0]+',Ljava/lang/'+
                        primitives[self.rettype]+';',
                    ]
            if self.rettype == 'Z':
                meth = 'booleanValue'
            elif self.rettype == 'B':
                meth = 'byteValue'
            elif self.rettype == 'S':
                meth = 'shortValue'
            elif self.rettype == 'C':
                meth = 'charValue'
            elif self.rettype == 'I':
                meth = 'intValue'
            elif self.rettype == 'J':
                meth = 'longValue'
            elif self.rettype == 'F':
                meth = 'floatValue'
            elif self.rettype == 'D':
                meth = 'doubleValue'
            code.append('invoke-virtual {'+u[0]+'}, Ljava/lang/'+
                    primitives[self.rettype]+';->'+meth+'()'+self.rettype)
        return code

    def getCodeAfterMoveResult(self, line):
        #print self.rettype
        if self.rettype in primitives:
            raise Exception()
        u0 = line.strip().split()[1]
        code = ['check-cast '+u0+', '+self.rettype]
        return code

    def getCICode(self):
        c = 'LHelper;'
        meth = self.methname+'x'
        if self.static:
            argstring = self.argstring
        else:
            argstring = self.cls+self.argstring
        if 'range' in self.invoke:
            invoke = 'invoke-static/range'
        else:
            invoke = 'invoke-static'
        codeline = (invoke+' {'+self.arglist+'}, '+
            c+'->'+meth+'('+argstring+')'+self.rettype)
        mcode = '.method public static '+meth+'('+argstring+')'+self.rettype
        mcode += '\n    .registers %d' % (2+len(self.args))
        mcode += '\n    '
        minvoke = self.invoke
        if argstring == '':
            margs = '{}'
        else:
            margs ='{p0 .. p'+str(len(self.args)-1)+'}' 
            if 'range' not in self.invoke:
                minvoke += '/range'
        mcode += (minvoke+' '+margs+', '+self.cls+'->'+self.methname+'('+
            self.argstring+')'+self.rettype)
        mcode += '\n'
        if self.rettype == 'J' or self.rettype == 'D':
            mcode += '    move-result-wide v0\n'
            mcode += '    return-wide v0\n'
        elif self.rettype.startswith('L') or self.rettype.startswith('['):
            mcode += '    move-result-object v0\n'
            mcode += '    return-object v0\n'
        elif self.rettype == 'V':
            mcode += '    return-void\n'
        else:
            mcode += '    move-result v0\n'
            mcode += '    return v0\n'
        mcode += '.end method\n\n'
        if mcode not in ToRefl.ccode:
            ToRefl.ccode += mcode
        return codeline
        

def doreflect(fname):
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    index = 0
    regcount = 0
    numparam = 0
    needreg = 4
    allowed = False
    for line in f:
        l = line.strip()
        if line.startswith('.method') and l.find(' abstract ') < 0:
            tokens = l.split()
            desc = tokens[-1]
            idx = desc.find('(')
            methname = desc[:idx]
            numparam = 0
            idx += 1
            changed = None
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
        if l.startswith('.locals') or l.startswith('.registers'):
            tokens = l.split()
            regcount = int(tokens[1])
            if tokens[0] == '.locals':
                index = regcount
                regcount = regcount + numparam
            else:
                index = regcount - numparam
            if regcount + needreg < 17: #we need 4 more regs
                tmpf.write('    .registers ' + str(regcount + 4) + '\n')
                allowed = True
            else:
                allowed = False
                print fname, methname
                tmpf.write(line)
            continue
        if (l.startswith('invoke') and not l.startswith('invoke-super') and
                'init>' not in l and allowed):
            print 'original statement:'+line
            reflect = ToRefl(line)
            if (any([reflect.cls.startswith(x) for x in libprefixes]) and not
                    any([reflect.cls.startswith(x) for x in reflectprefixes])):
                changed = reflect
                u = ['v'+str(x) for x in range(index, index+needreg)]
                code = reflect.getCode(u)
                codestr = '\n    '.join(code)
                tmpf.write('    '+codestr+'\n')
                #print '    '+codestr+'\n'
                continue
        if l.startswith('filled-new-array') or l.startswith('invoke'):
            changed = None
        if l.startswith('move-result-object') and changed is not None:
            changed = None
            tmpf.write(line)
            code = reflect.getCodeAfterMoveResult(line)
            codestr = '\n    '.join(code)
            tmpf.write('    '+codestr+'\n')
            #print '    '+codestr+'\n'
            continue
        tmpf.write(line)
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)

import os
def doreflectrecursive(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            # doreflect(fname, sensitive)
            doreflect(fname)


#doreflect('orig-refl/Refl.smali')
#doreflectrecursive('mms')

def doci(fname):
    tmpfname = fname + '.tmp'
    f = open(fname)
    tmpf = open(tmpfname, 'w')
    index = 0
    regcount = 0
    numparam = 0
    needreg = 4
    allowed = True
    for line in f:
        l = line.strip()
        if (l.startswith('invoke') and not l.startswith('invoke-super') and
                'init>' not in l and allowed):
            reflect = ToRefl(line)
            if (any([reflect.cls.startswith(x) for x in libprefixes]) and not
                    any([reflect.cls.startswith(x) for x in reflectprefixes])):
                codeline = reflect.getCICode()
                tmpf.write('    '+codeline+'\n')
                continue
        tmpf.write(line)
    tmpf.close()
    f.close()
    os.rename(tmpfname, fname)

def docirecursive(topdir):
    for root, dirs, files in os.walk(topdir):
        for name in files:
            fname = os.path.join(root, name)
            doci(fname)
    code = '.class public LHelper;\n'
    code += '.super Ljava/lang/Object;\n\n'
    code += ToRefl.ccode
    f = open('Helper.smali','w')
    f.write(code)
    f.close()

#docirecursive('android')

