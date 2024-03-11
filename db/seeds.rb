user = User.create!(email:'admin@admin', password:'admin@admin', password_confirmation:'admin@admin', name:'admin', is_admin:true)


predmet1 = user.predmets.create!(name:"Diskretni struktury 2", adbreviation:"DISK1", status:"A", teacher:"Kolarik", color:"#eb4034")
predmet2 = user.predmets.create!(name:"Algoritmy 2", adbreviation:"ALGO 2", status:"A", teacher:"Osicka", color:"#ebe534")
predmet3 = user.predmets.create!(name:"Zaklady Programovani 2", adbreviation:"ZPC2", status:"A", teacher:"Vecerka", color:"#36ed2f")
predmet4 = user.predmets.create!(name:"Uvod do informacnich technologii", adbreviation:"UDITE", status:"A", teacher:"Trnecka", color:"#33e5e8")
predmet5 = user.predmets.create!(name:"Paradigmata programovani 2", adbreviation:"PP2", status:"A", teacher:"Krupka", color:"#c036e3")


Lecture.create!(predmet_name:"Algoritmy 2",teacher: "Osicka",predmet: predmet2, room: '2001', lecture_type:"Lectures",start_time: Time.new(2023, 12, 31, 9, 0, 0), length: 2.5, day: 'Thursday', is_stacked: false, is_checked: true)
Lecture.create!(predmet_name:"Algoritmy 2",teacher: "Urb|Fol",predmet: predmet2, room: '5002', lecture_type:"Exercise",start_time: Time.new(2022, 12, 31, 14, 15, 0), length: 1.5, day: 'Tuesday', is_stacked: true, is_checked: true)
Lecture.create!(predmet_name:"Algoritmy 2",teacher: "Urbanec",predmet: predmet2, room: '5004', lecture_type:"Exercise",start_time: Time.new(2022, 12, 31, 16, 00, 0), length: 1.5, day: 'Tuesday', is_stacked: false, is_checked: true)

Lecture.create!(predmet_name:"Diskretni struktury 1",teacher: "Kolarik", predmet: predmet1, room: '3003', lecture_type:"Lectures", start_time: Time.new(2023, 12, 31, 11, 30, 0), length: 2.5, day: 'Wednesday', is_stacked: false, is_checked: true)
Lecture.create!(predmet_name:"Diskretni struktury 1",teacher: "Jur|Kol", predmet: predmet1, room: '1127', lecture_type:"Exercise", start_time: Time.new(2023, 12, 31, 14, 15, 0), length: 1.5, day: 'Wednesday', is_stacked: true, is_checked: true)

Lecture.create!(predmet_name:"Paradigmata programovani 2",teacher: "Krupka Michal", predmet: predmet5, room: '5007', lecture_type:"Lectures", start_time: Time.new(2023, 12, 31, 16, 0, 0), length: 2.5, day: 'Thursday', is_stacked: false, is_checked: true)
Lecture.create!(predmet_name:"Paradigmata programovani 2",teacher: "Kru|Bal", predmet: predmet5, room: '5003', lecture_type:"Exercise", start_time: Time.new(2023, 12, 31, 12, 30, 0), length: 1.5, day: 'Tuesday', is_stacked: true, is_checked: true)
Lecture.create!(predmet_name:"Paradigmata programovani 2",teacher: "Laštovička ", predmet: predmet5, room: '5002', lecture_type:"Exercise", start_time: Time.new(2023, 12, 31, 9, 0, 0), length: 1.5, day: 'Wednesday', is_stacked: false, is_checked: true)

Lecture.create!(predmet_name:"Uvod do informacnich technologii",teacher: "Trnecka", predmet: predmet4, room: '2001', lecture_type:"Lectures", start_time: Time.new(2023, 12, 31, 9, 0, 0), length: 2.5, day: 'Monday', is_stacked: false, is_checked: true)
Lecture.create!(predmet_name:"Uvod do informacnich technologii",teacher: "Zacpal L", predmet: predmet4, room: '5002', lecture_type:"Exercise", start_time: Time.new(2023, 12, 31, 19, 30, 0), length: 1.5, day: 'Tuesday', is_stacked: false, is_checked: true)
Lecture.create!(predmet_name:"Uvod do informacnich technologii",teacher: "Zac | L,S", predmet: predmet4, room: '5002', lecture_type:"Exercise", start_time: Time.new(2023, 12, 31, 16, 0, 0), length: 1.5, day: 'Wednesday', is_stacked: true, is_checked: true)
Lecture.create!(predmet_name:"Uvod do informacnich technologii",teacher: "Zac | L,S", predmet: predmet4, room: '5002', lecture_type:"Exercise", start_time: Time.new(2023, 12, 31, 17, 45, 0), length: 1.5, day: 'Wednesday', is_stacked: true, is_checked: true)

Lecture.create!(predmet_name:"Zaklady Programovani 2",teacher: "Trneckova", predmet: predmet3, room: '5002', lecture_type:"Seminar", start_time: Time.new(2023, 12, 31, 11, 30, 0), length: 2.5, day: 'Monday', is_stacked: false, is_checked: true)
Lecture.create!(predmet_name:"Zaklady Programovani 2",teacher: "Osicka", predmet: predmet3, room: '5002', lecture_type:"Seminar", start_time: Time.new(2023, 12, 31, 14, 15, 0), length: 2.5, day: 'Monday', is_stacked: false, is_checked: true)
Lecture.create!(predmet_name:"Zaklady Programovani 2",teacher: "Vecerka", predmet: predmet3, room: '5004', lecture_type:"Seminar", start_time: Time.new(2023, 12, 31, 9, 45, 0), length: 2.5, day: 'Tuesday', is_stacked: false, is_checked: true)


# BETTER TO USE THE INCLUDED DEFAULT TIMETABLES