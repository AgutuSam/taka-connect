class Counties {
  Counties(
      {this.name = '',
      this.capital = '',
      this.code = '',
      required this.subCounties});

  String name;
  String capital;
  String code;
  List subCounties;

  static List<Counties> countyList = <Counties>[
    Counties(name: "default", subCounties: [""]),
    Counties(name: "Kilifi", capital: "Kilifi", code: '3', subCounties: [
      "Ganze",
      "Kaloleni",
      "Kilifi North",
      "Kilifi South",
      "Magarini",
      "Malindi",
      "Rabai"
    ]),
    Counties(name: "Mombasa", capital: "Mombasa City", code: '1', subCounties: [
      "Changamwe",
      "Jomvu",
      "Kisauni",
      "Likoni",
      "Mvita",
      "Nyali"
    ]),
  ];
  static List<Counties> countyListOri = <Counties>[
    Counties(name: "default", subCounties: [""]),
    Counties(name: "Baringo", capital: "Kabarnet", code: '30', subCounties: [
      "Baringo central",
      "Baringo north",
      "Baringo south",
      "Eldama ravine",
      "Mogotio",
      "Tiaty"
    ]),
    Counties(name: "Bomet", capital: "Bomet", code: '36', subCounties: [
      "Bomet central",
      "Bomet east",
      "Chepalungu",
      "Konoin",
      "Sotik"
    ]),
    Counties(name: "Bungoma", capital: "Bungoma", code: '39', subCounties: [
      "Bumula",
      "Kabuchai",
      "Kanduyi",
      "Kimilil",
      "Mt Elgon",
      "Sirisia",
      "Tongaren",
      "Webuye east",
      "Webuye west"
    ]),
    Counties(name: "Busia", capital: "Busia", code: '40', subCounties: [
      "Budalangi",
      "Butula",
      "Funyula",
      "Nambele",
      "Teso North",
      "Teso South"
    ]),
    Counties(
        name: "Elgeyo-Marakwet",
        capital: "Iten",
        code: '28',
        subCounties: [
          "Keiyo north",
          "Keiyo south",
          "Marakwet east",
          "Marakwet west"
        ]),
    Counties(
        name: "Embu",
        capital: "Embu",
        code: '14',
        subCounties: ["Manyatta", "Mbeere north", "Mbeere south", "Runyenjes"]),
    Counties(name: "Garissa", capital: "Garissa", code: '7', subCounties: [
      "Daadab",
      "Fafi",
      "Garissa",
      "Hulugho",
      "Ijara",
      "Lagdera balambala"
    ]),
    Counties(name: "Homa Bay", capital: "Homa Bay", code: '43', subCounties: [
      "Homabay town",
      "Kabondo",
      "Karachwonyo",
      "Kasipul",
      "Mbita",
      "Ndhiwa",
      "Rangwe",
      "Suba"
    ]),
    Counties(name: "Isiolo", capital: "Isiolo", code: '11', subCounties: [
      "Central",
      "Garba tula",
      "Kina",
      "Merit",
      "Oldonyiro",
      "Sericho"
    ]),
    Counties(name: "Kajiado", code: '34', subCounties: [
      "Isinya.",
      "Kajiado Central.",
      "Kajiado North.",
      "Loitokitok.",
      "Mashuuru."
    ]),
    Counties(name: "Kakamega", capital: "Kakamega", code: '37', subCounties: [
      "Butere",
      "Kakamega central",
      "Kakamega east",
      "Kakamega north",
      "Kakamega south",
      "Khwisero",
      "Lugari",
      "Lukuyani",
      "Lurambi",
      "Matete",
      "Mumias",
      "Mutungu",
      "Navakholo"
    ]),
    Counties(name: "Kericho", capital: "Kericho", code: '35', subCounties: [
      "Ainamoi",
      "Belgut",
      "Bureti",
      "Kipkelion east",
      "Kipkelion west",
      "Soin sigowet"
    ]),
    Counties(name: "Kiambu", capital: "Kiambu", code: '22', subCounties: [
      "Gatundu north",
      "Gatundu south",
      "Githunguri",
      "Juja",
      "Kabete",
      "Kiambaa",
      "Kiambu",
      "Kikuyu",
      "Limuru",
      "Ruiru",
      "Thika town",
      "lari"
    ]),
    Counties(name: "Kilifi", capital: "Kilifi", code: '3', subCounties: [
      "Genzw",
      "Kaloleni",
      "Kilifi north",
      "Kilifi south",
      "Magarini",
      "Malindi",
      "Rabai"
    ]),
    Counties(
        name: "Kirinyaga",
        capital: "Kerugoya/Kutus",
        code: '20',
        subCounties: [
          "Kirinyaga central",
          "Kirinyaga east",
          "Kirinyaga west",
          "Mwea east",
          "Mwea west"
        ]),
    Counties(name: "Kisii", capital: "Kisii", code: '45', subCounties: []),
    Counties(name: "Kisumu", capital: "Kisumu", code: '42', subCounties: [
      "Kisumu central",
      "Kisumu east ",
      "Kisumu west",
      "Mohoroni",
      "Nyakach",
      "Nyando",
      "Seme"
    ]),
    Counties(name: "Kitui", capital: "Kitui", code: '15', subCounties: [
      "Ikutha",
      "Katulani",
      "Kisasi",
      "Kitui central",
      "Kitui west ",
      "Lower yatta",
      "Matiyani",
      "Migwani",
      "Mutitu",
      "Mutomo",
      "Muumonikyusu",
      "Mwingi central",
      "Mwingi east",
      "Nzambani",
      "Tseikuru"
    ]),
    Counties(
        name: "Kwale",
        capital: "Kwale",
        code: '2',
        subCounties: ["Kinango", "Lungalunga", "Msambweni", "Mutuga"]),
    Counties(name: "Laikipia", capital: "Rumuruti", code: '31', subCounties: [
      "Laikipia central",
      "Laikipia east",
      "Laikipia north",
      "Laikipia west ",
      "Nyahururu"
    ]),
    Counties(
        name: "Lamu",
        capital: "Lamu",
        code: '5',
        subCounties: ["Lamu East", "Lamu West"]),
    Counties(name: "Machakos", capital: "Machakos", code: '16', subCounties: [
      "Kathiani",
      "Machakos town",
      "Masinga",
      "Matungulu",
      "Mavoko",
      "Mwala",
      "Yatta"
    ]),
    Counties(name: "Makueni", capital: "Wote", code: '17', subCounties: [
      "Kaiti",
      "Kibwei west",
      "Kibwezi east",
      "Kilome",
      "Makueni",
      "Mbooni"
    ]),
    Counties(name: "Mandera", capital: "Mandera", code: '9', subCounties: [
      "Banissa",
      "Lafey",
      "Mandera East",
      "Mandera North",
      "Mandera South",
      "Mandera West"
    ]),
    Counties(
        name: "Marsabit",
        capital: "Marsabit",
        code: '10',
        subCounties: ["Laisamis", "Moyale", "North hor", "Saku"]),
    Counties(name: "Meru", capital: "Meru", code: '12', subCounties: [
      "Buuri",
      "Igembe central",
      "Igembe north",
      "Igembe south",
      "Imenti central",
      "Imenti north",
      "Imenti south",
      "Tigania east",
      "Tigania west"
    ]),
    Counties(name: "Migori", capital: "Migori", code: '44', subCounties: [
      "Awendo",
      "Kuria east",
      "Kuria west",
      "Mabera",
      "Ntimaru",
      "Rongo",
      "Suna east",
      "Suna west",
      "Uriri"
    ]),
    Counties(name: "Mombasa", capital: "Mombasa City", code: '1', subCounties: [
      "Changamwe",
      "Jomvu",
      "Kisauni",
      "Likoni",
      "Mvita",
      "Nyali"
    ]),
    Counties(name: "Murang'a", capital: "Murang'a", code: '21', subCounties: [
      "Gatanga",
      "Kahuro",
      "Kandara",
      "Kangema",
      "Kigumo",
      "Kiharu",
      "Mathioya",
      "Murang’a south"
    ]),
    Counties(
        name: "Nairobi",
        capital: "Nairobi City",
        code: '47',
        subCounties: [
          "Dagoretti North Sub County",
          "Dagoretti South Sub County ",
          "Embakasi Central Sub Count",
          "Embakasi East Sub County",
          "Embakasi North Sub County ",
          "Embakasi South Sub County",
          "Embakasi West Sub County",
          "Kamukunji Sub County",
          "Kasarani Sub County ",
          "Kibra Sub County ",
          "Lang'ata Sub County ",
          "Makadara Sub County",
          "Mathare Sub County ",
          "Roysambu Sub County ",
          "Ruaraka Sub County ",
          "Starehe Sub County ",
          "Westlands Sub County "
        ]),
    Counties(name: "Nakuru", capital: "Nakuru", code: '32', subCounties: [
      "Bahati",
      "Gilgil",
      "Kuresoi north",
      "Kuresoi south",
      "Molo",
      "Naivasha",
      "Nakuru town east",
      "Nakuru town west",
      "Njoro",
      "Rongai",
      "Subukia"
    ]),
    Counties(name: "Nandi", capital: "Kapsabet", code: '29', subCounties: [
      "Aldai",
      "Chesumei",
      "Emgwen",
      "Mosop",
      "Namdi hills",
      "Tindiret"
    ]),
    Counties(name: "Narok", capital: "Narok", code: '33', subCounties: [
      "Narok east",
      "Narok north",
      "Narok south",
      "Narok west",
      "Transmara east",
      "Transmara west"
    ]),
    Counties(name: "Nyamira", capital: "Nyamira", code: '46', subCounties: [
      "Borabu",
      "Manga",
      "Masaba north",
      "Nyamira north",
      "Nyamira south"
    ]),
    Counties(name: "Nyandarua", capital: "Ol Kalou", code: '18', subCounties: [
      "Kinangop",
      "Kipipiri",
      "Ndaragwa",
      "Ol Kalou",
      "Ol joro orok"
    ]),
    Counties(name: "Nyeri", capital: "Nyeri", code: '19', subCounties: [
      "Kieni east",
      "Kieni west",
      "Mathira east",
      "Mathira west",
      "Mkurweni",
      "Nyeri town",
      "Othaya",
      "Tetu"
    ]),
    Counties(
        name: "Samburu",
        capital: "Maralal",
        code: '25',
        subCounties: ["Samburu east", "Samburu north", "Samburu west"]),
    Counties(name: "Siaya", capital: "Siaya", code: '41', subCounties: [
      "Alego usonga",
      "Bondo",
      "Gem",
      "Rarieda",
      "Ugenya",
      "Unguja"
    ]),
    Counties(
        name: "Taita-Taveta",
        capital: "Voi",
        code: '6',
        subCounties: ["Mwatate", "Taveta", "Voi", "Wundanyi"]),
    Counties(
        name: "Tana River",
        capital: "Hola",
        code: '4',
        subCounties: ["Bura", "Galole", "Garsen"]),
    Counties(name: "Tharaka-Nithi", capital: "Chuka", code: '13', subCounties: [
      "Chuka",
      "Igambangobe",
      "Maara",
      "Muthambi",
      "Tharak north",
      "Tharaka south"
    ]),
    Counties(name: "Trans-Nzoia", capital: "Kitale", code: '26', subCounties: [
      "Cherangany",
      "Endebess",
      "Kiminini",
      "Kwanza",
      "Saboti"
    ]),
    Counties(name: "Turkana", capital: "Lodwar", code: '23', subCounties: [
      "Loima",
      "Turkana central",
      "Turkana east",
      "Turkana north",
      "Turkana south"
    ]),
    Counties(name: "Uasin Gishu", capital: "Eldoret", code: '27', subCounties: [
      "Ainabkoi",
      "Kapseret",
      "Kesses",
      "Moiben",
      "Soy",
      "Turbo"
    ]),
    Counties(
        name: "Vihiga",
        capital: "Vihiga",
        code: '38',
        subCounties: ["Emuhaya", "Hamisi", "Luanda", "Sabatia", "vihiga"]),
    Counties(name: "Wajir", capital: "Wajir", code: '8', subCounties: [
      "Eldas",
      "Tarbaj",
      "Wajir East",
      "Wajir North",
      "Wajir South",
      "Wajir West"
    ]),
    Counties(
        name: "West Pokot",
        capital: "Kapenguria",
        code: '24',
        subCounties: [
          "Central Pokot",
          "North Pokot",
          "Pokot South",
          "West Pokot"
        ])
  ];

  static List countiesKE = [
    {
      "name": "default",
      "sub_counties": ['']
    },
    {
      "name": "Baringo",
      "capital": "Kabarnet",
      "code": 30,
      "sub_counties": [
        "Baringo central",
        "Baringo north",
        "Baringo south",
        "Eldama ravine",
        "Mogotio",
        "Tiaty"
      ]
    },
    {
      "name": "Bomet",
      "capital": "Bomet",
      "code": 36,
      "sub_counties": [
        "Bomet central",
        "Bomet east",
        "Chepalungu",
        "Konoin",
        "Sotik"
      ]
    },
    {
      "name": "Bungoma",
      "capital": "Bungoma",
      "code": 39,
      "sub_counties": [
        "Bumula",
        "Kabuchai",
        "Kanduyi",
        "Kimilil",
        "Mt Elgon",
        "Sirisia",
        "Tongaren",
        "Webuye east",
        "Webuye west"
      ]
    },
    {
      "name": "Busia",
      "capital": "Busia",
      "code": 40,
      "sub_counties": [
        "Budalangi",
        "Butula",
        "Funyula",
        "Nambele",
        "Teso North",
        "Teso South"
      ]
    },
    {
      "name": "Elgeyo-Marakwet",
      "capital": "Iten",
      "code": 28,
      "sub_counties": [
        "Keiyo north",
        "Keiyo south",
        "Marakwet east",
        "Marakwet west"
      ]
    },
    {
      "name": "Embu",
      "capital": "Embu",
      "code": 14,
      "sub_counties": ["Manyatta", "Mbeere north", "Mbeere south", "Runyenjes"]
    },
    {
      "name": "Garissa",
      "capital": "Garissa",
      "code": 7,
      "sub_counties": [
        "Daadab",
        "Fafi",
        "Garissa",
        "Hulugho",
        "Ijara",
        "Lagdera balambala"
      ]
    },
    {
      "name": "Homa Bay",
      "capital": "Homa Bay",
      "code": 43,
      "sub_counties": [
        "Homabay town",
        "Kabondo",
        "Karachwonyo",
        "Kasipul",
        "Mbita",
        "Ndhiwa",
        "Rangwe",
        "Suba"
      ]
    },
    {
      "name": "Isiolo",
      "capital": "Isiolo",
      "code": 11,
      "sub_counties": [
        "Central",
        "Garba tula",
        "Kina",
        "Merit",
        "Oldonyiro",
        "Sericho"
      ]
    },
    {
      "name": "Kajiado",
      "code": 34,
      "sub_counties": [
        "Isinya.",
        "Kajiado Central.",
        "Kajiado North.",
        "Loitokitok.",
        "Mashuuru."
      ]
    },
    {
      "name": "Kakamega",
      "capital": "Kakamega",
      "code": 37,
      "sub_counties": [
        "Butere",
        "Kakamega central",
        "Kakamega east",
        "Kakamega north",
        "Kakamega south",
        "Khwisero",
        "Lugari",
        "Lukuyani",
        "Lurambi",
        "Matete",
        "Mumias",
        "Mutungu",
        "Navakholo"
      ]
    },
    {
      "name": "Kericho",
      "capital": "Kericho",
      "code": 35,
      "sub_counties": [
        "Ainamoi",
        "Belgut",
        "Bureti",
        "Kipkelion east",
        "Kipkelion west",
        "Soin sigowet"
      ]
    },
    {
      "name": "Kiambu",
      "capital": "Kiambu",
      "code": 22,
      "sub_counties": [
        "Gatundu north",
        "Gatundu south",
        "Githunguri",
        "Juja",
        "Kabete",
        "Kiambaa",
        "Kiambu",
        "Kikuyu",
        "Limuru",
        "Ruiru",
        "Thika town",
        "lari"
      ]
    },
    {
      "name": "Kilifi",
      "capital": "Kilifi",
      "code": 3,
      "sub_counties": [
        "Genzw",
        "Kaloleni",
        "Kilifi north",
        "Kilifi south",
        "Magarini",
        "Malindi",
        "Rabai"
      ]
    },
    {
      "name": "Kirinyaga",
      "capital": "Kerugoya/Kutus",
      "code": 20,
      "sub_counties": [
        "Kirinyaga central",
        "Kirinyaga east",
        "Kirinyaga west",
        "Mwea east",
        "Mwea west"
      ]
    },
    {"name": "Kisii", "capital": "Kisii", "code": 45, "sub_counties": []},
    {
      "name": "Kisumu",
      "capital": "Kisumu",
      "code": 42,
      "sub_counties": [
        "Kisumu central",
        "Kisumu east ",
        "Kisumu west",
        "Mohoroni",
        "Nyakach",
        "Nyando",
        "Seme"
      ]
    },
    {
      "name": "Kitui",
      "capital": "Kitui",
      "code": 15,
      "sub_counties": [
        "Ikutha",
        "Katulani",
        "Kisasi",
        "Kitui central",
        "Kitui west ",
        "Lower yatta",
        "Matiyani",
        "Migwani",
        "Mutitu",
        "Mutomo",
        "Muumonikyusu",
        "Mwingi central",
        "Mwingi east",
        "Nzambani",
        "Tseikuru"
      ]
    },
    {
      "name": "Kwale",
      "capital": "Kwale",
      "code": 2,
      "sub_counties": ["Kinango", "Lungalunga", "Msambweni", "Mutuga"]
    },
    {
      "name": "Laikipia",
      "capital": "Rumuruti",
      "code": 31,
      "sub_counties": [
        "Laikipia central",
        "Laikipia east",
        "Laikipia north",
        "Laikipia west ",
        "Nyahururu"
      ]
    },
    {
      "name": "Lamu",
      "capital": "Lamu",
      "code": 5,
      "sub_counties": ["Lamu East", "Lamu West"]
    },
    {
      "name": "Machakos",
      "capital": "Machakos",
      "code": 16,
      "sub_counties": [
        "Kathiani",
        "Machakos town",
        "Masinga",
        "Matungulu",
        "Mavoko",
        "Mwala",
        "Yatta"
      ]
    },
    {
      "name": "Makueni",
      "capital": "Wote",
      "code": 17,
      "sub_counties": [
        "Kaiti",
        "Kibwei west",
        "Kibwezi east",
        "Kilome",
        "Makueni",
        "Mbooni"
      ]
    },
    {
      "name": "Mandera",
      "capital": "Mandera",
      "code": 9,
      "sub_counties": [
        "Banissa",
        "Lafey",
        "Mandera East",
        "Mandera North",
        "Mandera South",
        "Mandera West"
      ]
    },
    {
      "name": "Marsabit",
      "capital": "Marsabit",
      "code": 10,
      "sub_counties": ["Laisamis", "Moyale", "North hor", "Saku"]
    },
    {
      "name": "Meru",
      "capital": "Meru",
      "code": 12,
      "sub_counties": [
        "Buuri",
        "Igembe central",
        "Igembe north",
        "Igembe south",
        "Imenti central",
        "Imenti north",
        "Imenti south",
        "Tigania east",
        "Tigania west"
      ]
    },
    {
      "name": "Migori",
      "capital": "Migori",
      "code": 44,
      "sub_counties": [
        "Awendo",
        "Kuria east",
        "Kuria west",
        "Mabera",
        "Ntimaru",
        "Rongo",
        "Suna east",
        "Suna west",
        "Uriri"
      ]
    },
    {
      "name": "Mombasa",
      "capital": "Mombasa City",
      "code": 1,
      "sub_counties": [
        "Changamwe",
        "Jomvu",
        "Kisauni",
        "Likoni",
        "Mvita",
        "Nyali"
      ]
    },
    {
      "name": "Murang'a",
      "capital": "Murang'a",
      "code": 21,
      "sub_counties": [
        "Gatanga",
        "Kahuro",
        "Kandara",
        "Kangema",
        "Kigumo",
        "Kiharu",
        "Mathioya",
        "Murang’a south"
      ]
    },
    {
      "name": "Nairobi",
      "capital": "Nairobi City",
      "code": 47,
      "sub_counties": [
        "Dagoretti North Sub County",
        "Dagoretti South Sub County ",
        "Embakasi Central Sub Count",
        "Embakasi East Sub County",
        "Embakasi North Sub County ",
        "Embakasi South Sub County",
        "Embakasi West Sub County",
        "Kamukunji Sub County",
        "Kasarani Sub County ",
        "Kibra Sub County ",
        "Lang'ata Sub County ",
        "Makadara Sub County",
        "Mathare Sub County ",
        "Roysambu Sub County ",
        "Ruaraka Sub County ",
        "Starehe Sub County ",
        "Westlands Sub County "
      ]
    },
    {
      "name": "Nakuru",
      "capital": "Nakuru",
      "code": 32,
      "sub_counties": [
        "Bahati",
        "Gilgil",
        "Kuresoi north",
        "Kuresoi south",
        "Molo",
        "Naivasha",
        "Nakuru town east",
        "Nakuru town west",
        "Njoro",
        "Rongai",
        "Subukia"
      ]
    },
    {
      "name": "Nandi",
      "capital": "Kapsabet",
      "code": 29,
      "sub_counties": [
        "Aldai",
        "Chesumei",
        "Emgwen",
        "Mosop",
        "Namdi hills",
        "Tindiret"
      ]
    },
    {
      "name": "Narok",
      "capital": "Narok",
      "code": 33,
      "sub_counties": [
        "Narok east",
        "Narok north",
        "Narok south",
        "Narok west",
        "Transmara east",
        "Transmara west"
      ]
    },
    {
      "name": "Nyamira",
      "capital": "Nyamira",
      "code": 46,
      "sub_counties": [
        "Borabu",
        "Manga",
        "Masaba north",
        "Nyamira north",
        "Nyamira south"
      ]
    },
    {
      "name": "Nyandarua",
      "capital": "Ol Kalou",
      "code": 18,
      "sub_counties": [
        "Kinangop",
        "Kipipiri",
        "Ndaragwa",
        "Ol Kalou",
        "Ol joro orok"
      ]
    },
    {
      "name": "Nyeri",
      "capital": "Nyeri",
      "code": 19,
      "sub_counties": [
        "Kieni east",
        "Kieni west",
        "Mathira east",
        "Mathira west",
        "Mkurweni",
        "Nyeri town",
        "Othaya",
        "Tetu"
      ]
    },
    {
      "name": "Samburu",
      "capital": "Maralal",
      "code": 25,
      "sub_counties": ["Samburu east", "Samburu north", "Samburu west"]
    },
    {
      "name": "Siaya",
      "capital": "Siaya",
      "code": 41,
      "sub_counties": [
        "Alego usonga",
        "Bondo",
        "Gem",
        "Rarieda",
        "Ugenya",
        "Unguja"
      ]
    },
    {
      "name": "Taita-Taveta",
      "capital": "Voi",
      "code": 6,
      "sub_counties": ["Mwatate", "Taveta", "Voi", "Wundanyi"]
    },
    {
      "name": "Tana River",
      "capital": "Hola",
      "code": 4,
      "sub_counties": ["Bura", "Galole", "Garsen"]
    },
    {
      "name": "Tharaka-Nithi",
      "capital": "Chuka",
      "code": 13,
      "sub_counties": [
        "Chuka",
        "Igambangobe",
        "Maara",
        "Muthambi",
        "Tharak north",
        "Tharaka south"
      ]
    },
    {
      "name": "Trans-Nzoia",
      "capital": "Kitale",
      "code": 26,
      "sub_counties": ["Cherangany", "Endebess", "Kiminini", "Kwanza", "Saboti"]
    },
    {
      "name": "Turkana",
      "capital": "Lodwar",
      "code": 23,
      "sub_counties": [
        "Loima",
        "Turkana central",
        "Turkana east",
        "Turkana north",
        "Turkana south"
      ]
    },
    {
      "name": "Uasin Gishu",
      "capital": "Eldoret",
      "code": 27,
      "sub_counties": [
        "Ainabkoi",
        "Kapseret",
        "Kesses",
        "Moiben",
        "Soy",
        "Turbo"
      ]
    },
    {
      "name": "Vihiga",
      "capital": "Vihiga",
      "code": 38,
      "sub_counties": ["Emuhaya", "Hamisi", "Luanda", "Sabatia", "vihiga"]
    },
    {
      "name": "Wajir",
      "capital": "Wajir",
      "code": 8,
      "sub_counties": [
        "Eldas",
        "Tarbaj",
        "Wajir East",
        "Wajir North",
        "Wajir South",
        "Wajir West"
      ]
    },
    {
      "name": "West Pokot",
      "capital": "Kapenguria",
      "code": 24,
      "sub_counties": [
        "Central Pokot",
        "North Pokot",
        "Pokot South",
        "West Pokot"
      ]
    }
  ];
}
