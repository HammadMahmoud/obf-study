import scala.collection.JavaConversions._
import org.jf.dexlib._
import org.jf.dexlib.Util._
import scala.collection.mutable.HashMap
import scala.collection.mutable.HashSet
import scala.util.Random
import java.io.FileOutputStream


    // val RENAME_FIELDS = true
    // val RENAME_METHODS = true
    // val RENAME_CLASSES = false


    // if (args(0) == "-renameMethods") {
    //     var RENAME_METHODS = true
    // }
    // else if (args(0) == "-renameFields") {
    //     var RENAME_FIELDS = true
    // }
    // else if (args(0) == "-all") {
    //     var RENAME_METHODS = true
    //     var RENAME_FIELDS = true
    //     var RENAME_CLASSES = true
    // }

    val CLASS_PREFIX = Set("L") //process only classes which match this prefix
    val dex = new DexFile(args(1))
    val lib = new DexFile("android.dex", true, true)

    val wordmap = new HashMap[String, String]
    val newWordset = new HashSet[String]
    def randomWord(orig : String) : String = {
        val letters = {
            val lcase = "abcdefghijklmnopqrstuvwxyz"
            (lcase + lcase.toUpperCase).toList
        }
        def generateRandom() : String = {
            def g(sb : StringBuilder) : String =
                if (sb.length == 6) sb.toString else g(sb + letters(Random.nextInt(52)))
            val word = g(new StringBuilder)
            if (newWordset.contains(word)) generateRandom() else word
        }
        //had to do this for geinimi
        //if (orig.length <= 2 && !wordmap.contains(orig)) {
        //    wordmap += orig -> orig
        //    newWordset += wordmap(orig)
        //}
        if (!wordmap.contains(orig)) {
            wordmap += orig -> generateRandom()
            newWordset += wordmap(orig)
        }
        wordmap(orig)
    }

    //rename methods and fields
    //reorganize classes of lib -- a map from child to parent
    val childParentMap = new HashMap[String, String]
    val libMethClassMap = new HashMap[String, List[String]]
    for (clazz <- lib.ClassDefsSection.getItems) {
        val clazzType = clazz.getClassType.getTypeDescriptor
        if (clazzType != "Ljava/lang/Object;")
            childParentMap(clazzType) = clazz.getSuperclass.getTypeDescriptor
        Option(clazz.getClassData).foreach(_.getVirtualMethods.foreach( x => {
            val name = x.method.getMethodName.getStringValue
            if (!libMethClassMap.contains(name))
                libMethClassMap(name) = Nil
            libMethClassMap(name) ::= clazzType
        }))
    }

    for (clazz <- lib.ClassDefsSection.getItems) {
        val data = clazz.getClassData
        if (data != null) {
            newWordset ++= (data.getDirectMethods.toList ::: 
                data.getVirtualMethods.toList).map(_.method.getMethodName.getStringValue)
            newWordset ++= (data.getStaticFields.toList :::
                data.getInstanceFields.toList).map(_.field.getFieldName.getStringValue)
        }
    }

    //filter classes according to prefixes
    val dexClassesFiltered = dex.ClassDefsSection.getItems.filter( x =>
        CLASS_PREFIX.size==0 ||
        CLASS_PREFIX.exists(x.getClassType.getTypeDescriptor.startsWith(_)))

    //we do not need to add the methods defined in the dex (non lib) classes
    for (clazz <- dex.ClassDefsSection.getItems) {
        childParentMap += (
            clazz.getClassType.getTypeDescriptor ->
            clazz.getSuperclass.getTypeDescriptor)
    }

    for (clazz <- dexClassesFiltered) {
        //no problem in renaming direct methods
        if (args(0) == "-renameMethods" || args(0) == "-all") {
            Option(clazz.getClassData).foreach(_.getDirectMethods.foreach( x => {
                    val mname = x.method.getMethodName.getStringValue
                    if (mname != "<init>"
                        && mname != "<clinit>"
                        && mname.length > 3
                        && !mname.contains("$")
                        && !newWordset.contains(mname)) {
                        x.method.getMethodName.getStringDataItem.setStringValue(
                            randomWord(mname))
                        //println(mname + " " + x.method)
                    }
                }))
            //handle virtual methods carefully
            def allowRenameMethod(classname : String, methname : String) : Boolean = {
                if (!childParentMap.contains(classname))
                    true
                else if (libMethClassMap(methname).contains(childParentMap(classname)))
                    false
                else
                    allowRenameMethod(childParentMap(classname), methname)
            }

            Option(clazz.getClassData).foreach(_.getVirtualMethods.foreach( x => {
                    val mname = x.method.getMethodName.getStringValue
                    val classname = clazz.getClassType.getTypeDescriptor
                    if (mname.length > 3 && !newWordset.contains(mname) && (!libMethClassMap.contains(mname)
                            || allowRenameMethod(classname, mname))) {
                        x.method.getMethodName.getStringDataItem.setStringValue(
                            randomWord(mname))
                        //println(mname + " " + x.method)
                    }
                }))
        }
        if (args(0) == "-renameFields" || args(0) == "-all")
            Option(clazz.getClassData).foreach( y => 
                (y.getStaticFields.toList ::: y.getInstanceFields.toList).foreach( x => {
                    val fname = x.field.getFieldName.getStringValue
                    // don't rename small lengths. Some like F, Z,etc correspond to type desc and so wrong
                    if (fname.length > 3 && !fname.contains("$") && !newWordset.contains(fname)) {
                        x.field.getFieldName.getStringDataItem.setStringValue(randomWord(fname))
                        //println(fname + " " + x.field)
                    }
                })
            )

    }
    println(wordmap)
    println(wordmap.size)

    dex.place
    val out = new ByteArrayAnnotatedOutput
    dex.writeTo(out)
    val bytes = out.toByteArray
    DexFile.calcSignature(bytes)
    DexFile.calcChecksum(bytes)
    val fout = new FileOutputStream(args(2));
    fout.write(bytes)
    fout.close
