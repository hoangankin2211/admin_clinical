import 'package:flutter/material.dart';

class FakeData {
  static const List<String> topData = [
    'All',
    'General',
    'Dentist',
    'Nutritionist',
    'Neuroloe',
    'Pediatric',
    'Radiolonist',
  ];
  static const List<int> rating = [6, 5, 4, 3, 2, 1];
  static const List<String> articles = [
    "Newest",
    "Health",
    "Covid-19",
    "Lifestyle",
  ];

  static List<Map<String, dynamic>> fakeDataArticles = [
    {
      "image":
          "https://cdn.georgeinstitute.org/sites/default/files/styles/width1920_fallback/public/2022-09/alcohol-pregnancy.jpg",
      "mainTitle": "'Glass baby' makes future parents think before they drink",
      "type": 1,
      "title":
          "A hard-hitting awareness campaign on the dangers of drinking during pregnancy successfully increased concerns about unborn babies’ exposure to alcohol and discouraged women from drinking while pregnant.The campaign, featuring a glass mould of a fetus being filled with red wine through a glass placenta, also made the majority of those who saw it more likely to support others not to drink during pregnancy. Professor Simone Pettigrew said that while a national recommendation of zero alcohol had been in place for over a decade, over a third of women drink at least some alcohol during pregnancy. “Our research shows that well-designed campaigns on the effects of alcohol during pregnancy can really influence the drinking behaviour of future parents,” she said. Alcohol used during pregnancy passes through the placenta, leading to similar blood alcohol levels for the developing fetus and the mother. It can affect a baby’s growth and can lead to a range of lifelong problems - collectively known as foetal alcohol spectrum disorder (FASD) - affecting things like memory, attention, reasoning and impulsivity. It is also associated with stillbirth. ",
      "time": DateTime.now(),
      "readers": 4.3,
      "like": 3.4,
    },
    {
      "image":
          "https://cdn.georgeinstitute.org/sites/default/files/styles/width1920_fallback/public/2022-08/an-apple-food-medicine-1087538962-crop.jpg",
      "mainTitle": "An apple a day on doctors' orders keeps ill health away",
      "type": 0,
      "title":
          "Fresh fruit and vegetables prescribed by doctors could be an effective way to improve the health of Australians with type 2 diabetes, according to a new study published today in the Journal of Nutrition Researchers at The George Institute for Global Health and UNSW Sydney found that people with type 2 diabetes and high blood sugar who took part in a ‘produce prescription’ program over 12 weeks ate nearly two extra servings of fruit and vegetables a day. They also lost 1.7kg in weight and saw a ten percent drop in their LDL (low-density lipoprotein or the ‘bad cholesterol’ that causes heart disease). Lead author Jason Wu, Head of Nutrition Science at The George Institute and Professor at UNSW Medicine & Health’s School of Population Health, said this was an important first study in Australia demonstrating the potential of ‘food as medicine’ to help doctors and patients better manage diet-related diseases.",
      "time": DateTime.now(),
      "readers": 4.3,
      "like": 3.4,
    },
    {
      "image":
          "https://cdn.georgeinstitute.org/sites/default/files/styles/width1920_fallback/public/2022-08/heart-attack-salt-997796860.jpg",
      "mainTitle":
          "Dietary salt substitutes lower risk of heart attack, stroke and death",
      "type": 2,
      "title":
          "Dietary salt substitutes lower the risk of heart attack, stroke, and death from all causes and cardiovascular disease, finds a pooled data analysis of the available evidence, published online in the journal Heart.The beneficial effects of these substitutes are likely to apply to people all around the world, say the researchers.Cardiovascular disease is the leading cause of death worldwide, and high blood pressure is a major risk for an early death. A diet high in sodium and low in potassium is known to drive up blood pressure. Around 1.28 billion people around the world have high blood pressure, although more than half of these are undiagnosed, say the researchers.Salt substitutes, in which a proportion of sodium chloride (NaCl) is replaced with potassium chloride (KCl), are known to help lower blood pressure. A recently published large study from China (Salt Substitute and Stroke Study; SSaSS) found that salt substitutes cut the risk of heart attacks, stroke, and early death, but it was unclear whether these benefits would apply to people in other parts of the world.In a bid to shed light on this, the researchers trawled research databases looking for randomised clinical trials published up to the end of August 2021 and reporting on the effects of a salt substitute on blood pressure, cardiovascular health, and early death.",
      "time": DateTime.now(),
      "readers": 4.3,
      "like": 3.4,
    },
    {
      "image":
          "https://cdn.georgeinstitute.org/sites/default/files/styles/width1920_fallback/public/2022-07/stroke-women-emergency-938820292.jpg",
      "mainTitle":
          "Women with stroke disadvantaged in critical treatment time window",
      "type": 3,
      "title":
          "Despite women with stroke being more likely than men to arrive at the hospital by ambulance, their care is less likely to follow a smooth pathway of care along the way, according to new research.There was also an age effect, with ambulance staff more likely to miss a stroke diagnosis in women under the age of 70 years than they did in younger men.Lead author Dr Xia Wang, Research Fellow at The George Institute for Global Health, said women typically have worse functional outcomes after stroke and require more supportive care than men, so ensuring they receive best practice care is important.",
      "time": DateTime.now(),
      "readers": 4.3,
      "like": 3.4,
    }
  ];

