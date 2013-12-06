package be.devine.cp3.billsplit.factory
{
import be.devine.cp3.billsplit.vo.BillVO;
import be.devine.cp3.billsplit.vo.FriendVO;

public class FactoryVO
{
    public function FactoryVO(){}

    public static function createBillVOFromJSON(json:JSON):BillVO
    {
        var billVO:BillVO;

        return billVO;
    }

    public static function createFriendVOFromJSON(json:JSON):FriendVO
    {
        var friendVO:FriendVO;

        return friendVO;
    }
}
}
