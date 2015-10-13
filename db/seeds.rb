jenny = User.create(email: "leejenny0403@gmail.com", name: "Jenny Lee", password: "jenny", age: 24, gender: "female", description: "looking for someone to play tennis with me occasionally.  Would also like to try some olympics lifts :)")
mark = User.create(email: "mark.kilpatrick.miller@gmail.com", name: "Mark Miller", password: "mark", age: 24, gender: "male", description: "Looking for someone to lift with 6 nights a week.  I'd also like to play ball occasionally.")
navraj = User.create(email: "nnat425@gmail.com", name: "Navraj Nat", password: "navraj", age: 22, gender: "male", description: "Looking to get back into the gym.  I know the basics but am looking for someone trying to get toned for beach body season")

jenny.locations.create(latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)
mark.locations.create(latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)
navraj.locations.create(latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)

lifting = Activity.create(name: "Lifting", image: "https://pixabay.com/static/uploads/photo/2015/02/27/17/44/weights-652488_640.jpg")
tennis = Activity.create(name: "Tennis", image: "https://pixabay.com/static/uploads/photo/2015/09/10/19/36/tennis-934841_640.jpg")
basketball = Activity.create(name: "Basketball", image: "https://pixabay.com/static/uploads/photo/2013/05/02/21/23/uss-nimitz-108622_640.jpg")
spin = Activity.create(name: "Spin", image: "http://heuserhealth.com/wp-content/uploads/2014/01/iStock_000012790937Medium.jpg")
soccer = Activity.create(name: "Soccer", image: "https://pixabay.com/static/uploads/photo/2014/05/21/15/28/soccer-349821_640.jpg")
running = Activity.create(name: "Running", image: "https://res.cloudinary.com/mapmyfitness/image/upload/f167687b598b4deb85a33a0af8d0083c")

mark.activities << lifting
jenny.activities << lifting
navraj.activities << lifting
jenny.activities << tennis
mark.activities << basketball
navraj.activities << basketball
jenny.activities << spin
mark.activities << spin
navraj.activities << soccer


for x in 0..100
  if x % 2 == 1
    new_user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password(8), age: Faker::Number.between(15, 45), gender: "male", description: Faker::Hacker.say_something_smart)
    new_user.activities << lifting
    new_user.locations.create(latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)
  else
    new_user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password(8), age: Faker::Number.between(15, 45), gender: "female", description: Faker::Hacker.say_something_smart)
    new_user.activities << spin
    new_user.locations.create(latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)
  end

  if x % 7 == 0
    new_user.activities << tennis
    new_user.activities << running
  end

  if x % 4 == 0
    new_user.activities << basketball
  end

  if x % 11 == 0
    new_user.activities << soccer
  end
end