  static List<Map<String, dynamic>> fakeDataDoctor = [
    {
      "index": 0,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
      "name": "Nguyen Minh Hung",
      "type": "Dentist",
      "date": DateTime.now(),
      "exp": 10,
      "ratings": 4.8,
    },
    {
      "index": 1,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
      "name": "Truong Huynh Duc Hoang",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 2,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
      "name": "Nguyen Trung Hieu",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 3,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
      "name": "Phan Thien Nhan",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 2,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
      "name": "Nguyen Trung Hieu",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 3,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
      "name": "Phan Thien Nhan",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 2,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
      "name": "Nguyen Trung Hieu",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 3,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
      "name": "Phan Thien Nhan",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 2,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
      "name": "Nguyen Trung Hieu",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 3,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
      "name": "Phan Thien Nhan",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 2,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
      "name": "Nguyen Trung Hieu",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    },
    {
      "index": 3,
      "image":
          "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
      "name": "Phan Thien Nhan",
      "type": "Nerontist",
      "date": DateTime.now(),
      "exp": 8,
      "ratings": 2.8,
    }
  ];

  static const List<Map<String, dynamic>> fakeMedicalDepartment = [
    {
      "id": 0,
      "name": "Dentist",
      "ratings": 3,
      "count": 100,
    },
    {
      "id": 1,
      "name": "Neronist",
      "ratings": -1,
      "count": 200,
    },
    {
      "id": 2,
      "name": "Dentist",
      "ratings": 2,
      "count": 300,
    },
    {
      "id": 3,
      "name": "Nutrition",
      "ratings": -4,
      "count": 400,
    },
  ];
  static List<Map<String, dynamic>> fakeDataMedicine = [
    {
      "name": "Shakira lala",
      "image": "assets/images/doctor1.png",
      "rm": 100,
      "s": 200,
      "type": "Thuong Dau dau",
      "price": 200,
    },
    {
      "name": "Shakira lala1",
      "image": "assets/images/doctor2.png",
      "rm": 130,
      "s": 200,
      "type": "Thuong Dau Bung",
      "price": 300,
    },
    {
      "name": "Shakira lala2",
      "image": "assets/images/doctor3.png",
      "rm": 110,
      "s": 200,
      "type": "Thuong Dau Chan",
      "price": 400,
    },
    {
      "name": "Shakira lala3",
      "image": "assets/images/doctor2.png",
      "rm": 400,
      "s": 200,
      "type": "Thuong Dau tay",
      "price": 500,
    },
    {
      "name": "Shakira lala4",
      "image": "assets/images/doctor1.png",
      "rm": 200,
      "s": 20,
      "type": "Thuong Dau chim",
      "price": 600,
    }
  ];
  static List<Map<String, dynamic>> fakeDataMedicalHistory = [
    {
      "id": 0,
      "Medical": "Covid 19",
      "Doctor": "Nguyen Minh Hung",
      "cr": "Phong Kham da khoa so 1",
      "date": DateTime.now(),
      "status": 0,
    },
    {
      "id": 1,
      "Medical": "Toothdath",
      "Doctor": "Truong Huynh Duc Hoang",
      "cr": "Phong Kham da khoa so 1",
      "date": DateTime.now(),
      "status": 1,
    },
    {
      "id": 2,
      "Medical": "Headath",
      "Doctor": "Nguyen Trung Hieu",
      "cr": "Phong Kham da khoa so 1",
      "date": DateTime.now(),
      "status": 0,
    },
  ];
}
