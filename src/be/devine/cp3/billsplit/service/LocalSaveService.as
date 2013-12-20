package be.devine.cp3.billsplit.service
{
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.vo.BillVO;

import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class LocalSaveService
{
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    public function LocalSaveService()
    {
        _appModel = AppModel.getInstance();
        _billModel = BillModel.getInstance();

        _appModel.addEventListener(AppModel.SAVE_BILL_LOCAL, saveBillLocalHandler);
    }

    private function saveBillLocalHandler(event:Event):void
    {
        trace('saving');

        _appModel.currentBillVO.id = _billModel.id;
        _appModel.currentBillVO.title = _billModel.title;
        _appModel.currentBillVO.totalPrice = _billModel.totalPrice;
        _appModel.currentBillVO.splitMethod = _billModel.splitMethod;
        _appModel.currentBillVO.arrItems = _billModel.arrItems;
        _appModel.currentBillVO.arrFriendItems = _billModel.arrFriendItems;
        _appModel.currentBillVO.arrFriendPercentage = _billModel.arrFriendPercentage;
        _appModel.currentBillVO.arrFriends = _billModel.arrFriends;

        var tmpArray:Vector.<BillVO> = new Vector.<BillVO>();

        if(_appModel.isNewFriend)
        {
            writeJSON();

            trace('saving new friend');

            _appModel.isNewFriend = false;
        }
        else
        {
            if(_appModel.isNewBill || _appModel.arrBillsVO.length == 0)
            {
                for each(var billVO:BillVO in _appModel.arrBillsVO)
                {
                    tmpArray.push(billVO);
                }

                tmpArray.push(_appModel.currentBillVO);
            }
            else
            {
                for each(var billVO:BillVO in _appModel.arrBillsVO)
                {
                    if(billVO.id == _billModel.id)
                    {
                        tmpArray.push(_appModel.currentBillVO);
                    }
                    else
                    {
                        tmpArray.push(billVO);
                    }
                }
            }

            _appModel.arrBillsVO = tmpArray;

            writeJSON();
        }
    }

    private function writeJSON():void
    {
        var wStream:FileStream = new FileStream();
        wStream.open(File.applicationStorageDirectory.resolvePath("bills.json"),FileMode.WRITE);
        wStream.writeUTFBytes(JSON.stringify({bills:_appModel.arrBillsVO, friends:_appModel.arrFriendsVO}));
        wStream.close();
    }
}
}