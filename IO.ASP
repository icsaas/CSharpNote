var FSO = new ActiveXObject("Scripting.FileSystemObject");
function Path(path) {
    if (path.indexOf(':') < 0)
        path = Server.MapPath(path);
    return path;
}
 
function File(path) {
    path = Path(path);
    this.Delete = function () {
        File.Delete(path);
    }
    this.Exists = function () {
        return File.Exists(path);
    }
}
 
File.Read = function (path) {
    path = Path(path);
    var ForReading = 1;
    var File = FSO.OpenTextFile(path, ForReading);
    return File.ReadAll();
}
 
File.Create = function (path, content) {
    path = Path(path);
     
    var File = FSO.CreateTextFile(path, true);
    File.Write(content);
    File.Close();
}
 
File.Delete = function (path) {
    path = Path(path);
    if (this.Exist(path)) {
        FSO.DeleteFile(path);
    }
}
 
File.Exists = function (path) {
    path = Path(path);
    return FSO.FileExists(path);
}
 
function Folder(path) {
    path = Path(path);
     
    this.Delete = function () {
        Folder.Delete(path);
    }
     
    this.Exists = function () {
        return Folder.Exists(path);
    }   
}
 
Folder.Create = function (path) {
    path = Path(path);
    if (!Folder.Exists(path)) {
        FSO.CreateFolder(path);
    }
}
 
Folder.Delete = function (path) {
    path = Path(path);
    if (Folder.Exists(path)) {
        FSO.DeleteFolder(path);
    }
}
 
Folder.Exists = function (path) {
    path = Path(path);
    return FSO.FolderExists(path);
}