package be.devine.cp3.billsplit.service
{

import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.factory.FactoryVO;
import be.devine.cp3.billsplit.vo.BillVO;
import be.devine.cp3.billsplit.vo.FriendVO;

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
    private var _parsedJSON:Object;

    private var _arrBillsData:Vector.<BillVO>;
    private var _arrFriendsData:Vector.<FriendVO>;

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

            _parsedJSON = JSON.parse(_JSONString);

            _arrBillsData = new Vector.<BillVO>();
            _arrFriendsData = new Vector.<FriendVO>();

            for each(var bill:Object in _parsedJSON.bills)
            {
                _arrBillsData.push(FactoryVO.createBillVO(bill));
            }

            for each(var friend:Object in _parsedJSON.friends)
            {
                _arrFriendsData.push(FactoryVO.createFriendVO(friend));
            }
        }
        else
        {
            _JSONFile = File.applicationStorageDirectory.resolvePath(Config.JSON_FILENAME);
            _fileStream.open(_JSONFile, FileMode.WRITE);
            _fileStream.writeUTFBytes('{}');
            _fileStream.close();
        }

        dispatchEvent(new Event(Event.COMPLETE));
    }

    public function get arrBillsData():Vector.<BillVO>
    {
        return _arrBillsData;
    }

    public function get arrFriendsData():Vector.<FriendVO>
    {
        return _arrFriendsData;
    }
}
}
