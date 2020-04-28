pragma solidity ^0.4.17;
pragma experimental ABIEncoderV2;
contract MailFactory {
    address[] public deployedMails;

    function createMail() public returns(address){
        address newMail = new Mail(msg.sender);// manager address로 변경 하기
        deployedMails.push(newMail);
        return newMail;
    }

    function getDeployedMails() public view returns (address[]){
        return deployedMails;
    }
}

contract Mail{
    address user = 0x6CcEf8229c07c937A22437eeb13261c4e4b7e835;
    address sendAgency = 0x50FE4cBC3C1E70A3B28590959Dc6aa7906829706;
    address hub = 0x0F66CDf7fEA7697f0269be6fdEB15Ed1d10D8560;
    address receiveAgency = 0x28bB21cE6d500Ba545eDcE0FAAcbDa6203E4a15C;
    address delivery = 0x5312eCc1BA898b251ce09d480e5Ea84D4d19e109;


    struct SenderInfo {
        string senderName;
        string senderPhone;
        string senderEmail;
        string senderAddress;
        string receiverName;
        string receiverPhone;
        string receiverAddress;
    }

    struct MailInfo{
        string productName;
        uint productPrice;
        uint quantity;
        uint weight;
        string other;
        bytes32 password;
        bool complete;
    }


   struct UserData{
        string senderName;
        string senderPhone;
        string senderAddress;
        string receiverName;
        string receiverPhone;
        string receiverAddress;
        string productName;
        uint quantity;
        bytes32 password;
    }




    SenderInfo[] public senderInfos;
    MailInfo[] public mailInfos;

    address public manager;

    function Mail(address creator) public {
        manager = creator;// manager address로 변경 하기
    }

    function addSenderInfo(string senderName, string senderPhone, string senderEmail, string senderAddress, string receiverName, string receiverPhone, string receiverAddress) public {
        SenderInfo memory newSenderInfo = SenderInfo({
            senderName: senderName,
            senderPhone: senderPhone,
            senderEmail: senderEmail,
            senderAddress: senderAddress,
            receiverName: receiverName,
            receiverPhone: receiverPhone,
            receiverAddress: receiverAddress
        });
        senderInfos.push(newSenderInfo);
    }
    function addMailInfo(string productName, uint productPrice, uint quantity, uint weight, string other, string password) public {
        MailInfo memory newMailInfo = MailInfo({
            productName: productName,
            productPrice: productPrice,
            quantity: quantity,
            weight: weight,
            other: other,
            password: keccak256(password),
            complete: false
        });
        mailInfos.push(newMailInfo);
    }

    function mailComplete(uint index, string password) public {
        MailInfo storage mailInfo = mailInfos[index];

        //require(배송기사 맞는지 확인 넣기)

        require(mailInfo.password == keccak256(password));
        mailInfo.complete = true;
    }

    function senderLength() public view returns (uint) {
        return senderInfos.length;
    }
    function mailLength() public view returns (uint) {
        return mailInfos.length;
    }

    function getUser(uint index) public view returns (UserData)
    {
        UserData memory u;
        u.senderName = senderInfos[index].senderName;
        u.senderPhone = "";
        u.senderAddress = "";
        u.receiverName = senderInfos[index].receiverName;
        u.receiverPhone = "";
        u.receiverAddress = "";
        u.productName = mailInfos[index].productName;
        u.quantity = mailInfos[index].quantity;
        u.password = "";
        return u;
    }

    function getStaff(uint index) public view returns (UserData)
    {
        UserData memory u;
        u.senderName = "";
        u.senderPhone = "";
        u.senderAddress = senderInfos[index].receiverAddress;
        u.receiverName = "";
        u.receiverPhone = "";
        u.receiverAddress = "";
        u.productName = "";
        u.quantity = mailInfos[index].quantity;
        u.password = "";
        return u;
    }

    function getDelivery(uint index) public view returns (UserData)
    {
        UserData memory u;
        u.senderName = senderInfos[index].senderName;
        u.senderPhone = senderInfos[index].senderPhone;
        u.senderAddress = senderInfos[index].senderAddress;
        u.receiverName = senderInfos[index].receiverName;
        u.receiverPhone = senderInfos[index].receiverPhone;
        u.receiverAddress = senderInfos[index].receiverAddress;
        u.productName = mailInfos[index].productName;
        u.quantity = mailInfos[index].quantity;
        u.password = mailInfos[index].password;
        return u;
    }


    function shipping_data(uint index) public view returns (UserData) {
        if(msg.sender == user)
        {
            UserData memory user_data = getUser(index);
            return user_data;
        }

        else if(msg.sender == sendAgency)
        {
            UserData memory sendAgency_data = getStaff(index);
            return sendAgency_data;
        }

        else if(msg.sender == hub)
        {
            UserData memory hub_data = getStaff(index);
            return hub_data;
        }

        else if(msg.sender == receiveAgency)
        {
            UserData memory receiveAgency_data = getStaff(index);
            return receiveAgency_data;
        }

        else if(msg.sender == delivery )
        {
            UserData memory delivery_data = getDelivery(index);
            return delivery_data;
        }
    }
}

contract Shipping{

    struct UserShippingData{
        string sendAgency;
        string sendAgency_time;
        string hub;
        string hub_time;
        string receiveAgency;
        string receiveAgency_time;
        string complite_time;
    }

    struct SendAgencyInfo{
        string sendAgency;
        string sendAgency_time;
    }

    struct HubInfo{
        string hub;
        string hub_time;
    }

    struct ReceiveAgencyInfo{
        string receiveAgency;
        string receiveAgency_time;
    }

    struct CompliteInfo{
        string complite_time;
    }

    SendAgencyInfo [] public sendAgencyInfos;
    HubInfo [] public hubInfos;
    ReceiveAgencyInfo [] public receiveAgencyInfos;
    CompliteInfo [] public compliteInfos;

    function setSendAgency(string name, string time) public {
        SendAgencyInfo memory newSendAgency = SendAgencyInfo({
            sendAgency: name,
            sendAgency_time: time
        });
        sendAgencyInfos.push(newSendAgency);
    }

    function setHub(string name, string time) public {
       HubInfo memory newHub = HubInfo({
            hub: name,
            hub_time: time
        });
        hubInfos.push(newHub);
    }

    function setReceiveAgency(string name, string time) public {
        ReceiveAgencyInfo memory newReceiveAgency = ReceiveAgencyInfo({
            receiveAgency: name,
            receiveAgency_time: time
        });
        receiveAgencyInfos.push(newReceiveAgency);
    }

    function setComplitey(string time) public {
        CompliteInfo memory newComplite = CompliteInfo({
            complite_time: time
        });
        compliteInfos.push(newComplite);
    }

    function getUserShipping(uint index) public view returns (UserShippingData)
    {
        UserShippingData memory s;
        s.sendAgency = sendAgencyInfos[index].sendAgency;
        s.sendAgency_time = sendAgencyInfos[index].sendAgency;
        s.hub = hubInfos[index].hub;
        s.hub_time = hubInfos[index].hub_time;
        s.receiveAgency = receiveAgencyInfos[index].receiveAgency;
        s.receiveAgency_time = receiveAgencyInfos[index].receiveAgency_time;
        s.complite_time = compliteInfos[index].complite_time;
        return s;
    }
}
