class RegistrationModel {
  String? name;
  String? personalEmail;
  String? collegeEmail;
  String? gender;
  String? mobileNumber;
  String? parentName;
  String? parentContact;
  String? currentAddress;
  String? permanentAddress;
  String? aadhar;
  String? photograph;
  String? haveRelativeInDelhi;
  String? relativeName;
  String? relativeContact;
  String? relativeAddress;
  String? collageName;
  String? department;
  String? currentSemester;
  String? collegeAddress;
  String? emergencyCollegeContact;
  String? coordinatingFacultyName;
  String? coordinatingFacultyContact;
  String? collageIdCard;
  String? bloodGroup;
  String? haveEverBeenCovid19;
  String? anyFamilyMember;
  String? otherDisease;
  String? medicalFraternity;
  String? doctorContact;
  String? modeOfTransport;
  String? departureStation;
  String? departureDatetime;
  String? arrivalStation;
  String? arrivalDatetime;
  String? tickets;
  String? qrImage;
  String? type;
  String? ticketsDeparture;
  String? departureStationFromDelhi;
  String? departureDatetimeFromDelhi;
  String? trainName;
  String? trainNumber;
  String? collegeGst;
  String? nameOfOrganization;
  String? nameOfEmployee;
  String? designation;
  String? location;
  String? mobile;
  String? email;
  String? nameOfVolunteer;
  String? comitteeName;
  String? nameOfVisitor;
  String? nameOfSponsor;
  String? rtpcrReport;
  String? team;
  String? departureMode;
  bool? isVerified;
  bool? tShirtReceived;
  String? visitorType;
  String? receiptVisitor;
  String? referenceEmail;
  String? referenceName;
  String? tShirtSize;
  List<String>? studentQr;
  String? country;
  String? countryDetails;
  bool? requiredTShirt;
  String? memberType;
  bool? stayInIIT = false;
  String? outsideAddress;
  String? referenceType;
  String? referenceOrg;
  String? referenceId;
  String? referenceIdDoc;

