class RegisterUserInfo {
  int code;
  String message;
  Data data;

  RegisterUserInfo({this.code, this.message, this.data});

  RegisterUserInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String userName;
  String userMobile;
  Null userIcon;
  Null userRealName;
  Null userIdentityCard;
  Null userNickName;
  int userGender;
  Null userBirthday;
  Null userAddress;
  Null userSign;
  String registerTime;
  String updateTime;

  Data(
      {this.userName,
        this.userMobile,
        this.userIcon,
        this.userRealName,
        this.userIdentityCard,
        this.userNickName,
        this.userGender,
        this.userBirthday,
        this.userAddress,
        this.userSign,
        this.registerTime,
        this.updateTime});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    userIcon = json['user_icon'];
    userRealName = json['user_real_name'];
    userIdentityCard = json['user_identity_card'];
    userNickName = json['user_nick_name'];
    userGender = json['user_gender'];
    userBirthday = json['user_birthday'];
    userAddress = json['user_address'];
    userSign = json['user_sign'];
    registerTime = json['register_time'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_mobile'] = this.userMobile;
    data['user_icon'] = this.userIcon;
    data['user_real_name'] = this.userRealName;
    data['user_identity_card'] = this.userIdentityCard;
    data['user_nick_name'] = this.userNickName;
    data['user_gender'] = this.userGender;
    data['user_birthday'] = this.userBirthday;
    data['user_address'] = this.userAddress;
    data['user_sign'] = this.userSign;
    data['register_time'] = this.registerTime;
    data['update_time'] = this.updateTime;
    return data;
  }

  @override
  String toString() {
    return 'Data{userName: $userName, userMobile: $userMobile, userIcon: $userIcon, userRealName: $userRealName, userIdentityCard: $userIdentityCard, userNickName: $userNickName, userGender: $userGender, userBirthday: $userBirthday, userAddress: $userAddress, userSign: $userSign, registerTime: $registerTime, updateTime: $updateTime}';
  }
}
