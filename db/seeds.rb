# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner: sophie)
Pet.create(name: "Nona", owner: sophie)

kali = Owner.create(name: "Kali")
Pet.create(name: "Dolly", owner: kali)
Pet.create(name: "Wolfie", owner: kali)

daddy = Owner.create(name: "Daddy")
Pet.create(name: "Beeker", owner: daddy)
Pet.create(name: "Mona", owner: kali)