  RegistrationModel({
    this.name,
    this.personalEmail,
    this.collegeEmail,
    this.gender,
    this.mobileNumber,
    this.parentName,
    this.parentContact,
    this.currentAddress,
    this.permanentAddress,
    this.aadhar,
    this.photograph,
    this.haveRelativeInDelhi,
    this.relativeName,
    this.relativeContact,
    this.relativeAddress,
    this.collageName,
    this.department,
    this.currentSemester,
    this.collegeAddress,
    this.emergencyCollegeContact,
    this.coordinatingFacultyName,
    this.coordinatingFacultyContact,
    this.collageIdCard,
    this.bloodGroup,
    this.haveEverBeenCovid19,
    this.anyFamilyMember,
    this.otherDisease,
    this.medicalFraternity,
    this.doctorContact,
    this.modeOfTransport,
    this.departureStation,
    this.departureDatetime,
    this.arrivalStation,
    this.arrivalDatetime,
    this.tickets,
    this.qrImage,
    this.type,
    this.ticketsDeparture,
    this.departureStationFromDelhi,
    this.departureDatetimeFromDelhi,
    this.trainName,
    this.trainNumber,
    this.collegeGst,
    this.nameOfOrganization,
    this.nameOfEmployee,
    this.designation,
    this.location,
    this.mobile,
    this.email,
    this.nameOfVolunteer,
    this.comitteeName,
    this.nameOfVisitor,
    this.nameOfSponsor,
    this.rtpcrReport,
    this.team,
    this.departureMode,
    this.isVerified,
    this.receiptVisitor,
    this.referenceEmail,
    this.referenceName,
    this.visitorType,
    this.tShirtSize,
    this.studentQr,
    this.country,
    this.tShirtReceived,
    this.countryDetails,
    this.requiredTShirt,
    this.memberType,
    this.outsideAddress,
    this.stayInIIT = false,
    this.referenceType,
    this.referenceOrg,
    this.referenceId,
    this.referenceIdDoc
  });

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    personalEmail = json['personal_email'];
    collegeEmail = json['college_email'];
    gender = json['gender'];
    mobileNumber = json['mobile_number'];
    parentName = json['parent_name'];
    parentContact = json['parent_contact'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    aadhar = json['aadhar'];
    photograph = json['photograph'];
    haveRelativeInDelhi = json['have_relative_in_delhi'];
    relativeName = json['relative_name'];
    relativeContact = json['relative_contact'];
    relativeAddress = json['relative_address'];
    collageName = json['collage_name'];
    department = json['department'];
    currentSemester = json['current_semester'];
    collegeAddress = json['college_address'];
    emergencyCollegeContact = json['emergency_college_contact'];
    coordinatingFacultyName = json['coordinating_faculty_name'];
    coordinatingFacultyContact = json['coordinating_faculty_contact'];
    collageIdCard = json['collage_id_card'];
    bloodGroup = json['blood_group'];
    haveEverBeenCovid19 = json['have_ever_been_covid19'];
    anyFamilyMember = json['any_family_member'];
    otherDisease = json['other_disease'];
    medicalFraternity = json['medical_fraternity'];
    doctorContact = json['doctor_contact'];
    modeOfTransport = json['mode_of_transport'];
    departureStation = json['departure_station'];
    departureDatetime = json['departure_datetime'];
    arrivalStation = json['arrival_station'];
    arrivalDatetime = json['arrival_datetime'];
    tickets = json['tickets'];
    qrImage = json['qr_image'];
    type = json['type'];
    ticketsDeparture = json['tickets_departure'];
    departureStationFromDelhi = json['departure_station_from_delhi'];
    departureDatetimeFromDelhi = json['departure_datetime_from_delhi'];
    trainName = json['train_name'];
    trainNumber = json['train_number'];
    collegeGst = json['college_gst'];
    nameOfOrganization = json['name_of_organization'];
    nameOfEmployee = json['name_of_employee'];
    designation = json['designation'];
    location = json['location'];
    mobile = json['mobile'];
    email = json['email'];
    nameOfVolunteer = json['name_of_volunteer'];
    comitteeName = json['comittee_name'];
    nameOfVisitor = json['name_of_visitor'];
    nameOfSponsor = json['name_of_sponsor'];
    rtpcrReport = json['rtpcr_report'];
    team = json['team'];
    departureMode = json['departure_mode'];
    isVerified = json['verified'];
    tShirtReceived = json['t_shirt_received'];
    receiptVisitor = json['receipt_visitor'];
    referenceName = json['reference_name'];
    referenceEmail = json['reference_email'];
    visitorType = json['visitor_type'];
    tShirtSize = json['t_shirt_size'];
    country = json['country'];
    countryDetails = json['country_details'];
    requiredTShirt = json['required_t_shirt'];
    memberType = json['member_type'];
    stayInIIT = json['stay_in_iit'];
    outsideAddress = json['outside_address'];
    if (json['student_qr'] != null) {
      studentQr = json['student_qr'].cast<String>();
    }
    referenceType = json['reference_type'];
    referenceOrg = json['reference_org'];
    referenceId = json['reference_id'];
    referenceIdDoc = json['reference_id_doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null && name!.isNotEmpty) {
      data['name'] = name;
    }
    if (personalEmail != null && personalEmail!.isNotEmpty) {
      data['personal_email'] = personalEmail;
    }
    if (collegeEmail != null && collegeEmail!.isNotEmpty) {
      data['college_email'] = collegeEmail;
    }
    if (countryDetails != null && countryDetails!.isNotEmpty) {
      data['country_details'] = countryDetails;
    }
    if (gender != null && gender!.isNotEmpty) {
      data['gender'] = gender;
    }
    if (mobileNumber != null && mobileNumber!.isNotEmpty) {
      data['mobile_number'] = mobileNumber;
    }
    if (parentName != null && parentName!.isNotEmpty) {
      data['parent_name'] = parentName;
    }
    if (parentContact != null && parentContact!.isNotEmpty) {
      data['parent_contact'] = parentContact;
    }
    if (currentAddress != null && currentAddress!.isNotEmpty) {
      data['current_address'] = currentAddress;
    }
    if (permanentAddress != null && permanentAddress!.isNotEmpty) {
      data['permanent_address'] = permanentAddress;
    }
    if (aadhar != null && aadhar!.isNotEmpty) {
      data['aadhar'] = aadhar;
    }
    if (photograph != null && photograph!.isNotEmpty) {
      data['photograph'] = photograph;
    }
    if (haveRelativeInDelhi != null && haveRelativeInDelhi!.isNotEmpty) {
      data['have_relative_in_delhi'] = haveRelativeInDelhi;
    }
    if (relativeName != null && relativeName!.isNotEmpty) {
      data['relative_name'] = relativeName;
    }
    if (relativeContact != null && relativeContact!.isNotEmpty) {
      data['relative_contact'] = relativeContact;
    }
    if (relativeAddress != null && relativeAddress!.isNotEmpty) {
      data['relative_address'] = relativeAddress;
    }
    if (collageName != null && collageName!.isNotEmpty) {
      data['collage_name'] = collageName;
    }
    if (department != null && department!.isNotEmpty) {
      data['department'] = department;
    }
    if (currentSemester != null && currentSemester!.isNotEmpty) {
      data['current_semester'] = currentSemester;
    }
    if (collegeAddress != null && collegeAddress!.isNotEmpty) {
      data['college_address'] = collegeAddress;
    }
    if (emergencyCollegeContact != null &&
        emergencyCollegeContact!.isNotEmpty) {
      data['emergency_college_contact'] = emergencyCollegeContact;
    }
    if (coordinatingFacultyName != null &&
        coordinatingFacultyName!.isNotEmpty) {
      data['coordinating_faculty_name'] = coordinatingFacultyName;
    }
    if (coordinatingFacultyContact != null &&
        coordinatingFacultyContact!.isNotEmpty) {
      data['coordinating_faculty_contact'] = coordinatingFacultyContact;
    }
    if (collageIdCard != null && collageIdCard!.isNotEmpty) {
      data['collage_id_card'] = collageIdCard;
    }
    if (bloodGroup != null && bloodGroup!.isNotEmpty) {
      data['blood_group'] = bloodGroup;
    }
    if (haveEverBeenCovid19 != null && haveEverBeenCovid19!.isNotEmpty) {
      data['have_ever_been_covid19'] = haveEverBeenCovid19;
    }
    if (haveEverBeenCovid19 != null && haveEverBeenCovid19!.isNotEmpty) {
      data['any_family_member'] = anyFamilyMember;
    }
    if (otherDisease != null && otherDisease!.isNotEmpty) {
      data['other_disease'] = otherDisease;
    }
    if (medicalFraternity != null && medicalFraternity!.isNotEmpty) {
      data['medical_fraternity'] = medicalFraternity;
    }
    if (doctorContact != null && doctorContact!.isNotEmpty) {
      data['doctor_contact'] = doctorContact;
    }
    if (modeOfTransport != null && modeOfTransport!.isNotEmpty) {
      data['mode_of_transport'] = modeOfTransport;
    }
    if (departureStation != null && departureStation!.isNotEmpty) {
      data['departure_station'] = departureStation;
    }
    if (departureDatetime != null && departureDatetime!.isNotEmpty) {
      data['departure_datetime'] = departureDatetime;
    }
    if (arrivalStation != null && arrivalStation!.isNotEmpty) {
      data['arrival_station'] = arrivalStation;
    }
    if (arrivalDatetime != null && arrivalDatetime!.isNotEmpty) {
      data['arrival_datetime'] = arrivalDatetime;
    }
    if (tickets != null && tickets!.isNotEmpty) {
      data['tickets'] = tickets;
    }
    if (qrImage != null && qrImage!.isNotEmpty) {
      data['qr_image'] = qrImage;
    }
    if (type != null && type!.isNotEmpty) {
      data['type'] = type;
    }
    if (ticketsDeparture != null && ticketsDeparture!.isNotEmpty) {
      data['tickets_departure'] = ticketsDeparture;
    }
    if (departureStationFromDelhi != null &&
        departureStationFromDelhi!.isNotEmpty) {
      data['departure_station_from_delhi'] = departureStationFromDelhi;
    }
    if (departureDatetimeFromDelhi != null &&
        departureDatetimeFromDelhi!.isNotEmpty) {
      data['departure_datetime_from_delhi'] = departureDatetimeFromDelhi;
    }
    if (trainName != null && trainName!.isNotEmpty) {
      data['train_name'] = trainName;
    }
    if (trainNumber != null && trainNumber!.isNotEmpty) {
      data['train_number'] = trainNumber;
    }
    if (collegeGst != null && collegeGst!.isNotEmpty) {
      data['college_gst'] = collegeGst;
    }
    if (nameOfOrganization != null && nameOfOrganization!.isNotEmpty) {
      data['name_of_organization'] = nameOfOrganization;
    }
    if (nameOfEmployee != null && nameOfEmployee!.isNotEmpty) {
      data['name_of_employee'] = nameOfEmployee;
    }
    if (designation != null && designation!.isNotEmpty) {
      data['designation'] = designation;
    }
    if (location != null && location!.isNotEmpty) {
      data['location'] = location;
    }
    if (mobile != null && mobile!.isNotEmpty) {
      data['mobile'] = mobile;
    }
    if (email != null && email!.isNotEmpty) {
      data['email'] = email;
    }
    if (nameOfVolunteer != null && nameOfVolunteer!.isNotEmpty) {
      data['name_of_volunteer'] = nameOfVolunteer;
    }
    if (comitteeName != null && comitteeName!.isNotEmpty) {
      data['comittee_name'] = comitteeName;
    }
    if (nameOfVisitor != null && nameOfVisitor!.isNotEmpty) {
      data['name_of_visitor'] = nameOfVisitor;
    }
    if (nameOfSponsor != null && nameOfSponsor!.isNotEmpty) {
      data['name_of_sponsor'] = nameOfSponsor;
    }
    if (rtpcrReport != null && rtpcrReport!.isNotEmpty) {
      data['rtpcr_report'] = rtpcrReport;
    }
    if (team != null && team!.isNotEmpty) {
      data['team'] = team;
    }
    if (departureMode != null && departureMode!.isNotEmpty) {
      data['departure_mode'] = departureMode;
    }
    if (isVerified != null) {
      data['verified'] = isVerified;
    }
    if (tShirtReceived != null) {
      data['t_shirt_received'] = tShirtReceived;
    }
    if (receiptVisitor != null && receiptVisitor!.isNotEmpty) {
      data['receipt_visitor'] = receiptVisitor;
    }
    if (referenceName != null && referenceName!.isNotEmpty) {
      data['reference_name'] = referenceName;
    }
    if (referenceEmail != null) {
      data['reference_email'] = referenceEmail;
    }
    if (visitorType != null) {
      data['visitor_type'] = visitorType;
    }
    if (tShirtSize != null) {
      data['t_shirt_size'] = tShirtSize;
    }
    if(requiredTShirt !=null){
      data['required_t_shirt'] = requiredTShirt;
    }
    if (studentQr != null) {
      data['student_qr'] = studentQr;
    }
    if (country != null && country!.isNotEmpty) {
      data['country'] = country;
    }
    if (memberType != null) {
      data['member_type'] = memberType;
    }
    if (stayInIIT != null) {
      data['stay_in_iit'] = stayInIIT;
    }
    if (outsideAddress != null) {
      data['outside_address'] = outsideAddress;
    }
    if(referenceType!=null) {
      data['reference_type'] = referenceType;
    }
    if(referenceOrg!=null) {
      data['reference_org'] = referenceOrg;
    }
    if(referenceId!=null) {
      data['reference_id'] = referenceId;
    }
    if(referenceIdDoc!=null) {
      data['reference_id_doc'] = referenceIdDoc;
    }
    return data;
  }
}
