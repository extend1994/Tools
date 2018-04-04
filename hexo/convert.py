import os, sys, re
def getTitle(firstLine):
  strs = ':'.join(firstLine.split(':')[1:])
  strs = strs.replace("'", '') 
  strs = strs.strip()
  title = '-'.join(strs.split(' '))
  return title

if __name__ == "__main__":
  dirName = sys.argv[1]
  for root,dirs,fileNames in os.walk(dirName):
    for fileName in fileNames:
      print "Old file: " + fileName
      fileName = os.path.join(root, fileName)
      f = open(fileName)

      for line in f:
        match=re.findall('^title:',line)
        if match != []:
          break;

      title = getTitle(line)
      f.close()

      newname = title + '.md'
      print "New file: " + newname
      os.rename(fileName, os.path.join(root,newname))
