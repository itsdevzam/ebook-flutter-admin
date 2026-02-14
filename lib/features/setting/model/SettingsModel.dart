

class SettingsModel {
  int? id;
  String? appName;
  String? copyrightText;
  String? admobBannerId;
  String? admobInterstitialId;
  String? admobVideoId;
  String? coupon;
  String? discountPercentage;
  String? oneMonth;
  String? sixMonth;
  String? oneYear;
  String? sliderOne;
  String? sliderTwo;
  String? slideThree;
  String? createdAt;
  String? updatedAt;

  SettingsModel(
      {this.id,
        this.appName,
        this.copyrightText,
        this.admobBannerId,
        this.admobInterstitialId,
        this.admobVideoId,
        this.coupon,
        this.discountPercentage,
        this.oneMonth,
        this.sixMonth,
        this.oneYear,
        this.sliderOne,
        this.sliderTwo,
        this.slideThree,
        this.createdAt,
        this.updatedAt});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['app_name'];
    copyrightText = json['copyright_text'];
    admobBannerId = json['admob_banner_id'];
    admobInterstitialId = json['admob_interstitial_id'];
    admobVideoId = json['admob_video_id'];
    coupon = json['coupon'];
    discountPercentage = json['discount_percentage'];
    oneMonth = json['one_month'];
    sixMonth = json['six_month'];
    oneYear = json['one_year'];
    sliderOne = json['slider_one'];
    sliderTwo = json['slider_two'];
    slideThree = json['slider_three'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_name'] = this.appName;
    data['copyright_text'] = this.copyrightText;
    data['admob_banner_id'] = this.admobBannerId;
    data['admob_interstitial_id'] = this.admobInterstitialId;
    data['admob_video_id'] = this.admobVideoId;
    data['coupon'] = this.coupon;
    data['discount_percentage'] = this.discountPercentage;
    data['one_month'] = this.oneMonth;
    data['six_month'] = this.sixMonth;
    data['one_year'] = this.oneYear;
    data['slider_one'] = this.sliderOne;
    data['slider_two'] = this.sliderTwo;
    data['slider_three'] = this.slideThree;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

