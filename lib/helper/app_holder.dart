import 'package:robocon_admin_2023/helper/registration_model.dart';

class AppHolder {
  static List<String> schoolList = [
    "SoSE-Lajpat Nagar",
    "SoSE-Narela",
    "SoSE-Rohini",
    "SoSE-Dwarka",
    "SoSE-Surajmal Vihar",
  ];

  static String getHtmlString(RegistrationModel model) {
    return """
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <style type="text/css">
      body{
        background-color: ${getBackgroundColor(model.type)};
      }
      #Group_3 {
        width: 100%;
        display: flex;
        justify-content: space-between;
      }

      #Mr_Sunil_Jha {
        overflow: visible;
        white-space: nowrap;
        text-align: center;
        font-family: Times New Roman;
        font-style: normal;
        font-weight: bold;
        font-size: 250%;
        color: rgba(0, 0, 0, 1);
      }
      #IIT_Delhi {
        overflow: visible;
        white-space: nowrap;
        text-align: center;
        font-family: Times New Roman;
        font-style: normal;
        font-weight: normal;
        font-size: 150%;
        color: rgba(0, 0, 0, 1);
      }
      #sunil_jha {
        width: 100%;
        text-align: center;
      }
      #Group_2 {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        padding: 4% 0;
        width: 100%;
        text-align: center;
        overflow: visible;
        height: 30px;
        background-color: ${getForegroundColor(model.type)};
      }
      #qr-image{
        width: 100%;
      }
      #Rectangle_2 {
        fill: rgba(102, 3, 119, 1);
      }
      .Rectangle_2 {
        overflow: visible;
        width: 100%;
      }
      #ORGANIZER {
        overflow: visible;
        white-space: nowrap;
        text-align: center;
        font-family: Ubuntu;
        font-style: normal;
        font-weight: bold;
        font-size: 150%;
        color: rgba(255, 255, 255, 1);
      }
      .logo-image {
        width: 15%;
        height: 15%;
        margin: 1%;
      }
      .logo-image-mid {
        width: 35%;
        margin: 1%;
      }
    </style>
    <div id="Organizer_Verified">
      <div id="Group_3">
        <img
          class="logo-image"
          src="https://web.iitd.ac.in/~ankesh/iitdlogo1.png"
        />

        <img
          class="logo-image-mid"
          src="http://www.ddrobocon.in/images/robocon-logo-final-white.png"
        />

        <img
          class="logo-image"
          src="https://upload.wikimedia.org/wikipedia/en/thumb/d/d5/DD_Logo.svg/1200px-DD_Logo.svg.png"
        />
      </div>
      <div id="Mr_Sunil_Jha">
        <span>${model.name}</span>
      </div>
      <div id="IIT_Delhi">
        <span>${model.nameOfOrganization}</span>
      </div>
      <div id="sunil_jha">
        <img id="qr-image"
          src="${model.qrImage}"
        />
      </div>

      <div id="Group_2">
        <div id="ORGANIZER">
          <span>${model.type?.toUpperCase()}</span>
        </div>
      </div>
    </div>
  </body>
</html>
""";
  }

  static String loginAs = "admin";

  static getBackgroundColor(String? type) {
    switch (type) {
      case "Organizer":
        return "#FEECFE";
      case "Participant":
        return "#BDD7EE";
      case "Sponsor":
        return "#C5E0B4";
      case "Volunteer":
        return "#FFE699";
      case "Visitor":
        return "#FFFFFF";
      case "SoSE-Teacher":
        return "#FFC6C6";
      default:
        return "#FFFFFF";
    }
  }

  static getForegroundColor(String? type) {
    switch (type) {
      case "Organizer":
        return "#660377";
      case "Participant":
        return "#1F4E79";
      case "Sponsor":
        return "#316224";
      case "Volunteer":
        return "#7F6000";
      case "Visitor":
        return "#000000";
      case "SoSE-Teacher":
        return "#622424";
      default:
        return "#000000";
    }
  }
  static List<String> types = [
    // "Organiser",
    "Participant",
    "Sponsor",
    "Volunteer",
    "Visitor",
  ];
  static List<String> committeeList = [
    "Accommodation",
    "Bookings, Ceremonies & Awards",
    "Catering",
    "Finance",
    "Game Fields And Objects",
    "Games, Referees And Judges",
    "Help Desk And Communication",
    "Infrastructure",
    "Registration And Certificates",
    "Security And Safety",
    "Transportation And Buddies",
    "Website And Sponsorships",
    "Weight And Measurement",
    "All"
  ];

