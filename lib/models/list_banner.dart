class ListBanner {
  int? status;
  String? message;
  List<DataBanner>? data;

  ListBanner({this.status, this.message, this.data});

  ListBanner.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataBanner>[];
      json['data'].forEach((v) {
        data!.add(DataBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataBanner {
  String? eventId;
  String? eventTitle;
  String? eventDescription;
  String? eventImage;
  String? eventUrl;

  DataBanner(
      {this.eventId,
      this.eventTitle,
      this.eventDescription,
      this.eventImage,
      this.eventUrl});

  DataBanner.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventTitle = json['event_title'];
    eventDescription = json['event_description'];
    eventImage = json['event_image'];
    eventUrl = json['event_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['event_title'] = eventTitle;
    data['event_description'] = eventDescription;
    data['event_image'] = eventImage;
    data['event_url'] = eventUrl;
    return data;
  }
}