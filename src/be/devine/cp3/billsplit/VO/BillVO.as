package be.devine.cp3.billsplit.vo
{
public class BillVO
{
    public var id:String;
    public var title:String;
    public var datetime:String;
    public var arrFriends:Array;
    public var arrItems:Array;
    public var totalPrice:Number;
    public var splitMethod:String;
    public var arrFriendPercentage:Array;
    public var arrFriendItems:Array;

    public function BillVO()
    {
        arrFriends = [];
        arrItems = [];
        arrFriendPercentage = [];
        arrFriendItems = [];
    }
}
}
