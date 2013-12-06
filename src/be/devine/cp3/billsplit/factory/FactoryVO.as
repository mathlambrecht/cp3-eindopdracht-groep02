package be.devine.cp3.billsplit.factory
{
import be.devine.cp3.billsplit.vo.FriendItemVO;
import be.devine.cp3.billsplit.vo.FriendPercentageVO;
import be.devine.cp3.billsplit.vo.FriendVO;
import be.devine.cp3.billsplit.vo.BillVO;

public class FactoryVO
{
    public function FactoryVO(){}

    public static function createBillVO(bill:Object):BillVO
    {
        var billVO:BillVO = new BillVO();

        billVO.id = bill.id;
        billVO.title = bill.title;
        billVO.datetime = bill.date;

        for each(var friend:Object in bill.friends)
        {
            billVO.arrFriends.push(createFriendVO(friend));
        }

        billVO.totalPrice = bill.totalPrice;
        billVO.splitMethod = bill.splitMethod;

        for each(var friendPercentage:Object in bill.friendPercentages)
        {
            billVO.arrFriendPercentage.push(createFriendPercentageVO(friendPercentage));
        }

        for each (var friendItem:Object in bill.friendItems)
        {
            billVO.arrFriendItems.push(createFriendItemVO(friendItem));
        }

        return billVO;
    }

    public static function createFriendVO(friend:Object):FriendVO
    {
        var friendVO:FriendVO = new FriendVO();

        friendVO.id = friend.id;
        friendVO.name = friend.name;

        return friendVO;
    }

    public static function createFriendPercentageVO(friendPercentage:Object):FriendPercentageVO
    {
        var friendPercentageVO:FriendPercentageVO = new FriendPercentageVO();

        friendPercentageVO.idFriend = friendPercentage.id;
        friendPercentageVO.percentage = friendPercentage.percentage;

        return friendPercentageVO;
    }

    public static function createFriendItemVO(friendItem:Object):FriendItemVO
    {
        var friendItemVO:FriendItemVO = new FriendItemVO();

        friendItemVO.idFriend = friendItem.idFriend;
        friendItemVO.idItem = friendItem.idItem;

        return friendItemVO;
    }
}
}
