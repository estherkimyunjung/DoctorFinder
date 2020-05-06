
User.destroy_all 
Favorite.destroy_all
Doctor.destroy_all 
Specialty.destroy_all 
Location.destroy_all 

# url="https://api.betterdoctor.com/2016-03-01/doctors?location=37.773,-122.413,100&skip=2&limit=10&user_key='8ed303f4adaf6ae910d05c6257bd5cb3"

# uri = URI.parse(url)
# response = Net::HTTP.get_response(uri)
# data = JSON.parse(response.body)

# response = HTTParty.get(url)

u1=User.create(name: "Esther")
u2=User.create(name: "Stephanie")
u3=User.create(name: "James")
u4=User.create(name: "Johnathan")
u5=User.create(name: "Kevin")
u6=User.create(name: "Susan")

l1=Location.create(address:"30803 Crest View Terrace", city: "Fulshear", state: "TX", zip_code: 77441)
l2=Location.create(address:"708 Main St", city: "Houston", state: "TX", zip_code: 77002)
l3=Location.create(address:"11 Broadway 2nd Floor", city: "New York", state: "NY", zip_code: 10004)
l4=Location.create(address:"440 Terry Avenue North", city: "Seattle", state: "WA", zip_code: 98109)
l5=Location.create(address:"300 W 6th St", city: "Austin", state: "TX", zip_code: 78701)
l6=Location.create(address:"1600 Amphitheatre Parkway", city: "Mountain View", state: "CA", zip_code: 94043)

s1=Specialty.create(name: "Pediatrics")
s2=Specialty.create(name: "Internal")
s3=Specialty.create(name: "Family Physician")
s4=Specialty.create(name: "Obstetrics")
s5=Specialty.create(name: "Psychiatry")
s6=Specialty.create(name: "surgery")

d1=Doctor.create(name: "Erin Bolivar", location_id: l1.id, phone_number: "713-111-1111", specialty_id: s5.id, gender: "Female")
d2=Doctor.create(name: "Daniel Schatz", location_id: l2.id, phone_number: "713-123-2222", specialty_id: s2.id, gender: "Male")
d3=Doctor.create(name: "Cassandra Wertz", location_id: l3.id, phone_number: "713-222-3333", specialty_id: s3.id, gender: "Female")
d4=Doctor.create(name: "Alejandro Mora", location_id: l1.id, phone_number: "713-333-5555", specialty_id: s5.id, gender: "Male")
d5=Doctor.create(name: "John Paulsel", location_id: l6.id, phone_number: "713-321-1155", specialty_id: s6.id, gender: "Male")
d6=Doctor.create(name: "Onyinye Agim", location_id: l3.id, phone_number: "832-321-1155", specialty_id: s3.id, gender: "Male")
d7=Doctor.create(name: "Diana Sutton", location_id: l4.id, phone_number: "281-333-5555", specialty_id: s1.id, gender: "Female")
d8=Doctor.create(name: "Jesus Pimentel", location_id: l2.id, phone_number: "832-111-1111", specialty_id: s2.id, gender: "Male")
d9=Doctor.create(name: "Mark Massey", location_id: l5.id, phone_number: "832-445-1111", specialty_id: s4.id, gender: "Male")
d10=Doctor.create(name: "Irvin Tantuc", location_id: l5.id, phone_number: "713-484-1321", specialty_id: s6.id, gender: "Male")
d11=Doctor.create(name: "Daniel Scrieber", location_id: l6.id, phone_number: "713-222-2572", specialty_id: s1.id, gender: "Male")
d12=Doctor.create(name: "Alannis Boom", location_id: l3.id, phone_number: "713-236-8612", specialty_id: s2.id, gender: "Female")
d13=Doctor.create(name: "Gretchen Sora", location_id: l2.id, phone_number: "713-394-5595", specialty_id: s4.id, gender: "Female")
d14=Doctor.create(name: "Elijah Brushel", location_id: l1.id, phone_number: "713-241-7894", specialty_id: s3.id, gender: "Male")
d15=Doctor.create(name: "Owen Splater", location_id: l3.id, phone_number: "832-317-1875", specialty_id: s1.id, gender: "Male")
d16=Doctor.create(name: "Melanie Johnson", location_id: l4.id, phone_number: "346-313-5755", specialty_id: s2.id, gender: "Female")
d17=Doctor.create(name: "Ed Wong", location_id: l4.id, phone_number: "832-101-7845", specialty_id: s6.id, gender: "Male")
d18=Doctor.create(name: "Richard Yeh", location_id: l5.id, phone_number: "346-444-8751", specialty_id: s4.id, gender: "Male")


f1=Favorite.create(user_id: u1.id, doctor_id: d3.id, rating: 5, comments: "I enjoyed her direct approach and her ability to quickly understand my situation.")
f2=Favorite.create(user_id: u2.id, doctor_id: d2.id, rating: 4, comments: "I would highly recommend.")
f3=Favorite.create(user_id: u2.id, doctor_id: d8.id, rating: 3, comments: "I very much appreciate the on time performance of my appointment.")
f4=Favorite.create(user_id: u4.id, doctor_id: d1.id, rating: 4, comments: "All my visits with this doctor were good and left me in a happy mood.")
f5=Favorite.create(user_id: u3.id, doctor_id: d7.id, rating: 5, comments: "The reviews intrigued me which is why i saw her.")
f6=Favorite.create(user_id: u5.id, doctor_id: d8.id, rating: 4, comments: "I would highly recommend Dr. Jesus.")
f7=Favorite.create(user_id: u5.id, doctor_id: d4.id, rating: 5, comments: "He was very professional and polite! Would strongly recommend.")


binding.pry 
0
