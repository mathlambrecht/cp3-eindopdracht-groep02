package be.devine.cp3.billsplit.service
{

import be.devine.cp3.billsplit.config.Config;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class JSONService extends EventDispatcher
{
    private var _JSONFile:File;
    private var _fileStream:FileStream;
    private var _JSONString:String;

    private var _billsData:Object;
    private var _friendsData:Object;

    public function JSONService() {}

    public function load():void
    {
        _JSONFile = File.applicationStorageDirectory.resolvePath(Config.JSON_FILENAME);
        _fileStream = new FileStream();

        if(_JSONFile.exists)
        {
            _fileStream.open(_JSONFile, FileMode.READ);
            _JSONString = _fileStream.readUTFBytes(_fileStream.bytesAvailable);
            _fileStream.close();

            _billsData = JSON.parse(_JSONString);
        }
        else
        {
            _JSONFile = File.applicationStorageDirectory.resolvePath(Config.JSON_FILENAME);
            _fileStream.open(_JSONFile, FileMode.WRITE);
            _fileStream.writeUTFBytes('{}');
            _fileStream.close();

            _billsData = [];
        }

        dispatchEvent(new Event(Event.COMPLETE));
    }

    public function get billsData():Object
    {
        return _billsData;
    }
}
}
