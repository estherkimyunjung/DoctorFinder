
User.destroy_all 
Favs_list.destroy_all
Doctor.destroy_all 
Specialty.destroy_all 
Location.destroy_all 

u1=User.create(name: "Esther")
u2=User.create(name: "Stephanie")

l1=Location.create(address:"Houston")
l2=Location.create(address:"Austin")
l3=Location.create(address:"San Antonio")

s1=Specialty.create(name: "Pediatrics")
s2=Specialty.create(name: "Internal")
s3=Specialty.create(name: "General")

d1=Doctor.create(name: "Dr. A", location_id: l1.id, phone_number: "713-000-0000", specialty_id: s1.id)
d2=Doctor.create(name: "Dr. B", location_id: l2.id, phone_number: "713-000-0000", specialty_id: s2.id)
d3=Doctor.create(name: "Dr. C", location_id: l3.id, phone_number: "713-000-0000", specialty_id: s3.id)

f1=Favs_list.create(user_id: u1.id, doctor_id: d1.id)
f2=Favs_list.create(user_id: u2.id, doctor_id: d2.id)

binding.pry 
0
