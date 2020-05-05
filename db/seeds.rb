
User.destroy_all 
Favs_list.destroy_all
Doctor.destroy_all 
Specialty.destroy_all 
Location.destroy_all 

# url="https://api.betterdoctor.com/2016-03-01/doctors?name=name%20&specialty_uid=specialty%20&location=37.773%2C-122.413%2C100&user_location=37.773%2C-122.413&skip=0&limit=10&user_key=8ed303f4adaf6ae910d05c6257bd5cb3"

# # uri = URI.parse(url)
# # response = Net::HTTP.get_response(uri)
# # data = JSON.parse(response.body)

# response = HTTParty.get(url)
# binding.pry 
# 0

u1=User.create(name: "Esther")
u2=User.create(name: "Stephanie")

l1=Location.create(address:"30803 Crest View Terrace", "77441")
l2=Location.create(address:"77450")
l3=Location.create(address:"San Antonio")

s1=Specialty.create(name: "Pediatrics")
s2=Specialty.create(name: "Internal")
s3=Specialty.create(name: "General")

d1=Doctor.create(name: "Dr. A", location_id: l1.id, phone_number: "713-000-0000", specialty_id: s1.id)
d2=Doctor.create(name: "Dr. B", location_id: l2.id, phone_number: "713-000-0000", specialty_id: s2.id)
d3=Doctor.create(name: "Dr. C", location_id: l3.id, phone_number: "713-000-0000", specialty_id: s3.id)
d4=Doctor.create(name: "Dr. D", location_id: l1.id, phone_number: "713-000-0000", specialty_id: s1.id)
d5=Doctor.create(name: "Dr. E", location_id: l2.id, phone_number: "713-000-0000", specialty_id: s2.id)
d6=Doctor.create(name: "Dr. F", location_id: l3.id, phone_number: "713-000-0000", specialty_id: s3.id)


f1=Favs_list.create(user_id: u1.id, doctor_id: d1.id)
f2=Favs_list.create(user_id: u2.id, doctor_id: d2.id)