  static Map<String, String> teamsList = {
    "ACPCE TEAM ROBOCON": "A.C.Patil College Of Engineering",
    "AGNEL ROBOCON TEAM": "Fr. Conceicao Rodrigues Institute Of Technology",
    "ALPHA": "Bannari Amman Institute Of Technology",
    "BRACT'S VISHWAKARMA INSTITUTE OF TECHNOLOGY, PUNE":
    "Bract'S Vishwakarma Institute Of Technology, Pune",
    "CSD ROBOCON NITK": "National Institute Of Technology Karnataka, Surathkal",
    "DRISHTI ROBOCON SVNIT":
    "Sardar Vallabhbhai National Institute Of Technology, Surat",
    "ENGINERDS": "Ajay Kumar Garg Engineering College",
    "GUJARAT TECHNOLOGICAL UNIVERSITY": "Gujarat Technological University",
    "IIT DELHI": "IIT DELHI",
    "MIT-WPU TECH TEAM": "Dr. Vishwanath Karad Mit World Peace University",
    "NOVA": "Bannari Amman Institute Of Technology",
    "PANCHJANYA": "Birla Vishvakarma Mahavidyalaya",
    "PICT ROBOTICS": "Pune Institute Of Computer Technology",
    "PU ROBOCON": "Parul Institute Of Technology / Parul University",
    "ROBOCON CRCE": "Fr. Conceicao Rodrigues College Of Engineering Bandra",
    "ROBOMANIPAL": "Manipal Institute Of Technology, Manipal",
    "ROBOPRIMUS": "Government College Of Engineering Karad",
    "ROBOTICS INTEREST GROUP-NIT CALICUT":
    "National Institute Of Technology Calicut (Kozhikode, Kerala)",
    "SPCE ROBOCON":
    "Bharatiya Vidya Bhavan'S Sardar Patel College Of Engineering",
    "SRM TEAM ROBOCON": "Srm Institute Of Science And Technology",
    "TEAM ABHEDYA":
    "Government College Of Engineering And Research, Avasari Khurd",
    "TEAM ANONYMOUS": "Modern Education Society'S College Of Engineering, Pune",
    "TEAM AUTOMATONS": "Pimpri Chinchwad College Of Engineering",
    "TEAM CIPHER": "Jspm'S Rajarshi Shahu College Of Engineering",
    "TEAM COEP": "Coep Technological University",
    "TEAM FALCON": "LJ University",
    "TEAM I-KON": "Kumaraguru College Of Technology",
    "TEAM KJSCE ROBOCON": "K.J. Somaiya College Of Engineering",
    "TEAM KJSIT ROBOCON": "K. J. Somaiya Institute Of Technology, Sion",
    "TEAM NIRMA ROBOCON": "Institute Of Technology, Nirma University",
    "TEAM PHOENIX": "Indian Institute Of Technology, Patna",
    "TEAM RNXG (ROBOTICS FOR NEXT GENERATION)":
    "Shri Guru Gobind Singhji Institute Of Engineering And Technology, Nanded",
    "TEAM ROBOCON LDCE": "L.D. College Of Engineering, Ahmedabad",
    "TEAM ROBOCON MJCET": "Muffakham Jah College Of Engineering And Technology",
    "TEAM ROBOLUTION": "Rustam Ji Institute Of Technology",
    "TEAM ROBOTICS AND AUTOMATION WING (RAW)":
    "St. Francis Institute Of Technology",
    "TEAM RUDRA": "Marathwada Mitra Mandal'S College Of Engineering Pune",
    "TEAM SAARTHAK": "Saffrony Institute Of Technology",
    "TEAM SPHINX": "Sanjivani College Of Enginnering",
    "TEAM TECHNOTIX":
    "SVKM'S Nmims, Mukesh Patel School Of Technology Management And Engineering, Mumbai",
    "TEAM TECH-TITANS":
    "Padmabhooshan Vasantdada Patil Institute Of Technology, Bavdhan, Pune.",
    "TEAM TITANS":
    "Zakir Husain College Of Engineering And Technology, Aligarh Muslim University",
    "TEAM UTKARSH": "U.V. Patel College Of Engineering - Ganpat University",
    "TEAM VIKASANA": "Presidency University, Bengaluru",
    "TEAM VITALITY": "Bannari Amman Institute Of Technology",
    "TEAM VULCAN ROBOTICS": "Walchand College Of Engineering Sangli",
    "TEAM VULCANS": "P.E.S. Modern College Of Engineering, Pune",
    "THE ROBOTECH FORUM": "Government College Of Engineering Amravati",
    "VIIT ROBOTICS": "Vishwakarma Institute Of Information Technology",
    "VOLTA": "MIT Art, Design & Technology University, Pune",
  };
}
